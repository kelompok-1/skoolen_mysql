import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class TestVideo extends StatefulWidget {
  const TestVideo({super.key});

  @override
  State<TestVideo> createState() => _TestVideoState();
}

class _TestVideoState extends State<TestVideo> {
  late VideoPlayerController controller;
  ChewieController? chewieController;

  Future<void> loadVideoPlayer() async {
    controller = VideoPlayerController.network(
        "https://firebasestorage.googleapis.com/v0/b/skoolen-stable.appspot.com/o/video%2Fdetail_video%2Fdl29.y2mate.com.mp4?alt=media&token=79201f7a-6203-4ca4-ba2d-a14c5ae0dc4e");
    await Future.wait(
      [
        controller.initialize(),
      ],
    );

    chewieController = ChewieController(
        videoPlayerController: controller,
        autoPlay: false,
        looping: false,
        deviceOrientationsOnEnterFullScreen: [DeviceOrientation.landscapeRight],
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp]);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadVideoPlayer();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    // ]);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Video"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: chewieController != null &&
                      chewieController!
                          .videoPlayerController.value.isInitialized
                  ? Chewie(controller: chewieController!)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 20.0),
                        Text("loading..."),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
