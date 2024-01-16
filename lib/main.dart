import 'package:flutter/material.dart';
import 'package:flutter_pruebas/loading.dart';
import 'package:flutter_pruebas/model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PermissionModel permissionModel = PermissionModel();

  // Inicializar los permisos
  await permissionModel.initPermission();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: permissionModel),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Loading(),
    );
  }
}
