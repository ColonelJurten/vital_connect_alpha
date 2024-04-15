import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'dart:async';

class CircleSliderPulse extends StatefulWidget {
  const CircleSliderPulse({super.key});

  @override
  State<CircleSliderPulse> createState() => _CircleSliderPulseState();
}

class _CircleSliderPulseState extends State<CircleSliderPulse> {
  final DatabaseReference _ref = FirebaseDatabase.instance.reference();
  late StreamSubscription<DatabaseEvent>? pulseSu;
  double _pulsaciones = 0.0;

  @override
  void initState() {
    super.initState();
    pulseSu = _ref.child('pulsaciones').onValue.listen((event) {
      setState(() {
        _pulsaciones = double.parse(event.snapshot.value.toString());
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
          Image.asset(
            'assets/images/Heart1.gif',
            width: 180,
            alignment: Alignment.center,
          ),
          SleekCircularSlider(
            appearance: CircularSliderAppearance(
                customWidths: CustomSliderWidths(
                    trackWidth: 7, progressBarWidth: 20, shadowWidth: 20),
                customColors: CustomSliderColors(
                    trackColor: Colors.greenAccent,
                    progressBarColor: Colors.tealAccent[700],
                    shadowColor: Colors.teal[50],
                    shadowMaxOpacity: 0.5, //);
                    shadowStep: 5),
                infoProperties: InfoProperties(
                    bottomLabelStyle: TextStyle(
                        color: Colors.green[800],
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    bottomLabelText: 'Frec.',
                    mainLabelStyle: TextStyle(
                        color: Colors.green[900],
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600),
                    modifier: (double value) {
                      return '${_pulsaciones} p/m';
                    }),
                startAngle: 90,
                angleRange: 360,
                size: 180.0,
                animationEnabled: true),
            min: 0,
            max: 120,
            initialValue: _pulsaciones,
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
