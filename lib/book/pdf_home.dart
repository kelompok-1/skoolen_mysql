import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:skooleneducation/book/pdf_api.dart';
import 'package:skooleneducation/book/pdf_view.dart';

class PDFHome extends StatefulWidget {
  const PDFHome({super.key});

  @override
  State<PDFHome> createState() => _PDFHomeState();
}

class _PDFHomeState extends State<PDFHome> {
  circularProgress() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
            child: CircularProgressIndicator(
          color: Colors.amber,
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Flutter PDF Tutorial"),
        ),
        body: Center(
          child: Builder(
            builder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text("Open from URL"),
                  onPressed: () async {
                    circularProgress();
                    final url =
                        "https://firebasestorage.googleapis.com/v0/b/skoolen-stable.appspot.com/o/images1%2FBKPM%20-%20Workshop%20Mobile%20Framework%20(2022).pdf?alt=media&token=af52ba27-9942-4323-aee6-89cdf4fd802d";
                    final file = await PDFApi.loadNetwork(url);
                    Navigator.of(context).pop();
                    openPDF(context, file);
                  },
                ),
              ],
            ),
          ),
        ),
      );
  void openPDF(BuildContext context, File file) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => PDFViewer(file: file)));
}
