import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skooleneducation/audio/audio_model.dart';
import 'package:skooleneducation/audio/audio_play.dart';
import 'package:skooleneducation/audio/audio_service.dart';

class AudioList extends StatefulWidget {
  const AudioList({super.key});

  @override
  State<AudioList> createState() => _AudioListState();
}

class _AudioListState extends State<AudioList> {
  late List<AudioModel> audioList;
  bool loading = true;

  getAllAudio() async {
    audioList = await AudioService().getAudio();
    setState(() {
      loading = false;
    });
    print("book list : ${audioList.length}");
  }

  @override
  void initState() {
    super.initState();
    getAllAudio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Daftar Audio"),
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: audioList.length,
              itemBuilder: (context, index) {
                AudioModel audio = audioList[index];
                return Card(
                  elevation: 4,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AudioPlay(
                            audioModel: audio,
                            index: index,
                          ),
                        ),
                      ).then((value) => getAllAudio());
                    },
                    // leading: CircleAvatar(child: Text(book.nm_barang[0])),
                    title: Text(
                      audio.nama_audio,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                    subtitle: Text(audio.nama_author),
                    leading: Image.network(
                      audio.gambar,
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
                            builder: (context) => AudioPlay(
                              audioModel: audio,
                              index: index,
                            ),
                          ),
                        ).then((value) => getAllAudio());
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
