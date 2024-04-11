import 'package:vital_connect_alpha/widget/pulse_widget.dart';
import 'package:flutter/material.dart';
import 'package:vital_connect_alpha/widget/temp_widget.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Estatus del Usuario',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.tealAccent[700],
      ),
      body: const Center(
          child: Column(
//// Base para desplegar las tablas dinámicas ////

        children: [PulseChart(), TempChart()],
      )),
    );
  }
}
