import 'dart:developer' as developer;
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:appwrite_ui/appwrite_ui.dart';

class PasswordConfirmWidget extends StatefulWidget {
  const PasswordConfirmWidget({
    Key? key,
    required this.title,
    required this.client,
    required this.onConfirm,
  }) : super(key: key);

  final String title;
  final Client client;
  final void Function() onConfirm;

  @override
  State<PasswordConfirmWidget> createState() => _State();
}

class _State extends State<PasswordConfirmWidget>
    with FutureStateMixin<PasswordConfirmWidget> {
  late TextEditingController _passwordController;
  late bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AwColumn(
      spacing: 0,
      children: <Widget>[
        TextFormField(
          controller: _passwordController,
          obscureText: !_passwordVisible,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.password_outlined),
            labelText: 'password',
            hintText: 'Enter your new password',
            suffixIcon: IconButton(
              icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return value == null || value.isEmpty
                ? "Password is required"
                : null;
          },
          onChanged: (value) {
            setState(() {});
          },
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          onPressed: !running &&
                  _passwordController.text.isNotEmpty
              ? () async {
                  await run(
                    () async {
                      try {
                        /*
                        TODO
                        */
                        widget.onConfirm();
                      } on AppwriteException catch (e) {
                        developer.log(e.toString());
                      }
                    },
                  );
                }
              : null,
          child: AwRow(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              const Icon(Icons.lock_reset),
              Text(running ? "Updating password..." : "Update password"),
            ],
          ),
        ),
      ],
    );
  }
}
