import 'dart:developer' as developer;
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:appwrite_ui/appwrite_ui.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({
    Key? key,
    required this.title,
    required this.client,
    required this.onSignedIn,
  }) : super(key: key);

  final String title;
  final Client client;
  final void Function(User, Session) onSignedIn;

  @override
  State<SignInWidget> createState() => _State();
}

class _State extends State<SignInWidget> with FutureStateMixin<SignInWidget> {
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
        TextFormField(
          controller: _passwordController,
          obscureText: !_passwordVisible,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.password_outlined),
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
        ElevatedButton(
          onPressed: !running &&
                  _emailController.text.isNotEmpty &&
                  EmailValidator.validate(_emailController.text) &&
                  _passwordController.text.isNotEmpty
              ? () async {
                  await run(
                    () async {
                      try {
                        Account account = Account(widget.client);
                        Session session = await account.createEmailSession(
                            email: _emailController.text,
                            password: _passwordController.text);
                        User user = await account.get();
                        developer.log('user=$user, session=$session');
                        widget.onSignedIn(user, session);
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
              const Icon(Icons.lock_open_outlined),
              Text(running ? "Signning up..." : "Sign in"),
            ],
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        AwRow(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          spacing: 8,
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text('Forgot password?'),
                  TextButton(
                    onPressed: !running
                        ? () async {
                            Navigator.pushNamed(
                                context, "/accounts/password/reset");
                          }
                        : null,
                    child: AwRow(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 8,
                      children: const [
                        Icon(Icons.password_outlined),
                        Text("Update password"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Text('No account?'),
                  TextButton(
                    onPressed: !running
                        ? () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SignUpPage(
                                    title: 'Sign up',
                                    client: widget.client,
                                    onSignedUp: (User user) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) {
                                            return MessagePage(
                                              title: 'A email sent',
                                              messageText:
                                                  'A email sent to ${user.email}\n'
                                                  'Open email and verify link',
                                              confirmText: 'Confirm',
                                              onConfirm: () {
                                                Navigator.pop(context);
                                                _emailController.text =
                                                    user.email;
                                              },
                                            );
                                          },
                                        ),
                                      );
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
                        Icon(Icons.person_add_outlined),
                        Text("Sign up"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
