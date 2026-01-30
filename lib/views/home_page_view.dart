import 'package:flutter/material.dart';
import 'package:pooring_keyboard/widgets/keyboard_row.dart';
import 'package:pooring_keyboard/widgets/keyboard_button.dart';

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
        child: Row(
          children: [
            KeyboardButton(
              centerLabel: 'A',
              onTap: () {},
              leftLabel: 'a',
              rightLabel: 'Q',
            ),
            KeyboardButton(centerLabel: 'B', onTap: () {}, leftLabel: '@'),
            KeyboardButton(centerLabel: 'C', onTap: () {}, rightLabel: 'Z'),
          ],
        ),
      ),
    );
  }
}
