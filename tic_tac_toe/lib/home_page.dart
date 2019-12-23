import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/custom_dialog.dart';
import 'package:tic_tac_toe/name_buttom.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GameButton> butonList;
  var player1;
  var player2;
  var activePlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    butonList = doInit();
  }
  void playGame(GameButton gb){
    setState(() {
      if(activePlayer==1){
        gb.bg=Colors.red;
        gb.text="X";
        activePlayer = 2;
        player1.add(gb.id);
      }else{
        gb.bg=Colors.black;
        gb.text="O";
        activePlayer = 1;
        player2.add(gb.id);
      }gb.enabled = false;
      int winner = checkWinner();
      if(winner==-1){
        if(butonList.every((p)=>p.text !="")){
          showDialog(
              context: context,
              builder: (_)=> CustomDialog("Game Tied",
                  "Press the reset button to start again.",
                  resetGame)
          );
        }else{
          activePlayer == 2?autoPlay():null;
        }
      }


    });

  }

  void autoPlay(){
    var emptyCells = List();
    var list = List.generate(9, (i)=>i+1);
    for(var cellID in list){
      if(!(player1.contains(cellID) || player2.contains(cellID))){
        emptyCells.add(cellID);
      }
    }
    var r = new Random();
    var randIndex = r.nextInt(emptyCells.length-1);
    var cellID = emptyCells[randIndex];
    int i = butonList.indexWhere((p)=> p.id == cellID);
    playGame(butonList[i]);
  }
  int checkWinner(){
    var winner = -1;
    //row 1
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)){
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)){
      winner = 2;
    }

    //row 2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)){
      winner = 1;
    }
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)){
      winner = 2;

      //row 3
    }
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)){
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)){
      winner = 2;
    }

    //col 1
    if (player1.contains(1) && player1.contains(3) && player1.contains(7)){
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(3) && player2.contains(7)){
      winner = 2;
    }

    //col 2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)){
      winner = 1;
    }
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)){
      winner = 2;

      //col 3
    }
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)){
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)){
      winner = 2;
    }
    //diagonal 1
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)){
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)){
      winner = 2;
    }
    //diagonal 2
    if (player1.contains(3) && player1.contains(5) && player1.contains(7)){
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)){
      winner = 2;
    }
    if(winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) =>
                CustomDialog(
                    "Player 1", "Press the reset button to start again.",
                    resetGame)
        );
      } else {
        showDialog(
            context: context,
            builder: (_) =>
                CustomDialog(
                    "Player 2", "Press the reset button to start again.",
                    resetGame));
      }
    }return winner;
    }

  void resetGame(){
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      butonList = doInit();
    });
  }

  List<GameButton> doInit(){
    player1 = List();
    player2= List();
    activePlayer = 1;
    var gameButton = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];
    return gameButton;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TIC TAC TOE"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: butonList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 9.0,
                  mainAxisSpacing: 9.0,
                ),
                itemBuilder: (context,i)=> SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: RaisedButton(
                    padding: EdgeInsets.all(8.0),
                    onPressed: butonList[i].enabled?()=>playGame(butonList[i]):null,
                    child: Text(butonList[i].text,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    color: butonList[i].bg,
                    disabledColor: butonList[i].bg,
                  )
                  ,
                )
            ),
          ),
          RaisedButton(
            child: Text("Reset",
            style: TextStyle(
              color: Colors.white, fontSize: 20.0
            ),
            ),
            color: Colors.redAccent,
            padding: EdgeInsets.all(20.0),
            onPressed: resetGame,

          )
        ],

      )
    );

  }
}
