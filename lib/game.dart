import 'package:flutter/material.dart';

class SimonGame extends StatefulWidget {
  @override
  State<SimonGame> createState() => _SimonGameState();
}

class _SimonGameState extends State<SimonGame> {

  bool isActive = false;

  void Toggle(){
    setState(() {
      isActive = !isActive;
    });
    print("Button Updated");
  }
  void PrintText(){
    print("Hello, World!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Row(
            children: [
              ElevatedButton(
                onPressed: Toggle, 
                child: const Text("Toggle")
              ),
              ElevatedButton(
                onPressed: (isActive == false) ? null : PrintText, 
                child: const Text("Print"))
            ],
          ),
        )
      )
    );
  }
}