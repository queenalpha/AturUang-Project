class NabungModel {
  final String id;
  final String foto;
  final String nama;
  final String target;
  final String periode;
  final String nominal;

  NabungModel(
      {required this.id,
      required this.foto,
      required this.nama,
      required this.target,
      required this.periode,
      required this.nominal});

  factory NabungModel.fromJson(Map<String, dynamic> data) {
    return NabungModel(
        id: data['_id'],
        foto: data['foto'],
        nama: data['nama'],
        target: data['target'],
        periode: data['periode'],
        nominal: data['nominal']);
  }
}
