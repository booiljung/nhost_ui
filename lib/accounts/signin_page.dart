import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

import 'package:appwrite_ui/appwrite_ui.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({
    Key? key,
    required this.title,
    required this.client,
    required this.onSignedin,
  }) : super(key: key);

  final String title;
  final Client client;
  final void Function(Session) onSignedin;

  @override
  State<SigninPage> createState() => _State();
}

class _State extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SigninWidget(
        title: widget.title,
        client: widget.client,
        onSignedin: widget.onSignedin,
      ),
    );
  }
}
