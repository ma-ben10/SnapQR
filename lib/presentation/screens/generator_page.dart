import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:snap_qr/business_logic/GeneratorBloc/blocs/qrCodeBloc.dart';
import 'package:snap_qr/business_logic/GeneratorBloc/events/qrCodeEvents.dart';
import 'package:snap_qr/business_logic/GeneratorBloc/states/qrCodeStates.dart';
import 'package:snap_qr/data/repositories/qrCoderepository.dart';

class generator extends StatefulWidget {
  const generator({super.key});

  @override
  State<generator> createState() => _generatorState();
}

class _generatorState extends State<generator> {
  final TextEditingController controller = TextEditingController();
  late QrCodeBloc qrCodeBloc;

  @override
  void initState() {
    super.initState();
    qrCodeBloc = QrCodeBloc(qrCodeRepository: QrCodeRepository());
  }

  @override
  void dispose() {
    qrCodeBloc.close();
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: [
        Column(children: [
          Text(
            "Welcome to SnapQR",
            style: GoogleFonts.ubuntu(
                textStyle:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocConsumer<QrCodeBloc, QrCodeStates>(
              bloc: qrCodeBloc,
              builder: (context, state) {
                if (state is QrCodeInitial) {
                  return state.initialMessage;
                } else if (state is QrCodeLoading) {
                  return state.loading;
                } else if (state is QrCodeError) {
                  return state.errorMessage;
                } else if (state is QrCodeLoaded) {
                  return state.qrImageView;
                } else {
                  return qrCodeBloc.qrCodeRepository.qrCode.qrImageView;
                }
              },
              listener: (context, state) async {
                if (state is QrCodeError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: state.errorMessage,
                    backgroundColor: Colors.red,
                  ));
                } else if (state is SaveQrcodeAsImage) {
                  await state.saveQr(context, "snap_qr");
                }
              }),
          const SizedBox(
            height: 30,
          ),
          Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "enter whatever you wante to code",
                      hintStyle: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600))),
                  onChanged: (context) {
                    qrCodeBloc.add(GenerateFromText(text: controller.text));
                  },
                  onSubmitted: (context) {
                    qrCodeBloc.add(GenerateFromText(text: controller.text));
                  })),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          FloatingActionButton(
            onPressed: () {
              qrCodeBloc.add(SaveQrCode());
            },
            backgroundColor: Colors.black87,
            child: const Icon(
              Icons.save_alt,
              color: Colors.white,
            ),
          )
        ])
      ]),
    );
  }
}
