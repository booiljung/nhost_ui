import 'package:flutter/material.dart';
import 'package:nhost_ui/nhost_ui.dart';

class AwSolidButton extends StatefulWidget {
  AwSolidButton({
    Key? key,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.icon,
    required this.text,
  }) : super(key: key);

  VoidCallback? onPressed;
  VoidCallback? onLongPress;
  ValueChanged<bool>? onHover;
  ValueChanged<bool>? onFocusChange;
  ButtonStyle? style;
  FocusNode? focusNode;
  bool autofocus;
  Clip clipBehavior;
  Icon? icon = null;
  String text;

  @override
  State<AwSolidButton> createState() => _State();
}

class _State extends State<AwSolidButton> {
  @override
  Widget build(BuildContext context) {
    List<Widget> row = [];
    if (widget.icon != null) {
      row.add(widget.icon!);
    }
    row.add(Text(widget.text));

    return ElevatedButton(
      onPressed: widget.onPressed,
      onLongPress: widget.onLongPress,
      onHover: widget.onHover,
      onFocusChange: widget.onFocusChange,
      style: widget.style,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      clipBehavior: widget.clipBehavior,
      child: AwRow(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 32,
        children: row,
      ),
    );
  }
}
