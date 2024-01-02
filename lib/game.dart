import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class SimonGame extends StatefulWidget {
  @override
  State<SimonGame> createState() => _SimonGameState();
}

class _SimonGameState extends State<SimonGame> with TickerProviderStateMixin{
  var myScore = 0;
  bool isActive = false;
  bool isFail = false;
  bool isVictory = false;
  bool isStarted = false;
  bool isDisplaying = false;
  int maxRound = 100;
  late var sequenceList = List.filled(maxRound, 0);
  int currentRound = 1;
  int currentSequence = 0;
  String roundDisplay = "Ready?!";
  int totalRow = 3;
  int totalColumn = 3;
  int sequenceDelay = 1000;
  late double buttonSize;
  late int totalButton;
  var displayColor, aniControllers, aniColors;

  @override
  void initState() {
    super.initState();

    // Initialize the number of button used
    totalButton = totalRow * totalColumn;
    buttonSize = (2/totalColumn) * 120;
    displayColor = List.filled(totalButton, Colors.blueGrey);
    aniControllers = List.generate(totalButton, (index) => AnimationController(duration: Duration(milliseconds: 400), reverseDuration: Duration(milliseconds: 400),vsync: this));
    aniColors = List.generate(totalButton, (index) => ColorTween(begin: Colors.blueGrey, end: Colors.cyan).animate(aniControllers[index]));

    // Generate Sequence
    for (int i = 0; i < sequenceList.length; i++){
      sequenceList[i] = Random().nextInt(totalButton);
    }

    // DisplaySequence(currentRound);
  }

  // Display Sequence
  Future<void> DisplaySequence(int round) async {
    setState(() {
      isDisplaying = true;
      print(isDisplaying);
    });

    await Future.delayed(Duration(seconds: 1));
    for(int i = 0; i < round; i++){
      await ShowSequence(sequenceList[i]);
      print(sequenceList[i]);
    }

    setState(() {
      isDisplaying = false;
      roundDisplay = "${sequenceList.getRange(0, round)}";
    });
    print(roundDisplay);
  }

  // Display Sequence in order
  // Future<void> ShowSequence(int value) async{
  //   await Future.delayed(Duration(milliseconds: sequenceDelay), (){
  //     if (aniControllers[value].status == AnimationStatus.completed) {
  //       aniControllers[value].reverse();
  //     } else {
  //       aniControllers[value].forward();
  //     }
  //   });
  // }
  
  Future<void> ShowSequence(int value) async {
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      displayColor[value] = Colors.cyan;
      // print("Change Color to Cyan");
    });
    await Future.delayed(Duration(milliseconds: sequenceDelay));
    setState(() {
      displayColor[value] = Colors.blueGrey;
      // print("Change Color to Blue Grey");
    });
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

  void updateStartStatus(){
    setState(() {
      isStarted = !isStarted;
    });
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
  void dispose() {
    for(int i = 0; i < aniControllers.length; i++) {
      aniControllers[i].dispose();
    }
    super.dispose();
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

              // Sequence Displayer
              for(int i = 0; i < totalRow; i++)Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [for(int j = 0; j < totalColumn; j++)Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    width: buttonSize.roundToDouble(),
                    height: buttonSize.roundToDouble(),
                    decoration: BoxDecoration(
                      color: displayColor[i*totalColumn+j],
                      borderRadius: BorderRadius.all(Radius.circular(3))
                    ),
                  ),
                  ),
                ]
              ),

              SizedBox(height: 20),

              // Buttons
              for(int i = 0; i < totalRow; i++)Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [for(int j = 0; j < totalColumn; j++)Padding(
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll((isStarted != true || isDisplaying == true)?Colors.grey:Colors.cyan),
                      fixedSize: MaterialStatePropertyAll(Size(buttonSize.roundToDouble(), buttonSize.roundToDouble()))
                    ),
                    onPressed: (isStarted != true || isDisplaying == true)? null : (){CheckSequence(i*totalColumn+j);}, 
                    child: Text("${i*totalColumn+j}")
                    ),
                  ),
                ]
              ),

              SizedBox(height: 20),

              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(200,50)),
                ),
                onPressed: (isStarted == true)? null: (){
                  updateStartStatus();
                  DisplaySequence(currentRound);
                }, 
                child: Text("Game Start",
                  style: TextStyle(
                    fontSize: 24
                  ),
                )
              )
            ],
          ),
        )
      )
    );
  }
}