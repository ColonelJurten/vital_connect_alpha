import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'VitalConnect',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.tealAccent[700],
        centerTitle: true,
      ),

//// Menu desplegable ////

      drawer: Drawer(
        backgroundColor: Colors.tealAccent[700],
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
//// Contenedor para el logo y el nombre de la app
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.only(top: 50, bottom: 20),
              child: Image.asset('assets/images/ImageVital.png'),
            ),
            const Text(
              'VitalConnect',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            ////// Boton de navegación para la pestaña de Estatus////
            ListTile(
              contentPadding: const EdgeInsets.all(25),
              title: const Text('Estatus',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              tileColor: Colors.blueGrey[50],
              leading: const Icon(Icons.accessibility_outlined),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, 'status');
              },
            ),
            const Divider(),
            ///// Boton de Navegación para la pestaña de  soporte
            ListTile(
              contentPadding: const EdgeInsets.all(25),
              title: const Text(
                'Soporte Técnico',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              tileColor: Colors.blueGrey[50],
              leading: const Icon(Icons.contacts),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, 'support');
              },
            ),
          ],
        ),
      ),
    );
  }
}
