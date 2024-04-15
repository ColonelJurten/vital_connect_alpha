import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'dart:async';

class CircleSliderTemp extends StatefulWidget {
  const CircleSliderTemp({super.key});

  @override
  State<CircleSliderTemp> createState() => _CircleSliderTempState();
}

class _CircleSliderTempState extends State<CircleSliderTemp> {
  final DatabaseReference _ref = FirebaseDatabase.instance.reference();
  late StreamSubscription<DatabaseEvent>? pulseSu;
  double _temperature = 0.0;

  @override
  void initState() {
    super.initState();
    pulseSu = _ref.child('temperatura_celsius').onValue.listen((event) {
      setState(() {
        _temperature = double.parse(event.snapshot.value.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SleekCircularSlider(
            appearance: CircularSliderAppearance(
                customWidths: CustomSliderWidths(
                  trackWidth: 7,
                  progressBarWidth: 20,
                  shadowWidth: 20,
                ),
                customColors: CustomSliderColors(
                    trackColor: Colors.tealAccent[700],
                    progressBarColor: Colors.greenAccent,
                    shadowColor: Colors.teal[50],
                    shadowMaxOpacity: 0.5,
                    shadowStep: 5),
                infoProperties: InfoProperties(
                    bottomLabelStyle: TextStyle(
                        color: Colors.green[900],
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    bottomLabelText: 'Temp.',
                    mainLabelStyle: TextStyle(
                        color: Colors.green[900],
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600),
                    modifier: (double value) {
                      return '${_temperature} C°';
                    }),
                startAngle: 90,
                angleRange: 240,
                size: 180,
                spinnerMode: false,
                animationEnabled: true),
            min: 0,
            max: 120,
            initialValue: _temperature,
          ),
          Image.asset(
            'assets/images/Termo.png',
            width: 180,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    pulseSu?.cancel();
  }
}
