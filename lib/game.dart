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
  int maxRound = 10;
  late var sequenceList = List.filled(maxRound, 0);
  int currentRound = 1;
  int currentSequence = 0;
  late String roundDisplay;

  @override
  void initState() {
    super.initState();

    // Generate Sequence
    for (int i = 0; i < sequenceList.length; i++){
      sequenceList[i] = Random().nextInt(4);
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
    if (isVictory == false) {
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
              ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.yellow),
                      fixedSize: MaterialStatePropertyAll(Size(50, 50)),
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      shape: MaterialStateProperty.all(CircleBorder())
                    ),
                    onPressed: (){CheckSequence(1);}, 
                    child: Icon(
                      Icons.arrow_drop_up,
                      size: 40,
                    )
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red),
                      fixedSize: MaterialStatePropertyAll(Size(50, 50)),
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      shape: MaterialStateProperty.all(CircleBorder())
                    ),
                    onPressed: (){CheckSequence(0);}, 
                    child: Icon(
                      Icons.arrow_left,
                      size: 40,
                    )
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green),
                      fixedSize: MaterialStatePropertyAll(Size(50, 50)),
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      shape: MaterialStateProperty.all(CircleBorder())
                    ),
                    onPressed: (){CheckSequence(2);}, 
                    child: Icon(
                      Icons.arrow_right,
                      size: 40,
                    )
                  )
                ],
              ),
              ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blueAccent),
                      fixedSize: MaterialStatePropertyAll(Size(50, 50)),
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      shape: MaterialStateProperty.all(CircleBorder())
                    ),
                    onPressed: (){CheckSequence(3);}, 
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 40,
                    )
                  ),
            ],
          ),
        )
      )
    );
  }
}