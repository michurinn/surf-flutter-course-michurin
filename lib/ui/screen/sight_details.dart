import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:places/domain/sight.dart';

class SideDetails extends StatelessWidget {
  const SideDetails({Key? key, required this.sight}) : super(key: key);
  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            Container(
              width: double.infinity,
              height: 360,
              color: Colors.amber,
            ),
            Container(
              padding: const EdgeInsets.only(top: 36, left: 16),
              width: 32,
              height: 32,
              color: Colors.teal,
            ),
          ]),
          const SizedBox(
            height: 24,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              sight.name,
              style: const TextStyle(
                letterSpacing: .5,
                wordSpacing: 2,
                fontStyle: FontStyle.normal,
                fontSize: 24,
                color: Color(0xff3B3E5B),
                fontFamily: "Roboto",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  sight.type,
                  style: const TextStyle(
                    letterSpacing: .5,
                    wordSpacing: 2,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xff3B3E5B),
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Text(
                "режим работы",
                style: TextStyle(
                  letterSpacing: .5,
                  wordSpacing: 2,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff7C7E92),
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: double.infinity,
            child: Text(
              sight.details,
              style: const TextStyle(
                letterSpacing: .5,
                wordSpacing: 2,
                fontStyle: FontStyle.normal,
                fontSize: 14,
                color: Color(0xff3B3E5B),
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: double.infinity,
            height: 48,
            color: Colors.lime,
          ),
          const SizedBox(
            height: 24,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              thickness: 2,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  color: Colors.lightGreen,
                ),
              ),
              Expanded(
                child: Container(
                  height: 40,
                  color: const Color.fromARGB(255, 167, 24, 67),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
