// ignore_for_file: non_constant_identifier_names

class TripModel {
  final int id;
  final int user_id;
  final int navigator_id;
  final int origin_id;
  final int destination_id;
  final int boattype_id;
  final int people;
  final String method_payment;
  final bool private;
  final double value;
  final bool acceptance;
  final bool finished;

  const TripModel({
    required this.id,
    required this.user_id,
    required this.navigator_id,
    required this.origin_id,
    required this.destination_id,
    required this.boattype_id,
    required this.people,
    required this.method_payment,
    required this.private,
    required this.value,
    required this.acceptance,
    required this.finished,
  });
}
