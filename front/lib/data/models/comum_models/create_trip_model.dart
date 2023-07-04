// ignore_for_file: non_constant_identifier_names

class CreateTripModel {
  final int id;
  final int origin_id;
  final int destination_id;
  final int boattype_id;
  final int people;
  final String method_payment;
  final bool private;

  const CreateTripModel({
    required this.id,
    required this.origin_id,
    required this.destination_id,
    required this.boattype_id,
    required this.people,
    required this.method_payment,
    required this.private,
  });
}
