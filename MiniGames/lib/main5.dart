import 'package:flutter/material.dart';

import 'package:scratcher/scratcher.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AppBody(),
      ),
    );
  }
}

class AppBody extends StatelessWidget {
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
    return Container(
      alignment: Alignment.bottomCenter,
      child: FlatButton(
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
          win_point = rng.nextInt(100);
          scratchCardDialog(context);
        },
      ),
    );
  }
}
