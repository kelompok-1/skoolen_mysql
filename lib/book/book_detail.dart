import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
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

  TextEditingController nama_buku = TextEditingController();
  TextEditingController nama_penulis = TextEditingController();
  TextEditingController deskripsi_buku = TextEditingController();
  TextEditingController jumlah_halaman = TextEditingController();
  TextEditingController gambar = TextEditingController();
  TextEditingController link_pdf = TextEditingController();
  bool editMode = false;
  // add(BookModel bookModel) async {
  //   await BookService().addBook(bookModel).then((success) {
  //     Navigator.pop(context);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      nama_buku.text = widget.bookModel.nama_buku;
      nama_penulis.text = widget.bookModel.nama_penulis;
      deskripsi_buku.text = widget.bookModel.deskripsi_buku;
      jumlah_halaman.text = widget.bookModel.jumlah_halaman;
      gambar.text = widget.bookModel.gambar;
      link_pdf.text = widget.bookModel.link_pdf;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(nama_buku.text),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextField(
            //     controller: nm_barang,
            //     decoration: InputDecoration(hintText: 'Enter Name'),
            //   ),
            // ),

            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 25, right: 25),
                child: Container(
                  width: 210,
                  height: 350,
                  color: Colors.deepPurple,
                  child: Image.network(
                    widget.bookModel.gambar,
                    // height: 200,
                    // width: 400,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Nama Penulis : " + nama_penulis.text,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.start,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Jumlah halaman : " + jumlah_halaman.text,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "DESKRIPSI : ",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                deskripsi_buku.text,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 1,
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () async {
                circularProgress();
                final url = widget.bookModel.link_pdf;
                final file = await PDFApi.loadNetwork(url);
                Navigator.of(context).pop();
                openPDF(context, file);
              },
              child: Text(
                "Baca Buku",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => PDFViewer(file: file)));
}
