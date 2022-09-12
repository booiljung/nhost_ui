import 'dart:developer' as developer;
import 'package:flutter/material.dart';

import 'package:appwrite_ui/appwrite_ui.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({
    Key? key,
    required this.messageText,
    required this.confirmText,
    this.confirmIcon,
    required this.onConfirm,
  }) : super(key: key);

  final String messageText;
  final String confirmText;
  final Icon? confirmIcon;
  final void Function() onConfirm;

  @override
  State<MessageWidget> createState() => _State();
}

class _State extends State<MessageWidget> with FutureStateMixin<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    return AwColumn(
      spacing: 0,
      children: <Widget>[
        Text(widget.messageText),
        const SizedBox(
          height: 48,
        ),
        ElevatedButton(
          onPressed: () {
            developer.log("${widget.confirmText} pressed");
            widget.onConfirm();
          },
          child: AwRow(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              widget.confirmIcon ?? const Icon(Icons.check_outlined),
              Text(widget.confirmText),
            ],
          ),
        ),
      ],
    );
  }
}
