import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///CustomDataWindow
class CustomDataWindow {
  String data;

  CustomDataWindow({required this.data});

  void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Data Catched !',
              style: GoogleFonts.ubuntu(
                  textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87))),
          content: SingleChildScrollView(
              child: SelectableText(
            data,
            textAlign: TextAlign.center,
            style: GoogleFonts.ubuntu(
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87)),
          )),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Return'),
            ),
          ],
        );
      },
    );
  }
}
