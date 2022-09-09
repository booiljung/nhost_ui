import 'package:flutter/material.dart';

class DescriptionText extends StatefulWidget {
  const DescriptionText(this.text, {Key? key}) : super(key: key);
  final String text;

  @override
  State<DescriptionText> createState() => _State();
}

class _State extends State<DescriptionText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      overflow: TextOverflow.visible,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 14),
    );
  }
}