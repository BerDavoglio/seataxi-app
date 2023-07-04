class NavigatorListModel {
  final int id;
  final String name_origin;
  final String name_destination;
  final List origin;
  final List destination;
  final int people_quantity;
  final double user_stars;

  const NavigatorListModel({
    required this.id,
    required this.name_origin,
    required this.name_destination,
    required this.origin,
    required this.destination,
    required this.people_quantity,
    required this.user_stars,
  });
}
