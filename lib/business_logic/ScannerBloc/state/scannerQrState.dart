import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snap_qr/business_logic/ScannerBloc/state/customErrorWidget.dart';

import 'customDataWindow.dart';

abstract class ScannerQrState {}

class ScannerInit extends ScannerQrState {
  Future<bool> checkCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      PermissionStatus isPermitted = await Permission.camera.request();
      if (isPermitted.isGranted) {
        return true;
      } else {
        return false;
      }
    }
    return true;
  }
}

class AfterDetectionLoading extends ScannerQrState {
  CircularProgressIndicator circularProgressIndicator =
      CircularProgressIndicator(
    color: Colors.black87,
  );
}

class AfterDetectionLoaded extends ScannerQrState {
  String data;
  late CustomDataWindow dataWindow;

  AfterDetectionLoaded({required this.data}) {
    dataWindow = CustomDataWindow(data: data);
  }
}

class ScannerError extends ScannerQrState {
  String errorMessage;
  CustomErrorWidget errorWidget = CustomErrorWidget();

  ScannerError({required this.errorMessage}) {
    errorWidget.errorMessage = errorMessage;
  }
}
