import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nhost_sdk/nhost_sdk.dart';
import 'package:nhost_ui/nhost_ui.dart';

class SignOutWidget extends StatefulWidget {
  const SignOutWidget({
    Key? key,
    required this.title,
    required this.client,
    required this.onSignedOut,
  }) : super(key: key);

  final String title;
  final NhostClient client;
  final void Function() onSignedOut;

  @override
  State<SignOutWidget> createState() => _State();
}

class _State extends State<SignOutWidget> with FutureStateMixin<SignOutWidget> {
  @override
  Widget build(BuildContext context) {
    return AwColumn(
      spacing: 0,
      children: <Widget>[
        ElevatedButton(
          onPressed: !running
              ? () async {
                  await run(
                    () async {
                      try {
                        await widget.client.auth.signOut();
                        widget.onSignedOut();
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
              const Icon(Icons.lock_outline),
              Text(running ? "Signning out..." : "Sign out"),
            ],
          ),
        ),
      ],
    );
  }
}
