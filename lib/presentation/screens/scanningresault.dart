import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_qr/business_logic/ScannerBloc/bloc/scannerBloc.dart';

import '../../business_logic/ScannerBloc/state/scannerQrState.dart';

class scanner extends StatelessWidget {
  const scanner({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.white, body: Placeholder());
  }
}
