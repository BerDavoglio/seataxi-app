// ignore_for_file: non_constant_identifier_names

class AdminTypeModel {
  final int id;
  final String title;
  final String description;
  final String people;
  final DateTime created_at;
  final DateTime updated_at;

  const AdminTypeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.people,
    required this.created_at,
    required this.updated_at,
  });
}
