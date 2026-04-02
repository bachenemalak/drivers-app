import 'package:car_app/models/app_user.dart';
import 'package:car_app/models/client.dart';
import 'package:car_app/models/driver.dart';
import 'package:car_app/models/reservation.dart';
import 'package:car_app/models/trip.dart';

class MockDataRepository {
  const MockDataRepository._();

  static const List<AppUser> users = [
    AppUser(
      id: 'manager-1',
      fullName: 'Operations Manager',
      email: 'manager@luxuryconcierge.com',
      role: UserRole.manager,
    ),
    AppUser(
      id: 'driver-1',
      fullName: 'Chourouk Ba',
      email: 'driver@luxuryconcierge.com',
      role: UserRole.driver,
    ),
  ];

  static const List<Client> clients = [
    Client(
      id: 'c1',
      fullName: 'Joe Biden Obama',
      phoneNumber: '+213 6 00 00 001',
      email: 'joe@example.com',
      savedToDirectory: true,
    ),
    Client(
      id: 'c2',
      fullName: 'Sarah Connor',
      phoneNumber: '+213 6 00 00 002',
      email: 'sarah@example.com',
      savedToDirectory: true,
    ),
    Client(
      id: 'c3',
      fullName: 'Mia Wallace',
      phoneNumber: '+213 6 00 00 003',
      email: 'mia@example.com',
      savedToDirectory: false,
    ),
    Client(
      id: 'c4',
      fullName: 'Omar Benali',
      phoneNumber: '+213 6 00 00 004',
      email: 'omar@example.com',
      savedToDirectory: true,
    ),
  ];

  static const List<Driver> drivers = [
    Driver(
      id: 'd1',
      name: 'Chourouk Ba',
      status: DriverStatus.onTrip,
      clientInfo: 'Client: Joe Biden Obama • Airport drop-off',
      phone: '+213 6 00 00 000',
      vehicle: 'SUV',
    ),
    Driver(
      id: 'd2',
      name: 'Djihane Lao',
      status: DriverStatus.available,
      clientInfo: 'Ready for assignment',
      phone: '+213 6 11 11 111',
      vehicle: 'SUV',
    ),
    Driver(
      id: 'd3',
      name: 'Racha Chouali',
      status: DriverStatus.offline,
      clientInfo: 'Offline - last seen 2h ago',
      phone: '+213 6 22 22 222',
      vehicle: 'Sedan',
    ),
    Driver(
      id: 'd4',
      name: 'Malak Bachene',
      status: DriverStatus.scheduled,
      clientInfo: 'Pickup at 14:00 - University Campus',
      phone: '+213 6 33 33 333',
      vehicle: 'Multi-Pax',
    ),
  ];

  static const List<Reservation> reservations = [
    Reservation(
      id: 'r1',
      clientId: 'c1',
      clientName: 'Joe Biden Obama',
      passengers: 2,
      luggage: 4,
      serviceType: ReservationServiceType.pointToPoint,
      pickupLocation: 'Rue Lkoucha bab dar N34',
      dropoffLocation: 'Anasseur Street BV 2314',
      dateLabel: '02/02/2025',
      timeLabel: '5:41 AM',
      vehicleLabel: 'Sedan G class of 4 places',
      note: 'Drive slowly',
      createdAgoLabel: '2 min ago',
      assignedDriverName: 'Chourouk Ba',
    ),
    Reservation(
      id: 'r2',
      clientId: 'c2',
      clientName: 'Sarah Connor',
      passengers: 1,
      luggage: 2,
      serviceType: ReservationServiceType.transfer,
      pickupLocation: 'Houari Boumediene Airport',
      dropoffLocation: 'Hydra Business District',
      dateLabel: '06/20/2025',
      timeLabel: '8:15 PM',
      vehicleLabel: 'SUV Escalade of 6 places',
      note: 'Meet at arrivals gate B',
      createdAgoLabel: '10 min ago',
      assignedDriverName: null,
    ),
    Reservation(
      id: 'r3',
      clientId: 'c1',
      clientName: 'Joe Biden Obama',
      passengers: 3,
      luggage: 2,
      serviceType: ReservationServiceType.asDirected,
      pickupLocation: 'Hotel El Aurassi',
      dropoffLocation: 'Multiple stops in Algiers',
      dateLabel: '06/22/2025',
      timeLabel: '11:30 AM',
      vehicleLabel: 'V-Class of 6 places',
      note: 'VIP itinerary for 4 hours',
      createdAgoLabel: '1 hour ago',
      assignedDriverName: 'Malak Bachene',
    ),
  ];

  static const List<Trip> trips = [
    Trip(
      id: 't1',
      clientName: 'Joe Biden Obama',
      passengers: 2,
      luggage: 4,
      serviceTypeLabel: 'Point-to-Point',
      pickupLocation: 'Rue Lkoucha bab dar N34',
      dropoffLocation: 'Anasseur Street BV 2314',
      dateLabel: '17 June, 2025',
      timeLabel: '5:41 AM',
      vehicleLabel: 'Sedan G class of 4 places',
      note: 'Drive slowly',
      status: TripStatus.upcoming,
    ),
    Trip(
      id: 't2',
      clientName: 'Sarah Connor',
      passengers: 1,
      luggage: 2,
      serviceTypeLabel: 'Airport Transfer',
      pickupLocation: 'Houari Boumediene Airport',
      dropoffLocation: 'Hydra Business District',
      dateLabel: '14 June, 2025',
      timeLabel: '8:15 PM',
      vehicleLabel: 'SUV Escalade of 6 places',
      note: 'Client prefers quiet ride',
      status: TripStatus.completed,
    ),
  ];

  static List<Reservation> reservationsForClient(String clientId) {
    return reservations.where((reservation) => reservation.clientId == clientId).toList();
  }

  static List<Trip> tripsByStatus(TripStatus status) {
    return trips.where((trip) => trip.status == status).toList();
  }

  static Trip? get currentDriverTrip {
    for (final trip in trips) {
      if (trip.status == TripStatus.upcoming) {
        return trip;
      }
    }
    return null;
  }
}
