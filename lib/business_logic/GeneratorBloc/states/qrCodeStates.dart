import 'dart:io';

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class QrCodeStates {}

class QrCodeInitial extends QrCodeStates {
  Text initialMessage = Text(
    "Welcome to SnapQR",
    style: GoogleFonts.ubuntu(
        textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
  );
}

class QrCodeLoading extends QrCodeStates {
  CircularProgressIndicator loading;

  QrCodeLoading({required this.loading});
}

class QrCodeError extends QrCodeStates {
  Text errorMessage = Text(
    "Failed to generate the QR code !",
    style: GoogleFonts.ubuntu(
        textStyle: const TextStyle(
            fontSize: 25, fontWeight: FontWeight.w600, color: Colors.red)),
  );
}

class QrCodeLoaded extends QrCodeStates {
  RepaintBoundary qrImageView;

  QrCodeLoaded({required this.qrImageView});
}

class SaveQrcodeAsImage extends QrCodeStates {
  GlobalKey globalkey;

  SaveQrcodeAsImage({required this.globalkey});

  Future<bool> requestPermissions() async {
    var status = await Permission.storage.status;

    /// if the permission is not guarented it will send a request simple
    if (!status.isGranted) {
      PermissionStatus isPermitted = await Permission.photos.request();
      if (isPermitted.isGranted) {
        return true;
      } else {
        return false;
      }
    }
    return true;
  }

  Future<void> saveQr(BuildContext context, String folderName) async {
    bool requestValid = await requestPermissions();
    if (requestValid) {
      try {
        /// capturing the logic:
        RenderRepaintBoundary boundary = globalkey.currentContext!
            .findRenderObject() as RenderRepaintBoundary;
        ui.Image image = await boundary.toImage(pixelRatio: 10.0);
        var byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        var pngBytes = byteData!.buffer.asUint8List();

        /// save image logic :
        /// 1 we have to create the file where we stock the image
        ///
        final String dirpath = '/storage/emulated/0/Pictures/$folderName';
        await Directory(dirpath).create(recursive: false);
        final File file = File(
            '$dirpath/IMG-${DateTime.now().millisecondsSinceEpoch}_snapQr.png');

        /// 2 then here we put the pngBytes getting from
        /// the RenderRepaintBoundary inside the file created
        await file.writeAsBytes(pngBytes);
        final result = await ImageGallerySaver.saveImage(pngBytes,
            name: "/IMG-${DateTime.now().millisecondsSinceEpoch}_snapQr.png");

        /// show success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Image saved succesfully!",
                style: GoogleFonts.ubuntu(
                    textStyle: const TextStyle(
                        fontSize: 23,
                        fontWeight: ui.FontWeight.w600,
                        color: Colors.green)))));
      } catch (e) {
        throw Exception(e);
      }
    } else {
      throw Exception("Permission disabled! ");
    }
  }
}
