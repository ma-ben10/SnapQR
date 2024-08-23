import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:snap_qr/business_logic/GeneratorBloc/events/qrCodeEvents.dart';
import 'package:snap_qr/business_logic/GeneratorBloc/states/qrCodeStates.dart';

import '../../../data/repositories/qrCoderepository.dart';

class QrCodeBloc extends Bloc<QrCodeEvents, QrCodeStates> {
  QrCodeRepository qrCodeRepository;

  QrCodeBloc({required this.qrCodeRepository})
      : super(QrCodeLoaded(
            qrImageView: RepaintBoundary(
                key: qrCodeRepository.globalKey,
                child: QrImageView(
                  data: "Welcome to SnapQR",
                  size: 270,
                )))) {
    on<GenerateFromText>((event, emit) async {
      emit(QrCodeLoading(
          loading: const CircularProgressIndicator(
        color: Colors.black87,
      )));
      try {
        qrCodeRepository.createQr(event.text);
        emit(QrCodeLoaded(qrImageView: qrCodeRepository.qrCode.qrImageView));
      } catch (e) {
        emit(QrCodeError());
        throw Exception("Failed to generate the QR code : $e");
      }
    });
    on<GenerateFromImage>((event, emit) async {
      emit(QrCodeLoading(
          loading: const CircularProgressIndicator(color: Colors.black87)));
      try {} catch (e) {}
    });
    on<SaveQrCode>((event, emit) async {
      emit(QrCodeLoading(
          loading: const CircularProgressIndicator(
        color: Colors.black87,
      )));
      try {
        emit(SaveQrcodeAsImage(globalkey: qrCodeRepository.globalKey));
      } catch (e) {
        emit(QrCodeError());
        throw Exception("Failed to save the QR code $e");
      }
    });
  }
}
