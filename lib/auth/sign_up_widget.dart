import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:nhost_flutter_auth/nhost_flutter_auth.dart';
import 'package:nhost_ui/nhost_ui.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget(
      {Key? key,
      required this.title,
      required this.client,
      required this.onSignedUp})
      : super(key: key);

  final String title;
  final NhostClient client;
  final void Function() onSignedUp;

  @override
  State<SignUpWidget> createState() => _State();
}

class _State extends State<SignUpWidget> with FutureStateMixin<SignUpWidget> {
  late TextEditingController _emailController;
  late TextEditingController _password1Controller;
  late bool _password1Visible = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _password1Controller = TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    return AwColumn(
      spacing: 4,
      children: <Widget>[
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.email_outlined),
            labelText: "Email address",
            hintText: 'Enter your email address for sign in',
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return value == null ||
                    value.isEmpty ||
                    !EmailValidator.validate(value)
                ? "Email address is required"
                : null;
          },
          onChanged: (value) {
            setState(() {});
          },
        ),
        TextFormField(
          controller: _password1Controller,
          obscureText: !_password1Visible,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.password_outlined),
            labelText: 'password',
            hintText: 'Enter your password for sign in',
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
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          onPressed: !running &&
                  _emailController.text.isNotEmpty &&
                  EmailValidator.validate(_emailController.text) &&
                  _password1Controller.text.isNotEmpty
              ? () async {
                  await run(
                    () async {
                      try {
                        await widget.client.auth.signUp(email: _emailController.text, password: _password1Controller.text);
                        widget.onSignedUp();
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
              const Icon(Icons.person_add_outlined),
              Text(running ? "Signning up..." : "Sign up"),
            ],
          ),
        ),
      ],
    );
  }
}
