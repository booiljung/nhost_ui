import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

import 'package:appwrite_ui/appwrite_ui.dart';

class PasswordUpdatePage extends StatefulWidget {
  const PasswordUpdatePage({
    Key? key,
    required this.title,
    required this.client,
    required this.onUpdated,
  }) : super(key: key);

  final String title;
  final Client client;
  final void Function(User) onUpdated;

  @override
  State<PasswordUpdatePage> createState() => _State();
}

class _State extends State<PasswordUpdatePage> {
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
                child: PasswordUpdateWidget(
                  title: widget.title,
                  client: widget.client,
                  onUpdated: widget.onUpdated,
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
