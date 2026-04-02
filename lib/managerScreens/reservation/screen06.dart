import 'package:flutter/material.dart';
import 'package:car_app/managerScreens/reservation/materials.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:car_app/managerScreens/reservation/res_screens.dart';
import 'package:car_app/managerScreens/reservation/manage_res.dart';

class ScreenSix extends StatelessWidget {
  final formController = Get.put(ClientFormController());
  final tripController = Get.find<TripFormController>();
  final numberController = Get.find<NumberController>();
  

  ScreenSix({super.key});

  @override
  Widget build(BuildContext context) {
    final tripController = Get.find<TripFormController>();
    final numberController = Get.find<NumberController>();
    return SingleChildScrollView(

      child: Column(
        children: [
          ClientForm(
  fullName: formController.fullName.value,
  passengers: tripController.passengers.value,
  luggage: tripController.luggage.value,
  type: tripController.tripType.value,
  startingPoint: tripController.startingPoint.value,
  endPoint: tripController.endPoint.value,
  transferType: tripController.transferType.value, 
  date: tripController.date.value,
  time: tripController.time.value,
  vechicle: tripController.vehicleClass.value,
  note: tripController.specialInstructions.value,
),
          devider,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SwitchButton(ison: formController.assign),
              SizedBox(width: 5),
              Text('Create without assigning', style: AppTextStyles.lessBold),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(190, 45),
                  ),
                  onPressed: formController.assign.value ? () {} : null,
                  child: Text(
                    'Assign Driver',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
             Obx(
  () => TextButton(
    onPressed: formController.assign.value 
        ? null 
        : () async {
            final tripController = Get.find<TripFormController>();
            final clientController = Get.find<ClientFormController>();
            
            try {
              String clientId;
              
              // Get values
              final fullName = clientController.fullName.value.trim();
              final phoneNumber = clientController.phoneNumber.value.trim();
              final email = clientController.email.value.trim();
              
              // Step 1: Check if client already exists by phone number
              final existingClient = await FirebaseFirestore.instance
                  .collection('clients')
                  .where('phoneNumber', isEqualTo: phoneNumber)
                  .get();
              
              if (existingClient.docs.isNotEmpty) {
                // Client exists - use existing ID
                clientId = existingClient.docs.first.id;
                print('✅ Existing client found with ID: $clientId');
                
                Get.snackbar(
                  'Info',
                  'Existing client found. Adding trip to their account.',
                  backgroundColor: Colors.blue,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
              } else {
                // Client doesn't exist - create new
                final Map<String, dynamic> clientData = {
                  'fullName': fullName,
                  'phoneNumber': phoneNumber,
                  'email': email.isEmpty ? '' : email,
                  'createdAt': FieldValue.serverTimestamp(),
                  'tripIds': [],
                };
                
                final clientDoc = await FirebaseFirestore.instance
                    .collection('clients')
                    .add(clientData);
                
                clientId = clientDoc.id;
                print('✅ New client created with ID: $clientId');
              }
              
              // Step 2: Set client ID in trip controller
              tripController.clientId.value = clientId;
              
              // Step 3: Save trip and get trip ID
              final tripData = {
  'clientId': clientId,
  'tripType': tripController.tripType.value,
  'startingPoint': tripController.startingPoint.value,
  'endPoint': tripController.endPoint.value,
  'passengers': tripController.passengers.value,
  'luggage': tripController.luggage.value,
  'date': tripController.date.value,
  'time': tripController.time.value,
  'vehicleClass': tripController.vehicleClass.value,
  'capacity': tripController.capacity.value,
  'childSeat': tripController.childSeat.value,
  'wheelchair': tripController.wheelchair.value,
  'specialInstructions': tripController.specialInstructions.value,
  'createdAt': FieldValue.serverTimestamp(),
  // Add Airport Transfer fields
  'transferType': tripController.transferType.value,
  'terminal': Get.find<TextEditingController>(tag: 'terminal').text,
  'flightNumber': Get.find<TextEditingController>(tag: 'flight').text,
  'direction': Get.find<TextEditingController>(tag: 'direction').text,
  // Add As Directed fields
  'duration': Get.find<TextEditingController>(tag: 'duration').text,
  'specialNote': Get.find<TextEditingController>(tag: 'as_note').text,
};
              
              final tripDoc = await FirebaseFirestore.instance
                  .collection('trips')
                  .add(tripData);
              
              final tripId = tripDoc.id;
              print('✅ Trip saved with ID: $tripId');
              
              // Step 4: Add trip ID to client's tripIds array
              await FirebaseFirestore.instance
                  .collection('clients')
                  .doc(clientId)
                  .update({
                'tripIds': FieldValue.arrayUnion([tripId]),
                'lastTripId': tripId,
                'updatedAt': FieldValue.serverTimestamp(),
              });
              
              Get.snackbar(
                'Success',
                'Trip created successfully!',
                backgroundColor: Colors.green,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
              Get.find<TripFormController>().clear();
              Get.find<ClientFormController>().clear();
              Get.find<NumberController>().clear();
              Get.offAllNamed('/manageReservation');
            } catch (e) {
              print('❌ Error: $e');
              Get.snackbar(
                'Error',
                'Failed to create: $e',
                backgroundColor: Colors.red,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          },
    child: Text(
      'create',
      style: GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: formController.assign.value
            ? Color.fromRGBO(14, 14, 14, 0.35)
            : Colors.black,
      ),
    ),
  ),
),
            ],
          ),
        ],
      ),
    );
  }
}

class ClientForm extends StatelessWidget {
  final String fullName;
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
  
  const ClientForm({
    super.key,
    required this.fullName,
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
  });

  @override
  Widget build(BuildContext context) {
    final displayNote = note.trim().isEmpty ? 'No special instructions' : note;
    
    return Container(
      height: MediaQuery.of(context).size.height * 0.51,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color.fromRGBO(218, 218, 218, 1)),
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 4),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fullName,
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Image.asset('images/famicons_people-sharp.png'),
                SizedBox(width: 3),
                Text(
                  'Passengers : $passengers',
                  style: AppTextStyles.formstyle1,
                ),
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
            
            // Location section based on trip type
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
        Text('Type: $transferType', style: AppTextStyles.lessBold), // Use the parameter
        SizedBox(height: 8),
        Text('Airport: $startingPoint', style: AppTextStyles.lessBold),
        SizedBox(height: 8),
        Text('Terminal: ${Get.find<TextEditingController>(tag: 'terminal').text}', style: AppTextStyles.lessBold),
        SizedBox(height: 8),
        Text('Flight: ${Get.find<TextEditingController>(tag: 'flight').text}', style: AppTextStyles.lessBold),
        SizedBox(height: 8),
        Text('Direction: ${Get.find<TextEditingController>(tag: 'direction').text}', style: AppTextStyles.lessBold),
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
                    Text('Duration: ${Get.find<TextEditingController>(tag: 'duration').text}', style: AppTextStyles.lessBold),
                    SizedBox(height: 8),
                    Text('Special Note: ${Get.find<TextEditingController>(tag: 'as_note').text}', style: AppTextStyles.lessBold),
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
      ),
    );
  }
}

class ClientFormController extends GetxController {
  RxString fullName = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString email = ''.obs;
  RxString passengers = ''.obs;
  RxString luggage = ''.obs;
  RxString type = ''.obs;
  RxString date = ''.obs;
  RxString time = ''.obs;
  RxString vechicle = ''.obs;
  RxString places = ''.obs;
  RxString extraNotes = ''.obs;
  RxBool assign = false.obs;
  void clear() {
  fullName.value = '';
  phoneNumber.value = '';
  email.value = '';
  passengers.value = '';
  luggage.value = '';
  type.value = '';
  date.value = '';
  time.value = '';
  vechicle.value = '';
  places.value = '';
  extraNotes.value = '';
  assign.value = false;
}
}

class TripFormController extends GetxController {
  
  RxString clientId = ''.obs;

  // Trip type
  RxString tripType = ''.obs; // "Airport", "Point-to-Point", "Hourly" etc.

  // Common fields (used in multiple trip types)
  RxString startingPoint = ''.obs;
  RxString endPoint = ''.obs;
  RxString passengers = ''.obs;
  RxString luggage = ''.obs;
  RxString date = ''.obs;
  RxString time = ''.obs;

  // Vehicle info
  RxString vehicleClass = ''.obs;
  RxInt capacity = 0.obs;
  RxBool childSeat = false.obs;
  RxBool wheelchair = false.obs;

  // Special / optional info
  RxString specialInstructions = ''.obs;
  RxList<String> attachments = <String>[].obs;
  RxString assignedDriverId = ''.obs;

  // Airport-specific fields
  RxString flightNumber = ''.obs;
  RxString airline = ''.obs;
  RxString airportName = ''.obs;
  RxString transferType = ''.obs; // 'Pick Up' or 'Drop At'

  // Hourly-trip-specific fields
  RxInt hoursCount = 0.obs;
void clear() {
  clientId.value = '';
  tripType.value = '';
  startingPoint.value = '';
  endPoint.value = '';
  passengers.value = '';
  luggage.value = '';
  date.value = '';
  time.value = '';
  vehicleClass.value = '';
  capacity.value = 0;
  childSeat.value = false;
  wheelchair.value = false;
  specialInstructions.value = '';
  transferType.value = '';
  flightNumber.value = '';  // Add this
  airline.value = '';       // Add this
  airportName.value = '';   // Add this
  hoursCount.value = 0;     // Add this
  attachments.value = [];   // Add this
  assignedDriverId.value = ''; // Add this
}
  // Save trip function
  Future<void> saveTrip() async {
  Map<String, dynamic> data = {
    'clientId': clientId.value,
    'tripType': tripType.value,
    'startingPoint': startingPoint.value,
    'endPoint': endPoint.value,
    'passengers': passengers.value,
    'luggage': luggage.value,
    'date': date.value,
    'time': time.value,
    'vehicleClass': vehicleClass.value,
    'capacity': capacity.value,
    'childSeat': childSeat.value,
    'wheelchair': wheelchair.value,
    'specialInstructions': specialInstructions.value,
    'attachments': attachments,
    'assignedDriverId': assignedDriverId.value,
    'createdAt': FieldValue.serverTimestamp(),
  };

  // Add Airport Transfer specific fields
  if (tripType.value == 'Airport Transfer') {
    data['transferType'] = transferType.value;
    data['airportName'] = startingPoint.value;
    data['terminal'] = Get.find<TextEditingController>(tag: 'terminal').text;
    data['flightNumber'] = Get.find<TextEditingController>(tag: 'flight').text;
    data['direction'] = Get.find<TextEditingController>(tag: 'direction').text;
  }
  
  // Add As Directed specific fields
  if (tripType.value == 'As Directed') {
    data['duration'] = Get.find<TextEditingController>(tag: 'duration').text;
    data['specialNote'] = Get.find<TextEditingController>(tag: 'as_note').text;
  }

  final docRef = await FirebaseFirestore.instance.collection('trips').add(data);
  final tripId = docRef.id;
  
  if (clientId.value.isNotEmpty && !clientId.value.startsWith('temp_')) {
    await FirebaseFirestore.instance
        .collection('clients')
        .doc(clientId.value)
        .update({
      'tripIds': FieldValue.arrayUnion([tripId]),
      'lastTripId': tripId,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
}