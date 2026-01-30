import 'package:flutter/material.dart';
import 'package:pooring_keyboard/widgets/keyboard_row.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            KeyboardRow(keys: ["A", "B", "C"]),
            KeyboardRow(keys: ["E", "D", "F"]),
            KeyboardRow(keys: ["G", "H", "I"]),
            KeyboardRow(keys: ["J", "K", "L"]),
          ],
        ),
      ),
    );
  }
}
