import 'dart:developer' as developer;
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:appwrite_ui/appwrite_ui.dart';

class PasswordUpdateWidget extends StatefulWidget {
  const PasswordUpdateWidget(
      {Key? key,
      required this.title,
      required this.client,
      required this.onUpdated})
      : super(key: key);

  final String title;
  final Client client;
  final void Function(User) onUpdated;

  @override
  State<PasswordUpdateWidget> createState() => _State();
}

class _State extends State<PasswordUpdateWidget> with FutureStateMixin<PasswordUpdateWidget> {
  late TextEditingController _password1Controller;
  late TextEditingController _password2Controller;
  late bool _password1Visible = false;
  late bool _password2Visible = false;

  @override
  void initState() {
    super.initState();
    _password1Controller = TextEditingController();
    _password2Controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AwColumn(
      spacing: 4,
      children: <Widget>[
        TextFormField(
          controller: _password1Controller,
          obscureText: !_password1Visible,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.password_outlined),
            labelText: 'old password',
            hintText: 'Enter old password',
            suffixIcon: IconButton(
              icon: Icon(
                  _password1Visible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _password1Visible = !_password1Visible;
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
        TextFormField(
          controller: _password2Controller,
          obscureText: !_password1Visible,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.password_outlined),
            labelText: 'new password',
            hintText: 'Enter your new password',
            suffixIcon: IconButton(
              icon: Icon(
                  _password2Visible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _password2Visible = !_password2Visible;
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
                  _password1Controller.text.isNotEmpty &&
                  _password1Controller.text.isNotEmpty
              ? () async {
                  await run(
                    () async {
                      try {
                        Account account = Account(widget.client);
                        User user = await account.updatePassword(
                          oldPassword: _password1Controller.text,
                          password: _password2Controller.text,
                        );
                        widget.onUpdated(user);
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
              const Icon(Icons.password_outlined),
              Text(running ? "Updating password..." : "Update password"),
            ],
          ),
        ),
      ],
    );
  }
}
