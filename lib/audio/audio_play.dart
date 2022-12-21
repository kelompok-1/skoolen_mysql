import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'audio_model.dart';

class AudioPlay extends StatefulWidget {
  final AudioModel audioModel;
  final int index;
  const AudioPlay({required this.audioModel, required this.index});
  @override
  State<AudioPlay> createState() => _AudioPlayState();
}

class _AudioPlayState extends State<AudioPlay> {
  final player = AudioPlayer();
  bool isplaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    setAudio();
    super.initState();
    player.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          isplaying = state == PlayerState.playing;
        });
      }
    });

    player.onDurationChanged.listen((newDuration) {
      if (mounted) {
        setState(() {
          duration = newDuration;
        });
      }
    });

    player.onPositionChanged.listen((newPosition) {
      if (mounted) {
        setState(() {
          position = newPosition;
        });
      }
    });

    if (widget.index != null) {
      nama_audio.text = widget.audioModel.nama_audio;
      nama_author.text = widget.audioModel.nama_author;
      gambar.text = widget.audioModel.gambar;
      link_audio.text = widget.audioModel.link_audio;
    }
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  String? time(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(
      duration.inMinutes.remainder(60),
    );
    final minutes = twoDigits(
      duration.inMinutes.remainder(60),
    );
    final seconds = twoDigits(
      duration.inMinutes.remainder(60),
    );

    return [if (duration.inHours > 0) hours, minutes, seconds].join();
  }

  Future setAudio() async {
    player.setReleaseMode(ReleaseMode.loop);
    String url = widget.audioModel.link_audio;
    player.setSourceUrl(url);
  }

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

  TextEditingController nama_audio = TextEditingController();
  TextEditingController nama_author = TextEditingController();
  TextEditingController gambar = TextEditingController();
  TextEditingController link_audio = TextEditingController();
  bool editMode = false;
  // add(BookModel bookModel) async {
  //   await BookService().addBook(bookModel).then((success) {
  //     Navigator.pop(context);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.audioModel.nama_audio),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.audioModel.gambar,
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 32),
            Text(
              widget.audioModel.nama_audio,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              widget.audioModel.nama_author,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Slider(
              activeColor: Colors.deepPurple,
              inactiveColor: Colors.amber,
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await player.seek(position);

                await player.resume;
              },
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(time(duration) ?? ""),
                  // Text(time(duration - position) ?? ""),
                ],
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.deepPurple,
              radius: 35,
              child: IconButton(
                color: Colors.white,
                onPressed: () async {
                  if (isplaying) {
                    await player.pause();
                  } else {
                    await player.resume();
                  }
                },
                icon: Icon(
                  isplaying ? Icons.pause : Icons.play_arrow,
                ),
                iconSize: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
