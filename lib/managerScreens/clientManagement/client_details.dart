import 'package:car_app/managerScreens/reservation/materials.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../navBars/supervisorNavbar.dart';

class ClientDetails extends StatefulWidget {
  final String clientId;
  const ClientDetails({super.key, required this.clientId});

  @override
  State<ClientDetails> createState() => _ClientDetailsState();
}

class _ClientDetailsState extends State<ClientDetails> {
  String clientName = '';
  String clientPhone = '';
  String clientEmail = '';
  List<Map<String, dynamic>> trips = [];

  @override
  void initState() {
    super.initState();
    if (widget.clientId.isNotEmpty) {
      fetchClientData();
    }
  }

  Future<void> fetchClientData() async {
  try {
    final clientDoc = await FirebaseFirestore.instance
        .collection('clients')
        .doc(widget.clientId)
        .get();
    
    final clientData = clientDoc.data() as Map<String, dynamic>;
    
    final tripsSnapshot = await FirebaseFirestore.instance
        .collection('trips')
        .where('clientId', isEqualTo: widget.clientId)
        .get();
    
    setState(() {
      clientName = clientData['fullName'] ?? 'Unknown Client';
      clientPhone = clientData['phoneNumber'] ?? 'No phone number';
      clientEmail = clientData['email'] ?? 'No email';
      trips = tripsSnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          // Common fields
          'passengers': data['passengers']?.toString() ?? '0',
          'luggage': data['luggage']?.toString() ?? '0',
          'type': data['tripType'] ?? 'Unknown',
          'startingPoint': data['startingPoint'] ?? '',
          'endPoint': data['endPoint'] ?? '',
          'date': data['date'] ?? '',
          'time': data['time'] ?? '',
          'vehicle': data['vehicleClass'] ?? 'Unknown',
          'note': data['specialInstructions'] ?? 'No special instructions',
          'capacity': data['capacity']?.toString() ?? '0',
          'childSeat': data['childSeat'] ?? false,
          'wheelchair': data['wheelchair'] ?? false,
          
          // Airport Transfer fields
          'transferType': data['transferType'] ?? '',
          'terminal': data['terminal'] ?? '',
          'flightNumber': data['flightNumber'] ?? '',
          'direction': data['direction'] ?? '',
          'airportName': data['airportName'] ?? '',
          
          // As Directed fields
          'duration': data['duration'] ?? '',
          'specialNote': data['specialNote'] ?? '',
        };
      }).toList();
    });
  } catch (e) {
    print('Error fetching client data: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 3;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: supervisorNavbar(
          selectedIndex: selectedIndex,
          onItemTapped: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  label: Text(clientName, style: AppTextStyles.h1),
                  onPressed: () {
                    Navigator.pushNamed(context, '/clientsManagment');
                  },
                  icon: Icon(
                    color: Colors.black,
                    size: 25,
                    Icons.arrow_back_ios,
                  ),
                ),
                SizedBox(height: 5),
                // Phone number
                /*Row( mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(clientPhone, style: AppTextStyles.subtitle),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                // Email
                Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  
                    Text(clientEmail, style: AppTextStyles.subtitle),
                  ],
                ),*/  // to filllater im a no designer didnt know how to do it 
                SizedBox(height: 20),
                trips.isEmpty
                    ? Center(child: Text('No trips found for this client'))
                    : Column(
                        children:trips.map((trip) {
  return ClientDetailsContainer(
    passengers: trip['passengers'],
    luggage: trip['luggage'],
    type: trip['type'],
    startingPoint: trip['startingPoint'],
    endPoint: trip['endPoint'],
    date: trip['date'],
    time: trip['time'],
    vechicle: trip['vehicle'],
    note: trip['note'],
    transferType: trip['transferType'],
    terminal: trip['terminal'],
    flightNumber: trip['flightNumber'],
    direction: trip['direction'],
    duration: trip['duration'],
    specialNote: trip['specialNote'],
  );
}).toList(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ClientDetailsContainer extends StatelessWidget {
  final String passengers;
  final String luggage;
  final String type;
  final String startingPoint;
  final String endPoint;
  final String date;
  final String time;
  final String vechicle;
  final String note;
  final String? transferType;
  final String? terminal;
  final String? flightNumber;
  final String? direction;
  final String? duration;
  final String? specialNote;

  const ClientDetailsContainer({
    super.key,
    required this.passengers,
    required this.luggage,
    required this.type,
    required this.startingPoint,
    required this.endPoint,
    required this.date,
    required this.time,
    required this.vechicle,
    required this.note,
    this.transferType,
    this.terminal,
    this.flightNumber,
    this.direction,
    this.duration,
    this.specialNote,
  });

  @override
  Widget build(BuildContext context) {
    final displayNote = note.trim().isEmpty ? 'No special instructions' : note;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color.fromRGBO(218, 218, 218, 1)),
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 4),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trip Details',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Image.asset('images/famicons_people-sharp.png'),
              SizedBox(width: 3),
              Text('Passengers : $passengers', style: AppTextStyles.formstyle1),
              Spacer(),
              Image.asset('images/bi_luggage-fill.png'),
              SizedBox(width: 3),
              Text('Luggage : $luggage', style: AppTextStyles.formstyle1),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Image.asset('images/mdi_location (1).png'),
              SizedBox(width: 3),
              Text(
                type,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          
          // Location section based on trip type (same as ClientForm)
          if (type == 'Point-to-Point')
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 3.5,
                      backgroundColor: Color.fromRGBO(65, 66, 67, 1),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: 1,
                      height: 24,
                      color: Color.fromRGBO(65, 66, 67, 1),
                    ),
                    CircleAvatar(
                      radius: 3.5,
                      backgroundColor: Color.fromRGBO(65, 66, 67, 1),
                    ),
                    SizedBox(height: 12),
                  ],
                ),
                SizedBox(width: 9),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(startingPoint, style: AppTextStyles.lessBold),
                    SizedBox(height: 13),
                    Text(endPoint, style: AppTextStyles.lessBold),
                    SizedBox(height: 12),
                  ],
                ),
              ],
            ),
          
          if (type == 'Airport Transfer')
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Type: $transferType', style: AppTextStyles.lessBold),
                  SizedBox(height: 8),
                  Text('Airport: $startingPoint', style: AppTextStyles.lessBold),
                  SizedBox(height: 8),
                  Text('Terminal: $terminal', style: AppTextStyles.lessBold),
                  SizedBox(height: 8),
                  Text('Flight: $flightNumber', style: AppTextStyles.lessBold),
                  SizedBox(height: 8),
                  Text('Direction: $direction', style: AppTextStyles.lessBold),
                ],
              ),
            ),
          
          if (type == 'As Directed')
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pickup: $startingPoint', style: AppTextStyles.lessBold),
                  SizedBox(height: 8),
                  Text('Duration: $duration', style: AppTextStyles.lessBold),
                  SizedBox(height: 8),
                  Text('Special Note: $specialNote', style: AppTextStyles.lessBold),
                ],
              ),
            ),
          
          SizedBox(height: 9),
          Row(
            children: [
              Image.asset('images/carbon_time.png'),
              SizedBox(width: 3),
              Text('$date at $time', style: AppTextStyles.subtitle),
            ],
          ),
          SizedBox(height: 9),
          Row(
            children: [
              Image.asset('images/Vector.png'),
              SizedBox(width: 3),
              Text(vechicle, style: AppTextStyles.subtitle),
            ],
          ),
          SizedBox(height: 9),
          Row(
            children: [
              Image.asset('images/material-symbols_person.png'),
              SizedBox(width: 3),
              Text('Driver : Not assigned', style: AppTextStyles.subtitle),
            ],
          ),
          SizedBox(height: 9),
          Row(
            children: [
              Image.asset('images/hugeicons_note-03.png'),
              SizedBox(width: 3),
              Text(
                'Note: ',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Text(displayNote, style: AppTextStyles.lessBold),
        ],
      ),
    );
  }
}