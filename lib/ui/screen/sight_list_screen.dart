import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/sight_card.dart';

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
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: ThemeData.light().scaffoldBackgroundColor,
        elevation: 0,
        title: const Text(
          "Список\nинтересных мест",
          style: TextStyle(
              color: Color(0xFF3B3E5B),
              fontFamily: "Roboto",
              fontSize: 32,
              fontWeight: FontWeight.w700),
          softWrap: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SightCard(sight: mocks[0]),
            const SizedBox(
              height: 20,
            ),
            SightCard(sight: mocks[1]),
            const SizedBox(
              height: 20,
            ),
            SightCard(sight: mocks[2]),
          ],
        ),
      ),
      resizeToAvoidBottomInset:
          false, // Чтобы содержимое Scaffold не смещалось при изменении размера екрана (например, при появлении клавиатуры)
    );
  }
}
