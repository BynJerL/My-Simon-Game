import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';

class SimonGame extends StatefulWidget {
  int inputCol;
  int inputRow;
  SimonGame(this.inputCol, this.inputRow, {super.key});

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
  late int totalRow;
  late int totalColumn;
  int sequenceDelay = 1000;
  late double buttonSize;
  late int totalButton;
  var displayColor, aniControllers, aniColors;
  final buttonPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    // Initialize the number of button used
    totalRow = widget.inputRow;
    totalColumn = widget.inputCol;
    totalButton = totalRow * totalColumn;
    buttonSize = (2/totalColumn) * 120;
    displayColor = List.filled(totalButton, Colors.blueGrey);
    aniControllers = List.generate(totalButton, (index) => AnimationController(duration: Duration(milliseconds: 400), reverseDuration: Duration(milliseconds: 400),vsync: this));
    aniColors = List.generate(totalButton, (index) => ColorTween(begin: Colors.blueGrey, end: Colors.cyan).animate(aniControllers[index]));

    // Generate Sequence
    // for (int i = 0; i < sequenceList.length; i++){
    //   sequenceList[i] = Random().nextInt(totalButton);
    // }
    GenerateSequence();

    // DisplaySequence(currentRound);
  }

  // Generate Sequence
  void GenerateSequence(){
    setState(() {
      for (int i = 0; i < sequenceList.length; i++){
        sequenceList[i] = Random().nextInt(totalButton);
      }
    });
  }

  void Restart(){
    setState(() {
      isFail = false;
      isVictory = false;
      isDisplaying = false;
      currentRound = 1;
      currentSequence = 0;
      myScore = 0;
    });
    buttonPlayer.stop();
    GenerateSequence();
    DisplaySequence(currentRound);
  }

  void Stop(){
    setState(() {
      isFail = false;
      isVictory = false;
      isDisplaying = false;
      currentRound = 1;
      currentSequence = 0;
      myScore = 0;
    });
    updateStartStatus();
  }

  // Add Button Sound
  void buttonSound(int value){
    int currRow = (value/totalColumn).ceil();
    int currColumn = (value - 1)%totalColumn + 1;
    buttonPlayer.stop();
    buttonPlayer.play(AssetSource('sound/button_r${currRow}c${currColumn}.wav'));
  }

  // Display Sequence
  Future<void> DisplaySequence(int round) async {
    setState(() {
      isDisplaying = true;
      print(isDisplaying);
      displayColor.fillRange(0, totalButton, Colors.blueGrey);
    });

    await Future.delayed(Duration(seconds: 1));
    for(int i = 0; i < round; i++){
      if (isDisplaying == true) {
        await ShowSequence(sequenceList[i]);
        print(sequenceList[i]);
      } else {
        break;
      }
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
    buttonSound(value + 1);
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
          buttonSound(playerInput + 1);
          if (currentSequence == (currentRound - 1)) {
            myScore++;
            displayColor.fillRange(0, totalButton, Colors.blueGrey);
            if (currentRound == sequenceList.length) {
              isVictory = true;
            } else {
              currentRound++; 
              DisplaySequence(currentRound);
              currentSequence = 0;
            }
            if (currentRound > 8) {
              if (currentRound > 20) {
                sequenceDelay = 500;
              } else {
                sequenceDelay = 750;
              }  
            } 
          } else {
            currentSequence++;
          }
        } else {
          isFail = true;
          buttonPlayer.stop();
          buttonPlayer.play(AssetSource('sound/fail.wav'));
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
    buttonPlayer.dispose();
    for(int i = 0; i < aniControllers.length; i++) {
      aniControllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${totalColumn}x${totalRow} Simon Game"),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(24.0),
              //   child: Text(
              //     "Round $currentRound: $roundDisplay",
              //     style: TextStyle(
              //       fontSize: 20
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  (isFail == false) ? (isVictory == true) ? "You Win" : "Score" : "Game Over",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: (isFail == true)? Colors.red: Colors.black
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  "$myScore",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 80
                  ),
                ),
              ),

              // Sequence Displayer
              for(int i = 0; i < totalRow; i++)Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [for(int j = 0; j < totalColumn; j++)Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    width: buttonSize.roundToDouble()/2,
                    height: buttonSize.roundToDouble()/2,
                    decoration: BoxDecoration(
                      color: displayColor[i*totalColumn+j],
                      borderRadius: BorderRadius.all(Radius.circular(3))
                    ),
                  ),
                  ),
                ]
              ),

              SizedBox(height: 35),

              // Buttons
              for(int i = 0; i < totalRow; i++)Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [for(int j = 0; j < totalColumn; j++)Padding(
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll((isStarted != true || isDisplaying == true)?Colors.grey:(isFail == true)? Colors.red:Colors.cyan),
                      fixedSize: MaterialStatePropertyAll(Size.square(buttonSize.roundToDouble()*0.85)),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3))
                        )
                      )
                    ),
                    onPressed: (isStarted != true || isDisplaying == true || isFail == true)? null : (){
                      setState(() {
                        displayColor.fillRange(0, totalButton, Colors.blueGrey);
                        displayColor[i*totalColumn+j] = Colors.cyan;
                      });
                      // buttonSound(i*totalColumn+j+1);
                      CheckSequence(i*totalColumn+j);
                    }, 
                    child: Text("${i*totalColumn+j + 1}")
                    ),
                  ),
                ]
              ),

              SizedBox(height: 20),

            ],
          ),
        )
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size.square(60)),
                  padding: MaterialStateProperty.all(EdgeInsets.zero)
                ),
                onPressed: (isStarted == true)? null: (){
                  updateStartStatus();
                  DisplaySequence(currentRound);
                }, 
                child: Icon(Icons.play_arrow,
                  size: 50,
                )
              ),
              SizedBox(width: 20),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size.square(60)),
                  padding: MaterialStateProperty.all(EdgeInsets.zero)
                ),
                onPressed: (isStarted == false)? null: Restart, 
                child: Icon(Icons.restart_alt,
                  size: 50,
                )
              ),
              SizedBox(width: 20),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size.square(60)),
                  padding: MaterialStateProperty.all(EdgeInsets.zero)
                ),
                onPressed: (){
                  Stop();
                  Navigator.pop(context);
                }, 
                child: Icon(Icons.home,
                  size: 50,
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}