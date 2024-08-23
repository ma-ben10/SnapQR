import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../models/qrCode.dart';

class QrCodeRepository {
  Qrcode qrCode = Qrcode();
  GlobalKey globalKey = GlobalKey();

  void createQr(String data) {
    QrImageView qr = QrImageView(
      backgroundColor: Colors.white,
      data: data,
      size: 270,
    );
    qrCode.qrImageView = RepaintBoundary(
      key: globalKey,
      child: qr,
    );
  }
}
