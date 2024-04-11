import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

///Declarar las variables para editar el texto del formulario//

final nameA = TextEditingController();
final emailA = TextEditingController();
final subjectA = TextEditingController();
final messageA = TextEditingController();
final nameP = TextEditingController();
final emailP = TextEditingController();
final subjectP = TextEditingController();
final messageP = TextEditingController();

//// Metodo para enviar correos electronicos por medio del servicio emailjs

Future sendEmailA() async {
//// Declarar las variables de conexión con el servicio
  const serviceId = 'service_g73ehoc';
  const templateId = 'template_6jythup';
  const userId = 'yBENapPlphNJKG4Th';
//// Conectar al servicio del correo por medio de su url ////
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(
    url,
    headers: {
      'origin': 'http://localhost',
      'Content-Type': 'application/json',
    },
//// Convertir los valores del formulario a json para su envío ////
    body: json.encode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
        'user_name': nameA.text,
        'user_email': emailA.text,
        'user_subject': subjectA.text,
        'user_message': messageA.text,
      }
    }),
  );
  return response.statusCode;
}

//// Metodo para enviar correos electronicos por medio del servicio emailjs

Future sendEmailP() async {
  //// Declarar las variables de conexión con el servicio
  const serviceId = 'service_g73ehoc';
  const templateId = 'template_o9up65n';
  const userId = 'yBENapPlphNJKG4Th';
//// Conectar al servicio del correo por medio de su url ////
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(
    url,
    headers: {
      'origin': 'http://localhost',
      'Content-Type': 'application/json',
    },
//// Convertir los valores del formulario a json para su envío ////
    body: json.encode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
        'user_name': nameP.text,
        'user_email': emailP.text,
        'user_subject': subjectP.text,
        'user_message': messageP.text,
      }
    }),
  );
  return response.statusCode;
}
