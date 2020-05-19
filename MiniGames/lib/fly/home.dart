import 'dart:async';
import 'package:flutter/material.dart';
import 'package:MiniGames/jason.dart';
import 'dart:math';

int level = 8;

class Home_fly extends StatefulWidget {
  final int size;

  const Home_fly({Key key, this.size = 8}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home_fly> {
  jason_get_data fling_ability;

  var rng = new Random();
  var q_type;
  var ans_order;
  var max_question = 10;
  var right_ans = 0;
  var page_state = 0;
  var index_2;
  var index_1;
  bool result = false;

  Color color_A;
  Color color_B;

  @override
  void initState() {
    super.initState();
    fling_ability = new jason_get_data();
    _next();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text("Flying Game ", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 90),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: q_type == 1
                      ? Text("Choose, which of following object can fly ?",
                          style: TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic))
                      : Text("Choose, which of following object can't fly ? }",
                          style: TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic)),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: FlatButton(
                    color: color_A,
                    onPressed: () {
                      ans_order == 0
                          ? setState(() {
                              color_A = Colors.green;
                              color_B = Colors.red;
                              if (page_state == 0) {
                                page_state = 1;
                                right_ans = right_ans + 1;
                                max_question = max_question - 1;
                              }
                            })
                          : setState(() {
                              color_A = Colors.red;
                              color_B = Colors.green;
                              if (page_state == 0) {
                                page_state = 1;
                                max_question = max_question - 1;
                              }
                            });
                    },
                    child: ans_order == 0
                        ? Text(fling_ability.can_fly[index_1])
                        : Text(fling_ability.can_not_fly[index_1]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: FlatButton(
                    color: color_B,
                    onPressed: () {
                      ans_order == 1
                          ? setState(() {
                              color_A = Colors.red;
                              color_B = Colors.green;
                              if (page_state == 0) {
                                right_ans = right_ans + 1;
                                page_state = 1;
                                max_question = max_question - 1;
                              }
                            })
                          : setState(() {
                              color_A = Colors.green;
                              color_B = Colors.red;
                              if (page_state == 0) {
                                page_state = 1;
                                max_question = max_question - 1;
                              }
                            });
                    },
                    child: ans_order == 0
                        ? Text(fling_ability.can_not_fly[index_2])
                        : Text(fling_ability.can_fly[index_2]),
                  ),
                ),
                page_state == 1
                    ? Padding(
                        padding: EdgeInsets.all(16.0),
                        child: FlatButton(
                            color: Colors.blue,
                            child: Text(
                              "Next",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                            onPressed: () {
                              setState(() {
                                if (_next() == false) result = true;
                              });
                            }),
                      )
                    : Text(""),
                result == true
                    ? AlertDialog(
                        title: Text("Result  "),
                        actions: <Widget>[
                          Text("Score is $right_ans / 10"),
                          FlatButton(
                              onPressed: () => setState(() {
                                    reset_all();
                                  }),
                              child: Text("Play again"))
                        ],
                      )
                    : Text(""),
              ],
            ),
          ),
        ),
      ),
    );
  }

  reset_all() {
    max_question = 10;
    right_ans = 0;
    result = false;
    _next();
  }

  bool _next() {
    if (max_question == 0) {
      return false;
    }

    q_type = rng.nextInt(2);
    ans_order = rng.nextInt(2);
    index_1 = rng.nextInt(7);
    index_2 = rng.nextInt(7);
    color_A = Colors.yellow[200];
    color_B = Colors.yellow[200];
    page_state = 0;
    print(max_question);
    print(right_ans);
    return true;
  }

  showResult() {}
}
