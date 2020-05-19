import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scratcher/widgets.dart';
import 'snake_game/game.dart';
import 'remebering_game/home.dart';
import 'quiz/home_quiz.dart';
import 'fly/home.dart';
import 'tic_tac/home_ttt.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: first_page(),
      ),
    );
  }
}

class first_page extends StatefulWidget {
  final int size;

  const first_page({Key key, this.size = 8}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<first_page> {
  List<String> Text_list;

  @override
  void initState() {
    super.initState();
    Text_list = List<String>();
    Text_list = [
      'quiz',
      'tik-tak-toe',
      'snake-game',
      'memory-game',
      'fly-object'
    ];
  }

  double _opacity = 0.0;
  var win_point = 0;
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
    final title = 'Play Games';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: <Widget>[
            new Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(Text_list.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: FlatButton(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      shape: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      color: Colors.indigo[200],
                      child: Text(
                        "${Text_list[index]}",
                        style: TextStyle(
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      onPressed: () {
                        if (Text_list[index] == "quiz")
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home_Q()),
                          );
                        else if (Text_list[index] == "tik-tak-toe")
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home_ttt()),
                          );
                        else if (Text_list[index] == "snake-game")
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Game()),
                          );
                        else if (Text_list[index] == "memory-game")
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home_mem()),
                          );
                        else if (Text_list[index] == "fly-object")
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home_fly()),
                          );
                      },
                    ),
                  );
                }),
              ),
            ),
            FlatButton(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              color: Colors.pink[900],
              child: Text(
                "Get A ScratchCard",
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              onPressed: () {
                win_point = rng.nextInt(100);
                scratchCardDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
