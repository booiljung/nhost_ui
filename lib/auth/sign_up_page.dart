import 'package:flutter/material.dart';
import 'package:nhost_flutter_auth/nhost_flutter_auth.dart';
import 'package:nhost_ui/nhost_ui.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    Key? key,
    required this.title,
    required this.client,
    required this.onSignedUp,
  }) : super(key: key);

  final String title;
  final NhostClient client;
  final void Function() onSignedUp;

  @override
  State<SignUpPage> createState() => _State();
}

class _State extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Container(),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),
                child: SignUpWidget(
                  title: widget.title,
                  client: widget.client,
                  onSignedUp: widget.onSignedUp,
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
          Expanded(
            flex: 5,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
