import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

class PermissionModel extends ChangeNotifier {
  bool _status = false;

  bool get status => _status;

  set setStatusPermission(bool value) {
    _status = value;
    notifyListeners();
  }

  Future<void> initPermission() async {
    var version = await _isAndroidTenOrLower();

    if (version == true) {
      var permission = await Permission.storage.isGranted;
      print("Estado del permiso en checkPermission: $permission");

      if (permission == true) {
        print("Permiso de almacenamiento concedido");
        setStatusPermission = true;
      }
    } else {
      var permission = await Permission.manageExternalStorage.isGranted;
      if (permission) {
        print("Permiso de gestión de almacenamiento externo concedido");
        setStatusPermission = true;
      } else {
        print("Permiso de gestión de almacenamiento externo no concedido");
      }
    }

    // Puedes imprimir el estado final del permiso si es necesario
    print("Estado final del permiso: $status");
  }

  Future<void> checkPermission() async {
    var version = await _isAndroidTenOrLower();

    if (version == true) {
      var permission = await Permission.storage.request();
      print("Estado del permiso en checkPermission ${permission.isGranted}");
      switch (permission) {
        case PermissionStatus.granted:
          setStatusPermission = true;
          break;
        case PermissionStatus.permanentlyDenied:
        case PermissionStatus.denied:
        case PermissionStatus.limited:
        case PermissionStatus.provisional:
        case PermissionStatus.restricted:
          setStatusPermission = false;
          openAppSettings();
      }
    } else {
      var permission = await Permission.manageExternalStorage.request();
      print("Estado del permiso en checkPermission ${permission.isGranted}");
      switch (permission) {
        case PermissionStatus.granted:
          setStatusPermission = true;
          break;
        case PermissionStatus.permanentlyDenied:
        case PermissionStatus.provisional:
        case PermissionStatus.denied:
        case PermissionStatus.limited:
        case PermissionStatus.restricted:
          setStatusPermission = false;
          openAppSettings();
      }
    }
  }

  Future<bool> _isAndroidTenOrLower() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    int sdkInt = androidInfo.version.sdkInt;
    return sdkInt <= 29; // Android 10 tiene el número de SDK 29
  }

  Future<bool> _showStoragePermissionAlert(BuildContext context) async {
    bool permissionGranted = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permisos de Almacenamiento'),
          content: const Text(
              'La aplicación necesita permisos de almacenamiento para funcionar correctamente.'),
          actions: [
            TextButton(
              onPressed: () async {
                await openAppSettings();
                Navigator.of(context).pop();
              },
              child: Text('Allow'),
            ),
          ],
        );
      },
    );
    return permissionGranted;
  }
}
