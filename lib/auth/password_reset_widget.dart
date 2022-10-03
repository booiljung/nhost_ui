import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:nhost_sdk/nhost_sdk.dart';
import 'package:nhost_ui/nhost_ui.dart';

class PasswordResetWidget extends StatefulWidget {
  const PasswordResetWidget({
    Key? key,
    required this.title,
    required this.client,
    required this.onReset,
  }) : super(key: key);

  final String title;
  final NhostClient client;
  final void Function() onReset;

  @override
  State<PasswordResetWidget> createState() => _State();
}

class _State extends State<PasswordResetWidget>
    with FutureStateMixin<PasswordResetWidget> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AwColumn(
      spacing: 0,
      children: <Widget>[
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.email_outlined),
            labelText: "email",
            hintText: 'Enter your email',
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return value == null ||
                    value.isEmpty ||
                    !EmailValidator.validate(value)
                ? "email is required"
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
                  _emailController.text.isNotEmpty &&
                  EmailValidator.validate(_emailController.text)
              ? () async {
                  await run(
                    () async {
                      try {
                        await widget.client.auth.resetPassword(email: _emailController.text);
                        widget.onReset();
                      } on ApiException catch (e) {
                        developer.log(e.toString());
                      } on http.ClientException catch (e) {
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
              Text(running ? "Resetting password..." : "Reset password"),
            ],
          ),
        ),
      ],
    );
  }
}
