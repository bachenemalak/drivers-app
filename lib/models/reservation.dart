enum ReservationServiceType { pointToPoint, transfer, asDirected }

class Reservation {
  final String id;
  final String clientId;
  final String clientName;
  final int passengers;
  final int luggage;
  final ReservationServiceType serviceType;
  final String pickupLocation;
  final String dropoffLocation;
  final String dateLabel;
  final String timeLabel;
  final String vehicleLabel;
  final String note;
  final String createdAgoLabel;
  final String? assignedDriverName;

  const Reservation({
    required this.id,
    required this.clientId,
    required this.clientName,
    required this.passengers,
    required this.luggage,
    required this.serviceType,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.dateLabel,
    required this.timeLabel,
    required this.vehicleLabel,
    required this.note,
    required this.createdAgoLabel,
    this.assignedDriverName,
  });

  String get serviceTypeLabel {
    switch (serviceType) {
      case ReservationServiceType.pointToPoint:
        return 'Point-to-Point';
      case ReservationServiceType.transfer:
        return 'Transfer';
      case ReservationServiceType.asDirected:
        return 'As Directed';
    }
  }
}
