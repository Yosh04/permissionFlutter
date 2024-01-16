import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pruebas/model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Timer? timer;

late Directory directoryFile;
void createFolder() async {
  final externalDir = await getExternalStorageDirectory();
  print(externalDir);
  if (externalDir != null) {
    final newFolder = Directory('${externalDir.path}/formularios');

    if (await newFolder.exists()) {
      print('folder already exist: ${newFolder.path}');
    } else {
      try {
        await newFolder.create(recursive: true);
        print('folder created: ${newFolder.path}');
      } catch (e) {
        print('mistake to create folder: $e');
      }
    }
  } else {
    print('cant access to storage');
  }
}

void createFolder2() async {
  final externalDir = await getExternalStorageDirectory();
  print(externalDir);
  if (externalDir != null) {
    final newFolder = Directory('/storage/emulated/0/formularios');
    if (await newFolder.exists()) {
      print('folder already exist: ${newFolder.path}');
    } else {
      try {
        await newFolder.create(recursive: true);
        print('folder created: ${newFolder.path}');
      } catch (e) {
        print('mistake to create folder: $e');
      }
    }
  } else {
    print('cant access to storage');
  }
}

void _generateAndSavePDF() async {
  final externalDir = await getExternalStorageDirectory();
  final newFolder = Directory('${externalDir!.path}/formularios');

  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Text('¡Hola, este es un documento PDF generado en Flutter!'),
      ),
    ),
  );

  final file = File('${newFolder!.path}/ejemplo.pdf');
  directoryFile = Directory('${externalDir!.path}/formularios/ejemplo.pdf');
  await file.writeAsBytes(await pdf.save());

  print('PDF guardado en: ${file.path}');
}

void generateAndSavePDF2() async {
  final externalDir = await getExternalStorageDirectory();
  final newFolder = Directory('/storage/emulated/0/formularios');

  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Text('¡Hola, este es un documento PDF generado en Flutter!'),
      ),
    ),
  );

  final file = File('${newFolder!.path}/ejemplo.pdf');
  directoryFile = Directory('${externalDir!.path}/formularios/ejemplo.pdf');
  await file.writeAsBytes(await pdf.save());

  print('PDF guardado en: ${file.path}');
}

void testdirectory() async {
  String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
  print(selectedDirectory);
}

Future<List<FileSystemEntity>> pickDirectory(
    Future<Directory?> appDocumentsDirectory) async {
  final externalDir = await getExternalStorageDirectory();
  if (externalDir != null) {
    print('Access allowed');
    listFilesDirectory(appDocumentsDirectory);
    timer = Timer.periodic(const Duration(seconds: 20), (Timer t) {
      listFilesDirectory(appDocumentsDirectory);
    });
  } else {
    print('Denied access');
  }
  return listFilesDirectory(appDocumentsDirectory);
}

Future<List<FileSystemEntity>> listFilesDirectory(
    Future<Directory?> directories) async {
  final directory = await directories;
  List<FileSystemEntity> files = [];
  if (directory != null) {
    files = directory
        .listSync(recursive: true)
        .where((e) => e is File && e.path.endsWith('.pdf'))
        .toList();
  } else {
    print('Null dir');
  }
  print(files);
  return files;
}

void pickFile(String filePath) async {
  OpenFile.open(filePath); // Abre el archivo usando la ruta proporcionada
}

Future<Directory?> getdirectory() async {
  final externalDir = await getExternalStorageDirectory();
  if (externalDir != null) {
    final newFolder = Directory('${externalDir.path}/formularios');
    return newFolder;
  } else {
    print('cant access to storage');
    return null;
  }
}
