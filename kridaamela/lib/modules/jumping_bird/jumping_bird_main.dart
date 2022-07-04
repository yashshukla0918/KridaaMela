import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kridaamela/modules/jumping_bird/components/barrier.dart';
import 'package:kridaamela/modules/jumping_bird/components/bird.dart';
import 'package:kridaamela/modules/jumping_bird/components/tap_to_play_button.dart';

class JumpingBird extends StatefulWidget {
  const JumpingBird({Key? key}) : super(key: key);

  @override
  State<JumpingBird> createState() => _JumpingBirdState();


}

class _JumpingBirdState extends State<JumpingBird> {
  static bool gameHasStarted = false;
  static double birdYAxis = 0;
  // for height 250 touch point is 0.238 for lower and for upper -0.238
  // for height 150 touch point is -0.6 for upper and for lower 0.6
  double time = 0;
  double height = 0;
  double initialHeight = birdYAxis;
  static double barrierXone = 2;
  static double barrierXtwo = barrierXone +1.5;
  static bool isTouchedBoundary = false;
  static int score = 0;
  static int highscore = 0;
  double oneBarrierHeight =150;
  double twoBarrierHeight =250;
  void jump() {
    setState(() {
      time = 0;
      if(birdYAxis > -0.8){
      initialHeight = birdYAxis;}
    });
  }

  void reset(){
    score =0;
    barrierXone =2 ;
    barrierXtwo =barrierXone +1.5;
   birdYAxis = 0;
   isTouchedBoundary = false;
   time= 0;
   height = 0;
   initialHeight = 0;
   gameHasStarted = false;
  }
  void gameStart() {
    gameHasStarted = true;
    isTouchedBoundary = false;
    score =0;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {

        birdYAxis = initialHeight - height;
      });




      setState((){
        if(barrierXone< -1.3){
          barrierXone += 3;
        }
        else{
          barrierXone -=0.1;
        }
      });
      setState((){
        if(barrierXtwo< -1.3){
          barrierXtwo +=3 ;
        }
        else{
          barrierXtwo -=0.1;
        }
      });

      //print("${barrierXone.toStringAsFixed(1)} , ${barrierXtwo.toStringAsFixed(1)}");

      if((birdYAxis > 0.27 && barrierXone < 0.39 && barrierXone >-0.29) ||
          (birdYAxis < -0.6 && barrierXone < 0.39 && barrierXone >-0.29) ||
          (birdYAxis < -0.27 && barrierXtwo < 0.39 && barrierXtwo >-0.29) ||
          (birdYAxis > 0.6 && barrierXtwo < 0.39 && barrierXtwo >-0.29)
      ){
        timer.cancel();
        gameHasStarted = false;
        isTouchedBoundary = true;
        time=0;
       }
      else{
        setState((){
          if(barrierXtwo.toStringAsFixed(1) ==  "-0.5" || barrierXone.toStringAsFixed(1) == "-0.5"){
            //print(" ${barrierXone}  , ${barrierXtwo}");
            score++;
            if(score > highscore){
              highscore = score;
            }
          }
        });
      }

      if (birdYAxis > 1 ) {
        birdYAxis = 1.07;
        time = 0;
        height = 0;
        initialHeight = 0;
        timer.cancel();
        gameHasStarted = false;
        isTouchedBoundary = true;
        barrierXone = 2;
        barrierXtwo = barrierXone +1.5;
      }

    });
  }

  @override
  void dispose() {
    this.reset();
    super.dispose();
    print("Disposed");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(!isTouchedBoundary){
        if (gameHasStarted) {
          jump();
        } else {
          gameStart();
        }
      }
        },
      child: Scaffold(
        body: Column(
          children: [
            //PlayArea
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYAxis),
                    duration: const Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: Bird(),
                  ),
                  isTouchedBoundary
                      ? GestureDetector(
                          onTap:(){ setState((){

                            time =0;
                            time = 0;
                            height = 0;
                            initialHeight = 0;
                            barrierXone = 2;
                            barrierXtwo = barrierXone +1.5;
                          });gameStart();} , child: TapToPlayButton())
                      : Text(""),
                  AnimatedContainer(
                      alignment: Alignment(barrierXone,-1.1),
                      duration: Duration(milliseconds: 0),
                      child: Barrier(height: oneBarrierHeight,)),
                  AnimatedContainer(
                      alignment: Alignment(barrierXone,1.1),
                      duration: Duration(milliseconds: 0),
                      child: Barrier(height: twoBarrierHeight,)),
                  AnimatedContainer(
                      alignment: Alignment(barrierXtwo,-1.1),
                      duration: Duration(milliseconds: 0),
                      child: Barrier(height: twoBarrierHeight,)),
                  AnimatedContainer(
                      alignment: Alignment(barrierXtwo,1.1),
                      duration: Duration(milliseconds: 0),
                      child: Barrier(height: oneBarrierHeight,)),
                ],
              ),
            ),
            //Green Field
            SizedBox(
              height: 20,
              child: Container(
                color: Colors.green,
              ),
            ),
            //Score Board
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.brown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                         const Text(
                            "Score",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            score.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                         const Text(
                            "High Score",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            highscore.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
