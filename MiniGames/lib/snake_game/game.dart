import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; 
import 'package:scratcher/scratcher.dart'; 


import 'children.dart';

enum Direction { LEFT, RIGHT, UP, DOWN }
enum GameState { START, RUNNING, FAILURE }

class Game extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GameState();
}

class _GameState extends State<Game> {
  var snakePosition;
  Point newPointPosition;
  Timer timer;
  Direction _direction = Direction.UP;
  var gameState = GameState.START;
  int score = 0;
  

  double _opacity = 0.0;
  var win_point=0;
  var rng = new Random();  

  Future<void> scratchCardDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          title: Align(
            alignment: Alignment.center,
            child: Text(
              'Congo! You\'ve won a scratch card',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          content: StatefulBuilder(builder: (context, StateSetter setState) {
            
            return Scratcher(
              accuracy: ScratchAccuracy.low,
              threshold: 25,
              brushSize: 50,
              onThreshold: () {
                setState(() {
                  _opacity = 1;
                });
              },
              image: Image.asset('assets/google.png'),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 250),
                opacity: _opacity,
                child: Container(
                  height: 300,
                  width: 300,
                  alignment: Alignment.center,
                  child: Text(
                    "Rs.$win_point",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Colors.blue),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, 
        automaticallyImplyLeading: true,
        title: Text("Snake Game ", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: 320,
          height: 320,
          padding: EdgeInsets.all(29),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/snake_bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapUp: (tapUpDetails) {
              _handleTap(tapUpDetails);
            },
            child: _getChildBasedOnGameState(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.red),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  "Score\n$score",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 50),
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          _direction = Direction.UP;
                        });
                      },
                      color: Colors.green,
                      child: Icon(Icons.keyboard_arrow_up),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            _direction = Direction.LEFT;
                          });
                        },
                        color: Colors.yellow,
                        child: Icon(Icons.keyboard_arrow_left),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              _direction = Direction.RIGHT;
                            });
                          },
                          color: Colors.yellow,
                          child: Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 50),
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          _direction = Direction.DOWN;
                        });
                      },
                      color: Colors.green,
                      child: Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

       FlatButton(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        color: Colors.pinkAccent,
        child: Text(
          "Get A ScratchCard",
          style: TextStyle(
            color: Colors.yellowAccent,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        onPressed: () {
            win_point = rng.nextInt(100) ;
            scratchCardDialog(context);
            },
      ),
      ],
      ), 
    ); 
  }

  void _handleTap(TapUpDetails tapUpDetails) {
    switch (gameState) {
      case GameState.START:
        startToRunState();
        break;
      case GameState.RUNNING:
        break;
      case GameState.FAILURE:
        setGameState(GameState.START);
        break;
    }
  }

  void startToRunState() {
    startingSnake();
    generatenewPoint();
    _direction = Direction.UP;
    setGameState(GameState.RUNNING);
    timer = new Timer.periodic(new Duration(milliseconds: 400), onTimeTick);
  }

  void startingSnake() {
    setState(() {
      final midPoint = (320 / 20 / 2);
      snakePosition = [
        Point(midPoint, midPoint - 1),
        Point(midPoint, midPoint),
        Point(midPoint, midPoint + 1),
      ];
    });
  }

  void generatenewPoint() {
    setState(() {
      Random rng = Random();
      var min = 0;
      var max = 320 ~/ 20;
      var nextX = min + rng.nextInt(max - min);
      var nextY = min + rng.nextInt(max - min);

      var newRedPoint = Point(nextX.toDouble(), nextY.toDouble());

      if (snakePosition.contains(newRedPoint)) {
        generatenewPoint();
      } else {
        newPointPosition = newRedPoint;
      }
    });
  }

  void setGameState(GameState _gameState) {
    setState(() {
      gameState = _gameState;
    });
  }

  Widget _getChildBasedOnGameState() {
    var child;
    switch (gameState) {
      case GameState.START:
        setState(() {
          score = 0;
        });
        child = gameStartChild;
        break;

      case GameState.RUNNING:
        List<Positioned> snakePiecesWithNewPoints = List();
        snakePosition.forEach(
          (i) {
            snakePiecesWithNewPoints.add(
              Positioned(
                child: gameRunningChild,
                left: i.x * 15.5,
                top: i.y * 15.5,
              ),
            );
          },
        );
        final latestPoint = Positioned(
          child: newSnakePointInGame,
          left: newPointPosition.x * 15.5,
          top: newPointPosition.y * 15.5,
        );
        snakePiecesWithNewPoints.add(latestPoint);
        child = Stack(children: snakePiecesWithNewPoints);
        break;

      case GameState.FAILURE:
        timer.cancel();
        child = Container(
          width: 320,
          height: 320,
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Text(
              "You Scored: $score\nTap to play again!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
        break;
    }
    return child;
  }

  void onTimeTick(Timer timer) {
    try{
    setState(() {
      snakePosition.insert(0, getLatestSnake());
      snakePosition.removeLast();
    });
    }
    catch(e){
      timer.cancel();
      print(e);
    } 

    var currentHeadPos = snakePosition.first;
    if (currentHeadPos.x < 0 ||
        currentHeadPos.y < 0 ||
        currentHeadPos.x > 320 / 20 ||
        currentHeadPos.y > 320 / 20) {
      setGameState(GameState.FAILURE);
      return;
    }

    if (snakePosition.first.x == newPointPosition.x &&
        snakePosition.first.y == newPointPosition.y) {
      generatenewPoint();
      setState(() {
        if (score <= 10)
          score = score + 1;
        else if (score > 10 && score <= 25)
          score = score + 2;
        else
          score = score + 3;
        snakePosition.insert(0, getLatestSnake());
      });
    }
  }

  Point getLatestSnake() {
    var newHeadPos;

    switch (_direction) {
      case Direction.LEFT:
        var currentHeadPos = snakePosition.first;
        newHeadPos = Point(currentHeadPos.x - 1, currentHeadPos.y);
        break;

      case Direction.RIGHT:
        var currentHeadPos = snakePosition.first;
        newHeadPos = Point(currentHeadPos.x + 1, currentHeadPos.y);
        break;

      case Direction.UP:
        var currentHeadPos = snakePosition.first;
        newHeadPos = Point(currentHeadPos.x, currentHeadPos.y - 1);
        break;

      case Direction.DOWN:
        var currentHeadPos = snakePosition.first;
        newHeadPos = Point(currentHeadPos.x, currentHeadPos.y + 1);
        break;
    }

    return newHeadPos;
  }
}