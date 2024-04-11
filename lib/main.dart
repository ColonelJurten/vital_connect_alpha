import 'package:flutter/material.dart';
import 'package:vital_connect_alpha/pages/Status_page.dart';
import 'package:vital_connect_alpha/pages/home_page.dart';
import 'package:vital_connect_alpha/pages/tecsup_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
/////////Rutas de la aplicación, iniciando por defecto en la pestaña de home//////

      initialRoute: 'home',
      routes: {
        'home': (context) => const HomePage(),
        'status': (context) => const StatusPage(),
        'support': (context) => const SupportPage()
      },
    );
  }
}
