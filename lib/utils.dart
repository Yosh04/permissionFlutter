import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:open_file/open_file.dart';

Timer? timer;

void createFolder() async {
  final externalDir = await getExternalStorageDirectory();
  print(externalDir);
  if (externalDir != null) {
    final newFolder =
        Directory('${externalDir.path}/formularios');

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
    final newFolder =
        Directory('${externalDir.path}/formularios');
    return newFolder;
  } else {
    print('cant access to storage');
    return null;
  }
}


