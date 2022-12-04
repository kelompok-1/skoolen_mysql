class UserModel {
  String nm_barang;
  String stok;

  UserModel({
    required this.nm_barang,
    required this.stok,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      nm_barang: json['nm_barang'] as String,
      stok: json['stok'] as String,
    );
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      "nama_barang": nm_barang,
      "stok": stok,
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      "nama_barang": nm_barang,
      "stok": stok,
    };
  }
}
