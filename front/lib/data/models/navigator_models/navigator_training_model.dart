// ignore_for_file: non_constant_identifier_names

class NavigatorTrainingModel {
  final int id;
  final String link;
  final String title;
  final String description;
  final DateTime? created_at;
  final DateTime? updated_at;

  const NavigatorTrainingModel({
    required this.id,
    required this.link,
    required this.title,
    required this.description,
    this.created_at,
    this.updated_at,
  });
}
