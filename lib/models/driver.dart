enum DriverStatus { available, scheduled, onTrip, offline }

class Driver {
  final String id;
  final String name;
  final DriverStatus status;
  final String clientInfo;
  final String phone;
  final String vehicle;
  final String? image;

  const Driver({
    required this.id,
    required this.name,
    required this.status,
    required this.clientInfo,
    required this.phone,
    required this.vehicle,
    this.image,
  });
}
