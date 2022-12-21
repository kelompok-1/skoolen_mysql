import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AudioView extends StatefulWidget {
  const AudioView({super.key});

  @override
  State<AudioView> createState() => _AudioViewState();
}

class _AudioViewState extends State<AudioView> {
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
    String url =
        "https://firebasestorage.googleapis.com/v0/b/skoolen-stable.appspot.com/o/audio%2Fy2mate.com%20-%20Run%20%20Sound%20Effect%20Perfect%20Cut.mp3?alt=media&token=057d3414-be9f-43c8-85e9-b3beb70d04fb";
    player.setSourceUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio'),
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
                'https://firebasestorage.googleapis.com/v0/b/skoolen-stable.appspot.com/o/buku%2Fgambar%2F81N6Go0iECL.jpg?alt=media&token=89fa8c56-d457-4f80-83c0-f175a53784d4',
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 32),
            Text(
              'The Flutter Song',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              'Sarah Abs',
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
