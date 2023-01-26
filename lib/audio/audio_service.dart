import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skooleneducation/audio/audio_model.dart';

class AudioService {
  static const VIEW_URL =
      "http://courseapp.wstif3c.id/restapi_skoolen/get_audio.php";

  List<AudioModel> bookFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<AudioModel>.from(data.map((item) => AudioModel.fromJson(item)));
  }

  Future<List<AudioModel>> getAudio() async {
    final response = await http.get(Uri.parse(VIEW_URL));
    if (response.statusCode == 200) {
      List<AudioModel> list = bookFromJson(response.body);
      return list;
    } else {
      return <AudioModel>[];
    }
  }
}
