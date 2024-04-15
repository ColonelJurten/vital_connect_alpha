import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class PulseChart extends StatefulWidget {
  const PulseChart({super.key});

  //////////Definiendo el color de la Barra de la tabla/////////////

  final Color pulseColor = Colors.green;
  @override
  State<PulseChart> createState() => _PulseChartState();
}

class _PulseChartState extends State<PulseChart> {
  final DatabaseReference _ref = FirebaseDatabase.instance.reference();

/////////Declaración de valores para el FlowChart/////////////

  final limitCount = 200;
  final beatPoints = <FlSpot>[];
  double _pulsaciones = 0.0;
  double x = 0.0;
  final double _step = 0.5;

////////////Declaracion de valores para el estado de las tareas dinamicas/////

  late Timer timer;

  late StreamSubscription<DatabaseEvent>? pulseSu;

////////////////Inicializar el timer y la conexión a firebase//////////////////

  @override
  void initState() {
    super.initState();

    pulseSu = _ref.child('pulsaciones').onValue.listen((event) {
      setState(() {
        _pulsaciones = double.parse(event.snapshot.value.toString());
      });
    });
    timer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      while (beatPoints.length > limitCount) {
        beatPoints.removeAt(0);
      }
      setState(() {
        beatPoints.add(FlSpot(x, _pulsaciones));
      });
      x += _step;
    });
  }

/////////////Creando el widget de la tabla dinámica///////////////

  @override
  Widget build(BuildContext context) {
    return beatPoints.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Text(
                'Frecuencia:$_pulsaciones',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              AspectRatio(
                aspectRatio: 1.5,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),

//////////////////Diseño de la LineChart////////////////////

                  child: LineChart(LineChartData(
                      minY: 10,
                      maxY: 140,
                      minX: beatPoints.first.x,
                      maxX: beatPoints.last.x,
                      clipData: const FlClipData.all(),
                      gridData: const FlGridData(show: true),
                      lineBarsData: [
                        beatLine(beatPoints),
                      ],
                      titlesData: const FlTitlesData(
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ))),
                ),
              )
            ],
          )
        : Container();
  }

//////////////Diseño de la Barra de la tabla/////////////////

  LineChartBarData beatLine(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      dotData: const FlDotData(show: false),
      gradient: LinearGradient(
        colors: [widget.pulseColor.withOpacity(0), widget.pulseColor],
        stops: const [.1, 1],
      ),
      barWidth: 5,
      isCurved: false,
    );
  }

/////////////Terminar la conexión de la base de datos y el timer///////////////

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    pulseSu?.cancel();
  }
}
