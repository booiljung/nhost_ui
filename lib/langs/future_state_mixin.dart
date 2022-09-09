import 'package:flutter/material.dart';

typedef Function0<R> = R Function();

mixin FutureStateMixin<T extends StatefulWidget> on State<T> {
  bool running = false;
  Future run(Function0<Future> func) async {
    setState(() {
      running = true;
    });
    try {
      await func();
    } finally {
      setState(() {
        running = false;
      });
    }
  }
}
