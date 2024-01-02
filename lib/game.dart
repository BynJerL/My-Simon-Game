import 'dart:math';

import 'package:flutter/material.dart';

class SimonGame extends StatefulWidget {
  @override
  State<SimonGame> createState() => _SimonGameState();
}

class _SimonGameState extends State<SimonGame> {
  var myScore = 0;
  bool isActive = false;
  bool isFail = false;
  bool isVictory = false;
  int maxRound = 100;
  late var sequenceList = List.filled(maxRound, 0);
  int currentRound = 1;
  int currentSequence = 0;
  late String roundDisplay;
  int totalRow = 2;
  int totalColumn = 2;
  late int totalButton;

  @override
  void initState() {
    super.initState();

    // Initialize the number of button used
    totalButton = totalRow * totalColumn;

    // Generate Sequence
    for (int i = 0; i < sequenceList.length; i++){
      sequenceList[i] = Random().nextInt(totalButton);
    }

    DisplaySequence(currentRound);
  }

  // Display Sequence
  void DisplaySequence(int round) {
    setState(() {
      roundDisplay = "${sequenceList.getRange(0, round)}";
    });
    print(roundDisplay);
  }

  // Check
  void CheckSequence(int playerInput){
    if (isVictory == false && isFail == false) {
      setState(() {
        if (playerInput == sequenceList[currentSequence]) {
          if (currentSequence == (currentRound - 1)) {
            myScore++;
            if (currentRound == sequenceList.length) {
              isVictory = true;
            } else {
              currentRound++; 
              DisplaySequence(currentRound);
              currentSequence = 0;
            }
          } else {
            currentSequence++;
          }
        } else {
          isFail = true;
        }
      });
    }
  }

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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "Round $currentRound: $roundDisplay",
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  (isFail == false) ? (isVictory == true) ? "You Win" : "Score: $myScore" : "Game Over",
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
              ),
              
              for(int i = 0; i < totalRow; i++)Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [for(int j = 0; j < totalColumn; j++)Padding(
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.cyan),
                      fixedSize: MaterialStatePropertyAll(Size(100, 100))
                    ),
                    onPressed: (){CheckSequence(i*totalColumn+j);}, 
                    child: Text("${i*totalColumn+j}")
                    ),
                ),
                ]
              ),
            ],
          ),
        )
      )
    );
  }
}