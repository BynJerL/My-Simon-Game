import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simon_game/game.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool isPickingMode = false;
  late int inputRow;
  late int inputCol;

  void PlayGame(){
    setState(() {
      isPickingMode = false;
    });
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => SimonGame(inputCol, inputRow))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(),   
          Padding(
            padding: const EdgeInsets.only(top: 80, bottom: 40),
            child: Text("Simon Game",
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
                fontSize: 72,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if(isPickingMode == false) ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(Size(150, 50))
            ),
            onPressed: (){
              setState(() {
                isPickingMode = true;
              });
            }, 
            child: Text("Play",
              style: GoogleFonts.openSans(
                fontSize: 24,
                fontWeight: FontWeight.w600
              ),
            )
          ) else Column(
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(150, 50))
                ),
                onPressed: (){
                  setState(() {
                    inputRow = 2;
                    inputCol = 2;
                  });
                  PlayGame();
                }, 
                child: Text("2x2",
                  style: GoogleFonts.openSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w600
                  ),
                )
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(150, 50))
                ),
                onPressed: (){
                  setState(() {
                    inputRow = 3;
                    inputCol = 3;
                  });
                  PlayGame();
                }, 
                child: Text("3x3",
                  style: GoogleFonts.openSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w600
                  ),
                )
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(150, 50))
                ),
                onPressed: (){
                  setState(() {
                    inputRow = 4;
                    inputCol = 4;
                  });
                  PlayGame();
                }, 
                child: Text("4x4",
                  style: GoogleFonts.openSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w600
                  ),
                )
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(100, 50))
                ),
                onPressed: (){
                  setState(() {
                    isPickingMode = false;
                  });
                }, 
                child: Icon(
                  Icons.subdirectory_arrow_left_sharp,
                  size: 36,
                )
              ),
            ],
          ),
        ],
      ),
    );
  }
}