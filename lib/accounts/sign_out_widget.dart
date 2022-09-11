import 'dart:developer' as developer;
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

import 'package:appwrite_ui/appwrite_ui.dart';

class SignOutWidget extends StatefulWidget {
  const SignOutWidget({
    Key? key,
    required this.title,
    required this.client,
    this.session,
    required this.onSignedOut,
  }) : super(key: key);

  final String title;
  final Client client;
  final Session? session;
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
          onPressed: !running && widget.session != null
              ? () async {
                  await run(
                    () async {
                      try {
                        Account account = Account(widget.client);
                        await account.deleteSession(
                            sessionId: widget.session!.$id);
                        widget.onSignedOut();
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
              const Icon(Icons.lock_outline),
              Text(running ? "Signning out..." : "Sign out"),
            ],
          ),
        ),
      ],
    );
  }
}
