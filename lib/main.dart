// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:skooleneducation/book/book_view.dart';
import 'package:skooleneducation/book/pdf_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skoolen',
      debugShowCheckedModeBanner: false,
      home: BookView(),
    );
  }
}
