import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pruebas/model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final modelo = Provider.of<PermissionModel>(context);
    //modelo.checkPermission(modelo);

    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.blue[700], // Color de fondo del AppBar
        elevation: 0, // Elimina la sombra del AppBar
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons
                  .lock, // Ícono de candado para representar la pantalla de inicio de sesión
              color: Colors.white, // Color del ícono
            ),
            SizedBox(width: 8),
            Text(
              'Inicio de sesión',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Color del texto del título
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 32,
                  margin: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: MediaQuery.of(context).size.height / 8,
                  ),
                  color: Colors.black.withOpacity(0.2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Es necesario el acceso al almacenamiento"),
                      ElevatedButton(
                        onPressed: () {
                          // Tu acción cuando se presiona el botón
                          modelo.checkPermission();
                        },
                        child: const Text('Solicitar acceso'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
