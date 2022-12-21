// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:skooleneducation/audio/audio_list.dart';
import 'package:skooleneducation/pages/home_page.dart';
import 'package:skooleneducation/pages/login_page.dart';
import 'package:skooleneducation/speech/speech_screen.dart';

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
      home: LoginPage(),
    );
  }
}
