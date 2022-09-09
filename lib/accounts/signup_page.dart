import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

import 'package:appwrite_ui/appwrite_ui.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({
    Key? key,
    required this.title,
    required this.client,
    required this.onSignedup,
  }) : super(key: key);

  final String title;
  final Client client;
  final void Function(User) onSignedup;

  @override
  State<SignupPage> createState() => _State();
}

class _State extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SignupWidget(
        title: widget.title,
        client: widget.client,
        onSignedup: widget.onSignedup,
      ),
    );
  }
}
