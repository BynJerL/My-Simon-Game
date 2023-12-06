import 'package:flutter/material.dart';

class SimonGame extends StatefulWidget {
  @override
  State<SimonGame> createState() => _SimonGameState();
}

class _SimonGameState extends State<SimonGame> {
  var myScore = 0;
  bool isActive = false;
  bool isFail = false;
  var sequenceList = List.filled(10, 0);

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
                  "Score: $myScore",
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
                    onPressed: (){}, 
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
                    onPressed: (){}, 
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
                    onPressed: (){}, 
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
                    onPressed: (){}, 
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