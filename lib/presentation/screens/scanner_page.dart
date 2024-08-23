import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_qr/business_logic/ScannerBloc/bloc/scannerBloc.dart';
import 'package:snap_qr/business_logic/ScannerBloc/event/scannerQrEvent.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:snap_qr/business_logic/ScannerBloc/state/scannerQrState.dart';
import '../../business_logic/ScannerBloc/state/customDataWindow.dart';
import 'scanningresault.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  late MobileScannerController mobileScannerController;
  late ScannerQrBloc scannerQrBloc;

  @override
  void initState() {
    super.initState();
    scannerQrBloc = ScannerQrBloc();
  }

  @override
  void dispose() {
    mobileScannerController.dispose();
    scannerQrBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mobileScannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      autoStart: true,
    );
    return BlocProvider(
      create: (context) => scannerQrBloc,
      child: Scaffold(
        body: MobileScanner(
          controller: mobileScannerController,
          onDetect: (capture) {
            String? result = capture.barcodes.first.displayValue;
            if (result != null) {
              CustomDataWindow customDataWindow =
                  CustomDataWindow(data: result);
              customDataWindow.showErrorDialog(context);
            }
          },
        ),
      ),
    );
  }
}
