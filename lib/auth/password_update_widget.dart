import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:nhost_sdk/nhost_sdk.dart';
import 'package:nhost_ui/nhost_ui.dart';
import 'package:flutter/material.dart';

class PasswordUpdateWidget extends StatefulWidget {
  const PasswordUpdateWidget(
      {Key? key,
      required this.title,
      required this.client,
      required this.onUpdated})
      : super(key: key);

  final String title;
  final NhostClient client;
  final void Function() onUpdated;

  @override
  State<PasswordUpdateWidget> createState() => _State();
}

class _State extends State<PasswordUpdateWidget> with FutureStateMixin<PasswordUpdateWidget> {
  late TextEditingController _password1Controller;
  late bool _password1Visible = false;

  @override
  void initState() {
    super.initState();
    _password1Controller = TextEditingController();
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
            labelText: 'new password',
            hintText: 'Enter your new password',
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
                  _password1Controller.text.isNotEmpty &&
                  _password1Controller.text.isNotEmpty
              ? () async {
                  await run(
                    () async {
                      try {
                        await widget.client.auth.changePassword(newPassword: _password1Controller.text);
                        widget.onUpdated();
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
              const Icon(Icons.password_outlined),
              Text(running ? "Updating password..." : "Update password"),
            ],
          ),
        ),
      ],
    );
  }
}
