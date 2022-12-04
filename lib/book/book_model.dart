class BookModel {
  String nm_barang;
  String stok;
  String gambar;
  String pdf_link;

  BookModel({
    required this.nm_barang,
    required this.stok,
    required this.gambar,
    required this.pdf_link,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      nm_barang: json['nm_barang'] as String,
      stok: json['stok'] as String,
      gambar: json['gambar'] as String,
      pdf_link: json['pdf_link'] as String,
    );
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      "nama_barang": nm_barang,
      "stok": stok,
      "gambar": gambar,
      "pdf_link": pdf_link,
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      "nama_barang": nm_barang,
      "stok": stok,
      "gambar": gambar,
      "pdf_link": pdf_link,
    };
  }
}
