import 'dart:developer' as developer;
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

import 'package:appwrite_ui/appwrite_ui.dart';

class SigninWidget extends StatefulWidget {
  const SigninWidget(
      {Key? key,
      required this.title,
      required this.client,
      required this.onSignedin})
      : super(key: key);

  final String title;
  final Client client;
  final void Function(Session) onSignedin;

  @override
  State<SigninWidget> createState() => _State();
}

class _State extends State<SigninWidget> with FutureStateMixin<SigninWidget> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
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
          controller: _passwordController,
          obscureText: !_passwordVisible,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outlined),
            labelText: 'password',
            hintText: 'Enter your password',
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
        TextButton(
          onPressed: !running &&
                  _emailController.text.isNotEmpty &&
                  _passwordController.text.isNotEmpty
              ? () async {
                  await run(
                    () async {
                      try {
                        Account account = Account(widget.client);
                        Session session = await account.createEmailSession(
                            email: _emailController.text,
                            password: _passwordController.text);
                        developer.log(session.toString());
                        widget.onSignedin(session);
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
              Text(running ? "Signning up..." : "Sign in"),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: !running ? () async {} : null,
              child: AwRow(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: const [
                  Icon(Icons.check_outlined),
                  Text("Fogot password?"),
                ],
              ),
            ),
            TextButton(
              onPressed: !running
                  ? () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignupPage(
                              title: 'Sign up',
                              client: widget.client,
                              onSignedup: (User user) {
                                Navigator.pop(context);
                                _emailController.text = user.email;
                              },
                            );
                          },
                        ),
                      );
                    }
                  : null,
              child: AwRow(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: const [
                  Icon(Icons.check_outlined),
                  Text("Sign up"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
