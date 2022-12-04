import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:path/path.dart';
import 'package:skooleneducation/book/pdf_home.dart';

class PDFViewer extends StatefulWidget {
  final File file;
  const PDFViewer({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  PDFViewController? controller;
  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    final text = '${indexPage + 1}/$pages';

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        leading: IconButton(
          splashRadius: 19,
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PDFHome()),
            );
          },
        ),
        actions: pages >= 2
            ? [
                Center(
                  child: Text(text),
                ),
                IconButton(
                  onPressed: () {
                    final page = indexPage == 0 ? pages : indexPage - 1;
                    controller?.setPage(page);
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    size: 32,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    final page = indexPage == pages - 1 ? 0 : indexPage + 1;
                    controller?.setPage(page);
                  },
                  icon: Icon(
                    Icons.chevron_right,
                    size: 32,
                  ),
                ),
              ]
            : null,
      ),
      body: PDFView(
        filePath: widget.file.path,
        autoSpacing: true,
        pageSnap: true,
        pageFling: false,
        onRender: (pages) => setState(() => this.pages = pages!),
        onViewCreated: (controller) => setState(() => this.controller),
        onPageChanged: (indexPage, _) =>
            setState(() => this.indexPage = indexPage!),
      ),
    );
  }
}
