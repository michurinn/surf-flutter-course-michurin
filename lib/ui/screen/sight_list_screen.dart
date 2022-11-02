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
          elevation: 0,
          
          title: const Text("Список\nинтересных мест",
                style: const TextStyle(color: const Color(0xFF3B3E5B),
                fontFamily: "Roboto",
                fontSize: 32,
                fontWeight: FontWeight.w700),
                softWrap: true,),                
          ),
      resizeToAvoidBottomInset:
          false, // Чтобы содержимое Scaffold не смещалось при изменении размера екрана (например, при появлении клавиатуры)
    );
  }
}
