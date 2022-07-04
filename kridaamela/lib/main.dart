import 'package:flutter/material.dart';
import 'package:kridaamela/modules/jumping_bird/jumping_bird_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SafeArea(child: GameTile()),
    );
  }
}

class GameTile extends StatelessWidget {
  const GameTile({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const JumpingBird()));
            },
            child:const SizedBox(
                height: 200.0,
                width: 200.0,
                child: Card(
                    color: Colors.red,
                    child: Center(child: Text("Jumping Bird",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)))),
          ),
          const SizedBox(
              height: 200.0,
              width: 200.0,
              child: Card(
                  color: Colors.black,
                  child: Center(child: Text("Snake Mania",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),))))
        ],
      ),
    );
  }
}


