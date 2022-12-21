class AudioModel {
  String nama_audio;
  String nama_author;
  String gambar;
  String link_audio;

  AudioModel({
    required this.nama_audio,
    required this.nama_author,
    required this.gambar,
    required this.link_audio,
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      nama_audio: json['nama_audio'] as String,
      nama_author: json['nama_author'] as String,
      gambar: json['gambar'] as String,
      link_audio: json['link_audio'] as String,
    );
  }
}
