enum TripStatus { upcoming, completed, cancelled }

class Trip {
  final String id;
  final String clientName;
  final int passengers;
  final int luggage;
  final String serviceTypeLabel;
  final String pickupLocation;
  final String dropoffLocation;
  final String dateLabel;
  final String timeLabel;
  final String vehicleLabel;
  final String note;
  final TripStatus status;

  const Trip({
    required this.id,
    required this.clientName,
    required this.passengers,
    required this.luggage,
    required this.serviceTypeLabel,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.dateLabel,
    required this.timeLabel,
    required this.vehicleLabel,
    required this.note,
    required this.status,
  });
}
