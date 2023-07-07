// ignore_for_file: non_constant_identifier_names

class AdminMaritmeModel {
  final int id;
  final String title;
  final double lat;
  final double long;
  final DateTime created_at;
  final DateTime updated_at;

  const AdminMaritmeModel({
    required this.id,
    required this.title,
    required this.lat,
    required this.long,
    required this.created_at,
    required this.updated_at,
  });
}
