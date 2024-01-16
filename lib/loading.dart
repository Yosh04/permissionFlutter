import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pruebas/EmpyScreen.dart';
import 'package:flutter_pruebas/Homepage.dart';
import 'package:flutter_pruebas/model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool check = false;
    final modelo = Provider.of<PermissionModel>(context);
    print(modelo.status);
    return Scaffold(
      body: Builder(
        builder: (context) {
          while (true) {
            if (check == false && !modelo.status) {
              check = true;
              return const MyHomePage(title: "Pruebas Flutter");
            } else if (check == true && modelo.status) {
              return const EmpyScreen();
            }
          }
        },
      ),
    );
  }
}
