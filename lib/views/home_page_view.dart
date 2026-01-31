import 'package:flutter/material.dart';
import 'keyboard_view.dart';
import 'package:pooring_keyboard/widgets/text_work_area.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Le contrôleur qui fait le lien entre clavier et texte
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 800, // Largeur fixe pour le look "clavier en ligne"
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWorkArea(controller: _controller), // La zone de texte
              const KeyboardView(), // Ton clavier complet
            ],
          ),
        ),
      ),
    );
  }
}
