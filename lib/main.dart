// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

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
      //home:  MyFirstWidget(title: 'Flutter Demo Home Page'),
      home: MySecondWidget(),
    );
  }
}


class MyFirstWidget extends StatelessWidget {
   MyFirstWidget({Key? key, String title = 'Flutter Demo'}) : super(key: key) {
    title = title;
   }
   late final String title;
  int _counter = 0;
      

  @override
  Widget build(BuildContext context) {
    _counter++;
    print(_counter);
   return  Container(
   child: const Center( 
      child: const Text("Hello!")
   ),

);
    
  }
}

class MySecondWidget extends StatefulWidget {
   MySecondWidget({Key? key}) : super(key: key);

  @override
  State<MySecondWidget> createState() => _MySecondWidgetState();
}

class _MySecondWidgetState extends State<MySecondWidget> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {

    _counter++;
    print(_counter);
   return  Container(
   child: const Center( 
      child: const Text("Hello!")
   ),

);
    
  }
    
  }
