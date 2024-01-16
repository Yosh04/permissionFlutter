import 'package:flutter/material.dart';
import 'package:flutter_pruebas/utils.dart';

class EmpyScreen extends StatelessWidget {
  const EmpyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                createFolder2();
              },
              child: const Text("Crear folder"),
            ),
            ElevatedButton(
              onPressed: () {
                generateAndSavePDF2();
                pickFile("/storage/emulated/0/formularios/ejemplo.pdf");
              },
              child: const Text('Crear Archivo'),
            ),
          ],
        ),
      ),
    );
  }
}
