class LaporanKeuanganModel {
  final String id;
  final String kategori;
  final String tanggal;
  final String tipe_keuangan;
  final String nominal;
  final String deskripsi;
  final String user_id;

  LaporanKeuanganModel(
      {required this.id,
      required this.kategori,
      required this.tanggal,
      required this.tipe_keuangan,
      required this.nominal,
      required this.deskripsi,
      required this.user_id});

  factory LaporanKeuanganModel.fromJson(Map<String, dynamic> data) {
    return LaporanKeuanganModel(
        id: data['_id'],
        kategori: data['kategori'],
        tanggal: data['tanggal'],
        tipe_keuangan: data['tipe_keuangan'],
        nominal: data['nominal'],
        deskripsi: data['deskripsi'],
        user_id: data['user_id']);
  }
}
