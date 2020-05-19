import 'dart:async'; 
import 'package:flutter/material.dart';
import 'package:MiniGames/jason.dart';

int level = 8;

class Home_ttt extends StatefulWidget {
  final int size;

  const Home_ttt({Key key, this.size = 8}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home_ttt> {
 
  var player = 0;
bool win=false;
 
  
  @override
  void initState() {
    super.initState();   
    reset_all();
  }
 

   @override
  Widget build(BuildContext context) {
    final title =  'Tic-Tac-Toe';

    return   Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true, 
          title: Text(title),
        ),
        body: 
        Column(children: <Widget>[
               Expanded(child:  win == false ? 
               GridView.count( 
                    crossAxisCount: 3, 
                    children: List.generate(9, (index) {
                      return  Padding
                                ( padding: const EdgeInsets.all(5.0),
                                  child: FlatButton(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  shape: OutlineInputBorder(
                                    // borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  color: Colors.grey,
                                  child: Text(
                                    "${list_zero_cross[index]}",
                                    style: TextStyle(
                                      color: Colors.yellowAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  onPressed: () {   
                                    //
                                    bool temp=false;

                                    player==1 ? temp=call(index,player) : temp=call(index,player)  ;

                                    if(temp==true)
                                    {
                                        setState(() {
                                          win= true;
                                        });
                                    }
                                  //change player  
                                  if(list_zero_cross[index] != 'X' && list_zero_cross[index] != 'O')
                                      player==1 ? 
                                            setState(() {
                                              list_zero_cross[index] = 'O';
                                              player=0; }) 
                                            : setState(() {
                                              list_zero_cross[index] = 'X' ;
                                              player=1;
                                                }); 
                                    },
                                ),) ; 
                      }),
                    ): 
                    
                    AlertDialog(
                      title: Text("congrates: Player Won"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed:() => setState(() {
                                win=false;
                                reset_all();
                              }),
                          child: Text("Play again"))
                        ],
                      ) ,
          ),

                     FlatButton(
                          onPressed:() => setState(() {
                                win=false;
                                reset_all();
                              }),
                          child: Text("Reset" , style: TextStyle(fontSize: 25, color: Colors.orange[900]),))
        ],)
       
    );
  }
    

  bool call(index,player)
  { 
    if(list_zero_cross[index] != 'X' && list_zero_cross[index] != 'O')
        return check_win(player,index);   
    return false;
  }  
  List<int> list_player_0 = null; 
  List<int> list_player_1 = null; 
  List<String> list_zero_cross = null; 

   reset_all(){
        list_player_0 = null; 
        list_player_1 = null; 
        list_player_0 = List<int> (); 
        list_player_1 = List<int> (); 
        list_zero_cross = List<String> (); 
        list_zero_cross = ['1','2','3','4','5','6','7','8','9'];
   }  
  bool check_win(int player,int index) {  
    print("$player");
    print("$index");

    List<int> selected_index = List<int> (); 
    if (player==0) {
      list_player_0.add(index); 
      selected_index = list_player_0; 
    } else {
        list_player_1.add(index); 
         selected_index = list_player_1; 
    }
    if(selected_index.indexOf(0) != -1 && 
          selected_index.indexOf(1)  != -1  && 
            selected_index.indexOf(2)  != -1 ) 
                return true;
      if(selected_index.indexOf(0) != -1 && 
          selected_index.indexOf(3)  != -1  && 
            selected_index.indexOf(6)  != -1 ) 
                return true;
      if(selected_index.indexOf(0) != -1 && 
          selected_index.indexOf(4)  != -1  && 
            selected_index.indexOf(8)  != -1 ) 
                return true;
      if(selected_index.indexOf(1) != -1 && 
          selected_index.indexOf(4)  != -1  && 
            selected_index.indexOf(7)  != -1 ) 
                return true;
      if(selected_index.indexOf(2) != -1 && 
          selected_index.indexOf(5)  != -1  && 
            selected_index.indexOf(8)  != -1 ) 
                return true;
      if(selected_index.indexOf(3) != -1 && 
          selected_index.indexOf(4)  != -1  && 
            selected_index.indexOf(5)  != -1 ) 
                return true;
      if(selected_index.indexOf(6) != -1 && 
          selected_index.indexOf(7)  != -1  && 
            selected_index.indexOf(8)  != -1 ) 
                return true;
      if(selected_index.indexOf(1) != -1 && 
          selected_index.indexOf(4)  != -1  && 
            selected_index.indexOf(7)  != -1 ) 
                return true;
                
      return false;
  }
}