import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

// Класс создаёт екран с корневым виджетом Scaffold, используется в практической работе 4-2 на курсе Surf. 
// Параметр resizeToAvoidBottomInset: false для демонстрации поведения содержимого Scaffold при изменении размера екрана (например, при появлении клавиатуры)
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Чтобы содержимое Scaffold не смещалось при изменении размера екрана (например, при появлении клавиатуры)
      body: Center(child: Text("Hello!")),
    );
  }
}
