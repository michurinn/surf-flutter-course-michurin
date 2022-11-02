import 'package:flutter/material.dart';

// Екран списка мест
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);
  

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100,        
          backgroundColor: ThemeData.light().scaffoldBackgroundColor,
          //elevation: 0,
          title: RichText(
              text: const TextSpan(
            text: "С",
            style: TextStyle(
                color: Color(0xFF4CAF50),
                fontFamily: "Roboto",
                fontSize: 32,
                fontWeight: FontWeight.w700),
                children: [TextSpan(
            text: "писок \n",
            style: TextStyle( 
                color: Color(0xFF3B3E5B),
          )),TextSpan(
            text: "и",
            style: TextStyle(
                color: Colors.yellow,),
          ),
          TextSpan(
            text: "нтересных ",
            style: TextStyle(
                color: Color(0xFF3B3E5B),),
          ),
          TextSpan(
            text: "м",
            style: TextStyle(
                color: Color(0xFF252849),),
          ),
          TextSpan(
            text: "ест",
            style: TextStyle(
                color: Color(0xFF3B3E5B),),
          ),]
          ))),
      resizeToAvoidBottomInset:
          false, // Чтобы содержимое Scaffold не смещалось при изменении размера екрана (например, при появлении клавиатуры)
    );
  }
}
