import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../event/scannerQrEvent.dart';
import '../state/scannerQrState.dart';

class ScannerQrBloc extends Bloc<ScannerQrEvent, ScannerQrState> {
  ScannerQrBloc() : super(ScannerInit()) {
    on<CatchDataFromQr>((event, emit) async {
      emit(AfterDetectionLoading());
      try {
        emit(AfterDetectionLoaded(data: event.data));
      } catch (e) {
        emit(ScannerError(errorMessage: "Error to catch the embedded data !"));
      }
    });
  }
}
