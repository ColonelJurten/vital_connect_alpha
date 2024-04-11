import 'package:flutter/material.dart';
import 'package:vital_connect_alpha/provider/Email_support.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

//// Widget para el formulario ////

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Soporte Técnico',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.tealAccent[700],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          const SizedBox(
            height: 20.0,
          ),

//// Cards de formulario de contacto ////

          _crearCardA(),
          const Divider(),
          _crearCardP(),
        ],
      ),
    );
  }

//// Diseño de Formulario de correo electrónico ////

  Widget _crearCardA() {
    final card = Container(
      child: Column(
        children: [
          const FadeInImage(
            placeholder: AssetImage('assets/images/loading.gif'),
            image: AssetImage('assets/images/Developer.jpg'),
            height: 300.0,
            fit: BoxFit.cover,
          ),
          Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Tec. Alberto Saucedo Juárez',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0),
                ),
                TextFormField(
                  controller: nameA,
                  decoration: const InputDecoration(
                    hintText: 'Nombre de Usuario',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  controller: emailA,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  controller: subjectA,
                  decoration: const InputDecoration(
                    hintText: 'Asunto',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  controller: messageA,
                  decoration: const InputDecoration(
                    hintText: 'Mensaje',
                    border: OutlineInputBorder(),
                  ),
                ),
                ElevatedButton(

//// Metodo para denegar en envio del correo si el formulario no esta lleno

                    onPressed: () {
                      if (nameA.text.isEmpty &&
                          emailA.text.isEmpty &&
                          subjectA.text.isEmpty &&
                          messageA.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Error de Envio"),
                            content: const Text(
                                "Debe llenar el formulario para enviar su queja"),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  child: const Text("Entendido",
                                      style: TextStyle(
                                        color: Colors.black,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
//// Metodo para enviar el correo y limpiar el formulario ////

                        sendEmailA();
                        nameA.clear();
                        emailA.clear();
                        subjectA.clear();
                        messageA.clear();

                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Correo Enviado"),
                            content: const Text(
                                "Tu queja se a enviado con exito, gracias por tu aporte"),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  child: const Text("Bien",
                                      style: TextStyle(
                                        color: Colors.black,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.tealAccent[700]),
                    child: const Text(
                      'Enviar al Correo',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 10.0),
            ),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: card,
      ),
    );
  }

//// Diseño de Formulario de correo electrónico ////

  Widget _crearCardP() {
    final card = Container(
      child: Column(
        children: [
          const FadeInImage(
            placeholder: AssetImage('assets/images/loading.gif'),
            image: AssetImage('assets/images/Technician.jpg'),
            height: 300.0,
            fit: BoxFit.cover,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Tec. Pablo Humberto Resendiz Valerio',
                  style: TextStyle(fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
                TextField(
                  controller: nameP,
                  decoration: const InputDecoration(
                    hintText: 'Nombre de Usuario',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: emailP,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: subjectP,
                  decoration: const InputDecoration(
                    hintText: 'Asunto',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: messageP,
                  decoration: const InputDecoration(
                    hintText: 'Mensaje',
                    border: OutlineInputBorder(),
                  ),
                ),
                ElevatedButton(

//// Metodo para denegar en envio del correo si el formulario no esta lleno

                    onPressed: () {
                      if (nameP.text.isEmpty &&
                          emailP.text.isEmpty &&
                          subjectP.text.isEmpty &&
                          messageP.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Error de Envio"),
                            content: const Text(
                                "Debe llenar el formulario para enviar su queja"),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  child: const Text("Entendido",
                                      style: TextStyle(
                                        color: Colors.black,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
//// Metodo para enviar el correo y limpiar el formulario ////

                        sendEmailP();
                        nameP.clear();
                        emailP.clear();
                        subjectP.clear();
                        messageP.clear();
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Correo Enviado"),
                            content: const Text(
                                "Tu queja se a enviado con exito, gracias por tu aporte"),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  child: const Text("Bien",
                                      style: TextStyle(
                                        color: Colors.black,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.tealAccent[700]),
                    child: const Text(
                      'Enviar al Correo',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 10.0),
            ),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: card,
      ),
    );
  }
}
