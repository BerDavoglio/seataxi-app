class HistoryModel {
  final int id;
  final DateTime date;
  final List origin;
  final List destination;
  final double value;

  const HistoryModel({
    required this.id,
    required this.date,
    required this.origin,
    required this.destination,
    required this.value,
  });
}
