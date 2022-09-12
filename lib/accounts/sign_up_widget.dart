import 'dart:developer' as developer;
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:appwrite_ui/appwrite_ui.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget(
      {Key? key,
      required this.title,
      required this.client,
      required this.onSignedUp})
      : super(key: key);

  final String title;
  final Client client;
  final void Function(User) onSignedUp;

  @override
  State<SignUpWidget> createState() => _State();
}

class _State extends State<SignUpWidget> with FutureStateMixin<SignUpWidget> {
  late TextEditingController _emailController;
  late TextEditingController _nameController;
  late TextEditingController _password1Controller;
  late bool _password1Visible = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _nameController = TextEditingController();
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
          controller: _nameController,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.person_outlined),
            labelText: "First and last name",
            hintText: 'Enter your first and last name',
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return value == null || value.isEmpty ? "name is required" : null;
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
                  _nameController.text.isNotEmpty &&
                  EmailValidator.validate(_emailController.text) &&
                  _password1Controller.text.isNotEmpty
              ? () async {
                  await run(
                    () async {
                      try {
                        Account account = Account(widget.client);
                        User user = await account.create(
                          userId: "unique()",
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _password1Controller.text,
                        );
                        widget.onSignedUp(user);
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
              const Icon(Icons.person_add_outlined),
              Text(running ? "Signning up..." : "Sign up"),
            ],
          ),
        ),
      ],
    );
  }
}
