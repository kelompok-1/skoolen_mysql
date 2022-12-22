import 'package:flutter/material.dart';
import 'package:skooleneducation/video/video_detail.dart';
import 'package:skooleneducation/video/video_model.dart';
import 'package:skooleneducation/video/video_service.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late List<VideoModel> videoList;
  bool loading = true;

  getAllVideo() async {
    videoList = await VideoService().getVideo();
    setState(() {
      loading = false;
    });
    print("book list : ${videoList.length}");
  }

  @override
  void initState() {
    super.initState();
    getAllVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Daftar Video"),
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: videoList.length,
              itemBuilder: (context, index) {
                VideoModel video = videoList[index];
                return Card(
                  elevation: 4,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoDetail(
                            videoModel: video,
                            index: index,
                          ),
                        ),
                      ).then((value) => getAllVideo());
                    },
                    // leading: CircleAvatar(child: Text(book.nm_barang[0])),
                    title: Text(
                      video.urutan + ". " + video.nama_video,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                    subtitle: Text(video.durasi),
                    leading: Image.network(
                      video.thumbnail,
                      width: 50,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoDetail(
                              videoModel: video,
                              index: index,
                            ),
                          ),
                        ).then((value) => getAllVideo());
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
