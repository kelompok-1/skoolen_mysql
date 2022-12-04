import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skooleneducation/book/book_model.dart';
import 'package:skooleneducation/book/book_service.dart';
import 'package:skooleneducation/book/pdf_api.dart';
import 'package:skooleneducation/book/pdf_view.dart';

class BookDetail extends StatefulWidget {
  final BookModel bookModel;
  final int index;
  BookDetail({required this.bookModel, required this.index});

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
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

  TextEditingController nm_barang = TextEditingController();
  TextEditingController stok_barang = TextEditingController();
  TextEditingController gambar_buku = TextEditingController();
  bool editMode = false;
  add(BookModel bookModel) async {
    await BookService().addBook(bookModel).then((success) {
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      nm_barang.text = widget.bookModel.nm_barang;
      stok_barang.text = widget.bookModel.stok;
      gambar_buku.text = widget.bookModel.gambar;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add")),
      body: Column(
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     controller: nm_barang,
          //     decoration: InputDecoration(hintText: 'Enter Name'),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     controller: stok_barang,
          //     decoration: InputDecoration(hintText: 'Enter Stok'),
          //   ),
          // ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 200,
                height: 320,
                color: Colors.transparent,
                child: Image.network(
                  widget.bookModel.gambar,
                  // height: 200,
                  // width: 400,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              circularProgress();
              final url = widget.bookModel.pdf_link;
              final file = await PDFApi.loadNetwork(url);
              Navigator.of(context).pop();
              openPDF(context, file);
            },
            child: Text("Lihat Buku"),
          ),
        ],
      ),
    );
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => PDFViewer(file: file)));
}
