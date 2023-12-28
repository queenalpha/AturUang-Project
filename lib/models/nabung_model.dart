class NabungModel {
  final String id;
  final String foto;
  final String nama;
  final String target;
  final String periode;
  final String nominal;
  final String user_id;
  final String tanggal;

  NabungModel(
      {required this.id,
      required this.foto,
      required this.nama,
      required this.target,
      required this.periode,
      required this.nominal,
      required this.user_id,
      required this.tanggal});

  factory NabungModel.fromJson(Map<String, dynamic> data) {
    return NabungModel(
        id: data['_id'],
        foto: data['foto'],
        nama: data['nama'],
        target: data['target'],
        periode: data['periode'],
        nominal: data['nominal'],
        user_id: data['user_id'],
        tanggal: data['tanggal']);
  }
}
