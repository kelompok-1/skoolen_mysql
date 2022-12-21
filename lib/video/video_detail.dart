import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skooleneducation/video/video_model.dart';
import 'package:video_player/video_player.dart';

class VideoDetail extends StatefulWidget {
  final VideoModel videoModel;
  final int index;
  const VideoDetail({required this.videoModel, required this.index});

  @override
  State<VideoDetail> createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  late VideoPlayerController controller;
  ChewieController? chewieController;

  Future<void> loadVideoPlayer() async {
    controller = VideoPlayerController.network(widget.videoModel.link_video);
    await Future.wait(
      [
        controller.initialize(),
      ],
    );

    chewieController = ChewieController(
        videoPlayerController: controller,
        autoPlay: false,
        looping: false,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.blue,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.lightGreen,
        ),
        placeholder: Container(
          color: Colors.black,
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              "Ups... ada yang salah",
              style: TextStyle(color: Colors.red),
            ),
          );
        },
        // aspectRatio: controller.value.size.aspectRatio,
        deviceOrientationsOnEnterFullScreen: [DeviceOrientation.landscapeRight],
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp]);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    chewieController!.dispose();
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

  TextEditingController urutan = TextEditingController();
  TextEditingController nama_video = TextEditingController();
  TextEditingController durasi = TextEditingController();
  TextEditingController link_video = TextEditingController();
  TextEditingController nama_sub_kategori_video = TextEditingController();
  bool editMode = false;

  @override
  void initState() {
    super.initState();
    loadVideoPlayer();
    if (widget.index != null) {
      urutan.text = widget.videoModel.urutan;
      nama_video.text = widget.videoModel.nama_video;
      durasi.text = widget.videoModel.durasi;
      link_video.text = widget.videoModel.link_video;
      nama_sub_kategori_video.text = widget.videoModel.nama_sub_kategori_video;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Video"),
        backgroundColor: Colors.deepPurple,
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
                        CircularProgressIndicator(
                          color: Colors.amber,
                        ),
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
