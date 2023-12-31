import 'package:flutter/material.dart';
import 'package:simon_game/game.dart';
import 'package:simon_game/mainmenu.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainMenu(),
      debugShowCheckedModeBanner: false,
    );
  }
}
