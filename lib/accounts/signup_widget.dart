import 'dart:developer' as developer;
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

import 'package:appwrite_ui/appwrite_ui.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget(
      {Key? key,
      required this.title,
      required this.client,
      required this.onSignedup})
      : super(key: key);

  final String title;
  final Client client;
  final void Function(User) onSignedup;

  @override
  State<SignupWidget> createState() => _State();
}

class _State extends State<SignupWidget> with FutureStateMixin<SignupWidget> {
  late TextEditingController _usernameController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _password1Controller;
  late TextEditingController _password2Controller;
  late bool _password1Visible = false;
  late bool _password2Visible = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _password1Controller = TextEditingController();
    _password2Controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AwColumn(
      spacing: 4,
      children: <Widget>[
        TextFormField(
          controller: _usernameController,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.person_outlined),
            labelText: "username",
            hintText: 'Enter your username',
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return value == null || value.isEmpty
                ? "username is required"
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
            labelText: "first and last name",
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
                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)
                ? "email is required"
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
            prefixIcon: const Icon(Icons.lock_outlined),
            labelText: 'password',
            hintText: 'Enter your password',
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
          obscureText: !_password2Visible,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outlined),
            labelText: 'confirm password',
            hintText: 'Enter your password again',
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
        TextButton(
          onPressed: !running &&
                  _usernameController.text.isNotEmpty &&
                  _emailController.text.isNotEmpty &&
                  _nameController.text.isNotEmpty &&
                  _password1Controller.text.isNotEmpty &&
                  _password1Controller.text == _password2Controller.text
              ? () async {
                  await run(
                    () async {
                      try {
                        Account account = Account(widget.client);
                        User user = await account.create(
                          userId: _usernameController.text,
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _password1Controller.text,
                        );
                        widget.onSignedup(user);
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
              const Icon(Icons.check_outlined),
              Text(running ? "Signning up..." : "Sign up"),
            ],
          ),
        ),
      ],
    );
  }
}
