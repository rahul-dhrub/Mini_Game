import 'dart:async'; 
import 'package:flutter/material.dart';
import 'package:MiniGames/jason.dart';

int level = 8;

class Home_Q extends StatefulWidget {
  final int size;

  const Home_Q({Key key, this.size = 8}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home_Q> {
 
 jason_get_data fling_ability ;
  var ques_no =1;
  var total_q = 10 ;
  var page_state =0; 
  var right_ans =0 ;
  var result =false;
  @override
  void initState() {
    super.initState();  
  fling_ability = new jason_get_data();  
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
            child:Column(
            children: <Widget>[
             
              Padding(
                padding: EdgeInsets.all(16.0),
                child:   Text(
                  fling_ability.MCQ[ques_no]['question'] ,style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)   ) , 
              ),

              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column( children: <Widget>[ 
                  FlatButton(
                    onPressed: (){
                      if( page_state == 0   ) {
                         if( ( fling_ability.MCQ[ques_no]['options'][0] == fling_ability.MCQ[ques_no]['ans']) )
                            right_ans  = right_ans +1;
                            total_q  = total_q -1;
                      }
                      setState(() {
                        page_state =1; 
                      }); 
                    },
                    child:  Text(  fling_ability.MCQ[ques_no]['options'][0] ,style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)   ) , 
                  ),

                  FlatButton(
                    onPressed: (){
                      if( page_state == 0   ) {
                         if( ( fling_ability.MCQ[ques_no]['options'][1] == fling_ability.MCQ[ques_no]['ans']) )
                            right_ans  = right_ans +1;
                            total_q  = total_q -1;
                      }
                      setState(() {
                        page_state =1; 
                      }); 
                    },
                    child:  Text(  fling_ability.MCQ[ques_no]['options'][1] ,style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)   ) , 
                  ),

                  FlatButton(
                    onPressed: (){
                      if( page_state == 0   ) {
                         if( ( fling_ability.MCQ[ques_no]['options'][2] == fling_ability.MCQ[ques_no]['ans']) )
                            right_ans  = right_ans +1;
                            total_q  = total_q -1;
                      }
                      setState(() {
                        page_state =1; 
                      }); 
                    },
                    child:  Text(  fling_ability.MCQ[ques_no]['options'][2] ,style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)   ) , 
                  ),

                  FlatButton(
                    onPressed: (){
                      if( page_state == 0   ) {
                         if( ( fling_ability.MCQ[ques_no]['options'][3] == fling_ability.MCQ[ques_no]['ans']) )
                            right_ans  = right_ans +1;
                            total_q  = total_q -1;
                      }
                      setState(() {
                        page_state =1; 
                      }); 
                    },
                    child:  Text(  fling_ability.MCQ[ques_no]['options'][3] ,style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)   ) , 
                  ),
 

                 page_state == 1 ? Padding(
                    padding: EdgeInsets.all(10),
                     child: Column(
                       children: <Widget>[
                         Text("Right Ans id : ${fling_ability.MCQ[ques_no]['ans']}" ),
                         FlatButton(
                          color: Colors.blue,
                          child: Text("Next" , style: TextStyle(color: Colors.white , fontSize:  30),),
                          onPressed:() { 
                            total_q != 0 ?
                              setState(() { 
                                page_state = 0;
                                ques_no = ques_no +1;
                              }): setState((){
                                result =true ;
                              });  
                          }
                        ),

                    result == true ? 
                        AlertDialog(
                        title: Text("Result  "), 
                        actions: <Widget>[
                        Text("Score is $right_ans / 10")  ,
                        FlatButton(
                          onPressed:() => setState(() { 
                              reset_all();
                            }),
                          child: Text("Play again")
                        ) ],) : Text(""),

                       ],
                     ),
                     ) : Text(""),
                    
                ],)   
                
              ),
            ],
            ),
          ),
        ),
      ),
      );
  }

  reset_all() {
     setState(() {
       total_q = 10;
       right_ans =0 ;
       ques_no = 1 ;
       result = false;
       page_state = 0; 
     });

  }
}