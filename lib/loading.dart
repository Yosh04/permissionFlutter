import 'package:flutter/material.dart';
import 'package:flutter_pruebas/EmpyScreen.dart';
import 'package:flutter_pruebas/Homepage.dart';
import 'package:flutter_pruebas/model.dart';
import 'package:provider/provider.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    final modelo = Provider.of<PermissionModel>(context);
    print(modelo.status);
    return Scaffold(
      body: Builder(
        builder: (context) {
          return modelo.status
              ? const EmpyScreen()
              : const MyHomePage(title: "Pruebas Flutter");
        },
      ),
    );
  }
}
