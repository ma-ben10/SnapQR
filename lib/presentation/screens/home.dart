import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snap_qr/presentation/screens/scanner_page.dart';
import 'package:snap_qr/presentation/screens/scanningresault.dart';

import 'generator_page.dart';

class home extends StatelessWidget {
  home({super.key});

  @override
  TextStyle _style = GoogleFonts.ubuntu(
      textStyle: TextStyle(
          fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white));

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3),
              child: Column(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => generator()));
                      },
                      child: Text(
                        'Generate',
                        style: _style,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Scanner()));
                      },
                      child: Text(
                        'scan',
                        style: _style,
                      ))
                ],
              ))),
    );
  }
}
