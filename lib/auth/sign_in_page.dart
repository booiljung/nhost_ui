import 'package:nhost_flutter_auth/nhost_flutter_auth.dart';
import 'package:nhost_sdk/nhost_sdk.dart';
import 'package:flutter/material.dart';
import 'package:nhost_ui/nhost_ui.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({
    Key? key,
    required this.title,
    required this.client,
    required this.onSignedIn,
  }) : super(key: key);

  final String title;
  final NhostClient client;
  final void Function() onSignedIn;

  @override
  State<SignInPage> createState() => _State();
}

class _State extends State<SignInPage> {
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
                child: SignInWidget(
                  title: widget.title,
                  client: widget.client,
                  onSignedIn: widget.onSignedIn,
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
