import 'dart:developer' as developer;
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

import 'package:appwrite_ui/appwrite_ui.dart';

class SignoutWidget extends StatefulWidget {
  const SignoutWidget({
    Key? key,
    required this.title,
    required this.client,
    this.session,
    required this.onSignedout,
  }) : super(key: key);

  final String title;
  final Client client;
  final Session? session;
  final void Function() onSignedout;

  @override
  State<SignoutWidget> createState() => _State();
}

class _State extends State<SignoutWidget> with FutureStateMixin<SignoutWidget> {
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
                        widget.onSignedout();
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
