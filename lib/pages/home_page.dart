import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skooleneducation/audio/audio_list.dart';
import 'package:skooleneducation/audio/audio_view.dart';
import 'package:skooleneducation/book/book_view.dart';
import 'package:skooleneducation/pages/condition_policy_page.dart';
import 'package:skooleneducation/pages/login_page.dart';
import 'package:skooleneducation/pages/logout.dart';
import 'package:skooleneducation/pages/register_page.dart';
import 'package:skooleneducation/speech/speech_screen.dart';
import 'package:skooleneducation/video/video_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    VideoView(),
    BookView(),
    AudioList(),
    SpeechScreen(),
    Logout(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        backgroundColor: Colors.grey[200],
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey[00],
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_fill_sharp), label: "Video"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Buku"),
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: "Audio"),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Speaking"),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Keluar"),
        ],
      ),
    );
  }
}
