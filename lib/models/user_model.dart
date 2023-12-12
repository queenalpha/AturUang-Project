class UserModel {
  final String id;
  final String user_id;
  final String foto;

  UserModel({required this.id, required this.user_id, required this.foto});

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
        id: data['_id'], user_id: data['user_id'], foto: data['foto']);
  }
}
