import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const maxSeconds=60;
  int seconds = maxSeconds;
  Timer? timer;

  void resetTimer()=> setState(()=> seconds = maxSeconds);

  void startTimer({bool reset = true}){
      if(reset){
        resetTimer();
      }

    timer = Timer.periodic(Duration(milliseconds: 50),(_){
      if(seconds > 0) {
        setState(() => seconds--);
      }
      else{
        startTimer();
      }
      });
  }
  void stopTimer({bool reset = true}){
   if(reset){
     resetTimer();
   }
   setState(() => timer?.cancel());
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
         children: [
              buildTimer(),
             const SizedBox(height: 80),
                    buildButtons(),
                 ],

            ),

        ),
      );
  }


  buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = (seconds == maxSeconds) || (seconds ==0);
    return isRunning || !isCompleted ?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
               onPressed: () =>
                  {
                    stopTimer()
                  },
               child:Text(isRunning ?'Pause' : 'Resume')),
              SizedBox(width: 12),
              ElevatedButton(
                  onPressed: () =>
                  {
                  stopTimer()
              },
                  child:Text('Cancel'))
            ],
          )
      :ElevatedButton(

        child:Text('Start Timer',
      style: TextStyle(fontSize: 20)),
      onPressed:(){
          startTimer();
    });
    }

  buildTimer() => SizedBox(
      width:200,
      height: 200,
      child:Stack(
    fit: StackFit.expand,
    children: [
      CircularProgressIndicator(
        value: seconds/ maxSeconds,
        strokeWidth: 12,
        backgroundColor: Colors.redAccent,
      ),
      Center(child: buildTime()),
    ],
  )
  );
    Widget buildTime()
    {
      return Text(
        '$seconds',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 80,
        ),

      );
    }
  }


