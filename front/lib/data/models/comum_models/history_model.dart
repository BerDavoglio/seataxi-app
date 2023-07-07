class HistoryModel {
  final int id;
  final DateTime date;
  final List origin;
  final List destination;
  final double value;
  final DateTime created_at;
  final DateTime updated_at;

  const HistoryModel({
    required this.id,
    required this.date,
    required this.origin,
    required this.destination,
    required this.value,
    required this.created_at,
    required this.updated_at,
  });
}
