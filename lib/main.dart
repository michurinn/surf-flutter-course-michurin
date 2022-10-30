// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:places/ui/screen/sight_list_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Surf",
      home:  SightListScreen(),
      //home: MySecondWidget(),
    );
  }
}


class MyFirstWidget extends StatelessWidget {
   MyFirstWidget({Key? key, String title = 'Flutter Demo'}) : super(key: key) {
    title = title;
   }
   late final String title;
        int _counter = 0;
  //Type method ()
  //{
    //return context.runtimeType;
  //}

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
  Type method ()
  {
    return context.runtimeType;
  }

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
