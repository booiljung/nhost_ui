import 'package:flutter/material.dart';

class SignoutPage extends StatefulWidget {
  const SignoutPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SignoutPage> createState() => _State();
}

class _State extends State<SignoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}
