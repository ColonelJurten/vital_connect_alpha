import 'package:vital_connect_alpha/widget/pulse_widget.dart';
import 'package:flutter/material.dart';
import 'package:vital_connect_alpha/widget/temp_widget.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  MqttServerClient? _mqttClient;
  String _alertaMensaje1 = '';
  String _alertaMensaje2 = '';

  @override
  void initState() {
    super.initState();
    // Configurar MQTT
    const mqttBroker = 'broker.emqx.io'; // Cambia esto por tu broker MQTT
    const mqttPort = 1883;
    const mqttClientId = 'flutter_client';
    const mqttTopic = 'frecuencia/alerta';
    const mqttTopic2 =
        'temperatura/alerta'; // Cambia esto por el tópico que desees

    _mqttClient = MqttServerClient(mqttBroker, mqttClientId);
    _mqttClient?.port = mqttPort;
    _mqttClient?.keepAlivePeriod = 60;
    _mqttClient?.autoReconnect = true;
    _mqttClient?.logging(on: false);

    // Configurar las opciones de conexión
    _mqttClient?.onConnected = _onConnected;
    _mqttClient?.onDisconnected = _onDisconnected;
    _mqttClient?.onSubscribed = _onSubscribed;

    // Conectar al broker
    _connectMQTT();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Estatus del Usuario',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.tealAccent[700],
      ),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                  child: Column(
                children: <Widget>[
                  // Muestra el mensaje de alerta si está presente
                  if (_alertaMensaje1.isNotEmpty)
                    Text(
                      'Alerta: $_alertaMensaje1',
                      style: const TextStyle(fontSize: 20, color: Colors.red),
                    ),
                ],
              )),
              const PulseChart(),
              const Divider(),
              Card(
                  child: Column(
                children: <Widget>[
                  // Muestra el mensaje de alerta si está presente
                  if (_alertaMensaje2.isNotEmpty)
                    Text(
                      'Alerta: $_alertaMensaje2',
                      style: const TextStyle(fontSize: 20, color: Colors.red),
                    ),
                ],
              )),
              const TempChart(),
            ],
          ),
        ),
      ),
    );
  }

///////////////////////////////METODO PARA LAS ALERTAS DE FRECUENCIA
  Future<void> _connectMQTT() async {
    try {
      await _mqttClient?.connect();
      _mqttClient?.subscribe('frecuencia/alerta', MqttQos.atMostOnce);
      _mqttClient?.subscribe('temperatura/alerta', MqttQos.atMostOnce);
      _mqttClient?.updates?.listen(_onMessageReceived);
    } catch (e) {
      print('Error de conexión: $e');
    }
  }

  // Método que se llama cuando la conexión se establece
  void _onConnected() {
    print('Conectado a MQTT broker');
  }

  // Método que se llama cuando la conexión se pierde
  void _onDisconnected() {
    print('Desconectado de MQTT broker');
  }

  // Método que se llama cuando la suscripción se realiza con éxito
  void _onSubscribed(String topic) {
    print('Suscrito a tópico: $topic');
  }

  // Maneja los mensajes recibidos
  void _onMessageReceived(List<MqttReceivedMessage<MqttMessage>> c) {
    final recMsg = c[0].payload as MqttPublishMessage;
    final message =
        MqttPublishPayload.bytesToStringAsString(recMsg.payload.message);
    print('Mensaje recibido en el tópico ${c[0].topic}: $message');

    // Actualiza el estado con el mensaje recibido
    setState(() {
      if (message.trim() == 'Frecuencia cardiaca alta') {
        _alertaMensaje1 = message;

        // Restablece el mensaje después de un tiempo
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            _alertaMensaje1 = '';
          });
        });
      } else {
        _alertaMensaje1 = '';
      }
      if (message.trim() == 'Temperatura alta') {
        _alertaMensaje2 = message;

        // Restablece el mensaje después de un tiempo
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            _alertaMensaje2 = '';
          });
        });
      } else {
        _alertaMensaje2 = '';
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _mqttClient?.disconnect();
  }
}
