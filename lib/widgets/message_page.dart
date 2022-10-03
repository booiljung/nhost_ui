import 'package:flutter/material.dart';
import 'package:nhost_ui/nhost_ui.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({
    Key? key,
    required this.title,
    required this.messageText,
    required this.confirmText,
    this.confirmIcon,
    required this.onConfirm,
  }) : super(key: key);

  final String title;
  final String messageText;
  final String confirmText;
  final Icon? confirmIcon;
  final void Function() onConfirm;

  @override
  State<MessagePage> createState() => _State();
}

class _State extends State<MessagePage> {
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
                child: MessageWidget(
                  messageText: widget.messageText,
                  confirmIcon: widget.confirmIcon,
                  confirmText: widget.confirmText,
                  onConfirm: widget.onConfirm,
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
