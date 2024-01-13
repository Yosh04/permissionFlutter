import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pruebas/utils.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the
        //theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  late Directory directoryFile;

  


  @override
  void initState() {
    super.initState();
    //_checkPermission();
    createFolder();
    _checkPermission();
  }

  ///Chequeador de permisos para la app.
  Future<void> _checkPermission() async {
    var status = await Permission.manageExternalStorage.status;
    //print(status.isDenied);
    print("Estado del permiso en checkPermission ${status.isGranted}");

    if (status.isGranted) {
      print("Ya los tengo");
      //Permission.manageExternalStorage.status;
    } else {
      print("Necesito pedir mis permisos.");
      //await Permission.manageExternalStorage.request();
      // Esto funciona para abrir la ventana de ajustes para los permisos.
      //openAppSettings();
    }
  }

    void _generateAndSavePDF() async {

    final externalDir = await getExternalStorageDirectory();
    final newFolder =
        Directory('${externalDir!.path}/formularios');
    

    final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Center(
            child:
                pw.Text('¡Hola, este es un documento PDF generado en Flutter!'),
          ),
        ),
      );

    final file = File('${newFolder!.path}/ejemplo.pdf');
    directoryFile = Directory('${externalDir!.path}/formularios/ejemplo.pdf');
    await file.writeAsBytes(await pdf.save());

    print('PDF guardado en: ${file.path}');

  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("My permission and making dirs",
                style: TextStyle(
                    backgroundColor: Colors.blueGrey[200],
                    color: Colors.amber[600],
                    fontFamily: 'Roboto',
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    wordSpacing: 50,
                    letterSpacing: 20)),
            IconButton(
                onPressed: () async {
                  // _createFolder();
                  _generateAndSavePDF();
                },
                icon: Icon(Icons.check)),
            IconButton(
                onPressed: () async {
                  // _createFolder();
                  //openFile("${directoryFile.path}/ejemplo0.pdf");
                  pickFile(directoryFile.path);

                },
                icon: Icon(Icons.home)),

            /*       
            IconButton(
                onPressed: () async{
                   await generateAndSavePDF();
                },
                icon: Icon(Icons.abc_outlined))
            */
          ],
        ),
      ),
    );
  }
}
