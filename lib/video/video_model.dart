class VideoModel {
  String urutan;
  String nama_video;
  String durasi;
  String link_video;
  String nama_sub_kategori_video;

  VideoModel({
    required this.urutan,
    required this.nama_video,
    required this.durasi,
    required this.link_video,
    required this.nama_sub_kategori_video,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      urutan: json['urutan'] as String,
      nama_video: json['nama_video'] as String,
      durasi: json['durasi'] as String,
      link_video: json['link_video'] as String,
      nama_sub_kategori_video: json['nama_sub_kategori_video'] as String,
    );
  }
}
