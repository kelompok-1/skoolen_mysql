import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skooleneducation/video/video_model.dart';

class VideoService {
  static const VIEW_URL =
      "http://courseapp.wstif3c.id/restapi_skoolen/get_video.php";

  List<VideoModel> bookFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<VideoModel>.from(data.map((item) => VideoModel.fromJson(item)));
  }

  Future<List<VideoModel>> getVideo() async {
    final response = await http.get(Uri.parse(VIEW_URL));
    if (response.statusCode == 200) {
      List<VideoModel> list = bookFromJson(response.body);
      return list;
    } else {
      return <VideoModel>[];
    }
  }
}
