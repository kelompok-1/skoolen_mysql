class BookModel {
  String nama_buku;
  String nama_penulis;
  String deskripsi_buku;
  String jumlah_halaman;
  String gambar;
  String link_pdf;

  BookModel({
    required this.nama_buku,
    required this.nama_penulis,
    required this.deskripsi_buku,
    required this.jumlah_halaman,
    required this.gambar,
    required this.link_pdf,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      nama_buku: json['nama_buku'] as String,
      nama_penulis: json['nama_penulis'] as String,
      deskripsi_buku: json['deskripsi_buku'] as String,
      jumlah_halaman: json['jumlah_halaman'] as String,
      gambar: json['gambar'] as String,
      link_pdf: json['link_pdf'] as String,
    );
  }

  // Map<String, dynamic> toJsonAdd() {
  //   return {
  //     "nama_buku": nama_buku,
  //     "nama_penulis": nama_penulis,
  //     "deskripsi_buku": deskripsi_buku,
  //     "jumlah_halaman": jumlah_halaman,
  //     "gambar": gambar,
  //     "link_pdf": link_pdf,
  //   };
  // }

  // Map<String, dynamic> toJsonUpdate() {
  //   return {
  //     "nama_buku": nama_buku,
  //     "nama_penulis": nama_penulis,
  //     "deskripsi_buku": deskripsi_buku,
  //     "jumlah_halaman": jumlah_halaman,
  //     "gambar": gambar,
  //     "link_pdf": link_pdf,
  //   };
  // }
}
