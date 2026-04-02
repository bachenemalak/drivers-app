import 'package:car_app/managerScreens/reservation/screen06.dart';
import 'package:flutter/material.dart';
import 'package:car_app/managerScreens/reservation/materials.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScreenOne extends StatelessWidget {
  final  formController = Get.put(ClientFormController());
  final NumberController controller = Get.put(NumberController());
  final TripFormController tripController = Get.put(TripFormController());
  

   final RxString nameError = ''.obs;
  final RxString phoneError = ''.obs;
  final RxString emailError = ''.obs;
  ScreenOne({super.key});
  
 final FirebaseFirestore firestore = FirebaseFirestore.instance;
 
 
Future<String?> saveClient() async {
  print('💾 Saving client...');
  
  try {
    final Map<String, dynamic> clientData = {
      'fullName': formController.fullName.value.trim(),
      'phoneNumber': formController.phoneNumber.value.trim(),
      'email': formController.email.value.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    };
    
    final docRef = await firestore.collection('clients').add(clientData);
    
    print('✅ Client saved with ID: ${docRef.id}');
    
    Get.snackbar(
      'Success',
      'Client saved successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    
    return docRef.id; // Return the ID
    
  } catch (e) {
    print('❌ Error: $e');
    Get.snackbar(
      'Error',
      'Failed to save: ${e.toString()}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return null;
  }
}
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      
      InfoInput(
  title: 'Full Name',
  hintxt: 'Enter Full Name',
  tag: 'full_name',
  errorText: nameError, // Pass error observable
  onChanged: (value) {
    formController.fullName.value = value;
  },
),
InfoInput(
  title: 'Phone number',
  hintxt: 'Enter Phone Number',
  tag: 'phone',
  errorText: phoneError,
  onChanged: (value) => formController.phoneNumber.value = value,
),
InfoInput(
  title: 'Email',
  hintxt: 'Enter Email',
  tag: 'email',
  errorText: emailError,
  onChanged: (value) => formController.email.value = value,
),
        SizedBox(height: 10),
        Obx(
          () => NumberContainer(
            title: 'Number of Passengers',
            onTapDown: controller.subPassenger,
            onTapup: controller.addPassenger,
            number: controller.passengers.value.toString(),
          ),
        ),
        SizedBox(height: 20),
        Obx(
          () => NumberContainer(
            title: 'Number of Luggage',
            onTapDown: controller.subLuggage,
            onTapup: controller.addLuggage,
            number: controller.luggage.value.toString(),
          ),
        ),
        SizedBox(height: 30),
        Row(
          children: [
            Text('Save client to directory', style: AppTextStyles.subtitle),
            Spacer(),
            SwitchButton(ison: controller.isOn),
          ],
        ),

        devider,
       Align(
  alignment: Alignment.bottomRight,
  child: NextBtn(
  validate: () {
    // Clear previous errors
    nameError.value = '';
    phoneError.value = '';
    emailError.value = '';
    
    final name = Get.find<TextEditingController>(tag: 'full_name').text;
    final phone = Get.find<TextEditingController>(tag: 'phone').text;
    final email = Get.find<TextEditingController>(tag: 'email').text;
    
    bool isValid = true;
    
    if (name.trim().isEmpty) {
      nameError.value = 'Full name is required';
      print('nameError set to: ${nameError.value}');
      isValid = false;
    }
    
    if (phone.trim().isEmpty) {
      phoneError.value = 'Phone number is required';
      isValid = false;
    }
    
    if (email.trim().isNotEmpty) {
    if (!GetUtils.isEmail(email)) {
      emailError.value = 'Enter a valid email address';
      isValid = false;
    }
  }
    
    return isValid;
  },
  onPressedCallback: () {
    // Save data to controllers (only runs if validation passes)
    final clientController = Get.find<ClientFormController>();
    final tripController = Get.find<TripFormController>();
    
    clientController.fullName.value = Get.find<TextEditingController>(tag: 'full_name').text;
    clientController.phoneNumber.value = Get.find<TextEditingController>(tag: 'phone').text;
    clientController.email.value = Get.find<TextEditingController>(tag: 'email').text;
    tripController.passengers.value = controller.passengers.value.toString();
    tripController.luggage.value = controller.luggage.value.toString();
  },
)
),
      ],
    );
  }
}

class InfoInput extends StatelessWidget {
  final String title;
  final String hintxt;
  final Function(String) onChanged;
  final String tag;
  final RxString errorText;
  
  // Create controller outside build
  late final TextEditingController controller;

  InfoInput({
    super.key,
    required this.title,
    required this.hintxt,
    required this.onChanged,
    required this.tag,
    required this.errorText,
  }) {
    // Initialize once when widget is created
    if (Get.isRegistered<TextEditingController>(tag: tag)) {
      controller = Get.find<TextEditingController>(tag: tag);
    } else {
      controller = Get.put(TextEditingController(), tag: tag);
    }
  }

  @override
Widget build(BuildContext context) {
  return Obx(() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: AppTextStyles.subtitle),
      SizedBox(height: 3),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.07,
        child: TextField(
          controller: controller,
          onChanged: (value) {
            onChanged(value);
            if (errorText.value.isNotEmpty) {
              errorText.value = '';
            }
          },
          decoration: InputDecoration(
            hintText: hintxt,
            hintStyle: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(159, 158, 158, 1),
            ),
            filled: true,
            fillColor: Color.fromRGBO(237, 237, 237, 1),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color.fromRGBO(237, 237, 237, 1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
          ),
        ),
      ),

      // 👇 this now works
      errorText.value.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 4, left: 8),
              child: Text(
                errorText.value,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
            )
          : const SizedBox(),

      SizedBox(height: 5),
    ],
  ));
}
}

class NumberContainer extends StatelessWidget {
  final String title;
  final String number;
  final VoidCallback onTapDown;
  final VoidCallback onTapup;
  const NumberContainer({
    super.key,
    required this.title,
    required this.onTapDown,
    required this.onTapup,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      height: MediaQuery.of(context).size.height * 0.07,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromRGBO(218, 218, 218, 1)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(6, 8, 8, 8),
            blurRadius: 5,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(title, style: AppTextStyles.subtitle),
          Spacer(),
          Material(
            borderRadius: BorderRadius.circular(17),
            child: InkWell(
              onTap: onTapDown,
              child: Container(
                height: 17,
                width: 17,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(217, 217, 217, 1),
                  borderRadius: BorderRadius.circular(17),
                ),

                child: Image.asset('images/arrow_down.png'),
              ),
            ),
          ),

          SizedBox(
            height: 21,
            width: 30,
            child: Text(
              textAlign: TextAlign.center,
              number,
              style: GoogleFonts.montserrat(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),

          Material(
            borderRadius: BorderRadius.circular(17),
            child: InkWell(
              onTap: onTapup,
              child: Container(
                height: 17,
                width: 17,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(217, 217, 217, 1),
                  borderRadius: BorderRadius.circular(17),
                ),

                child: Image.asset('images/arrow_up.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NumberController extends GetxController {
  final RxInt passengers = 0.obs;
  final RxInt luggage = 0.obs;
  RxBool isOn = true.obs;

  void addPassenger() {
    passengers.value++;
  }

  void subPassenger() {
    if (passengers.value == 0) {
      passengers.value;
    } else {
      passengers.value--;
    }
  }

  void addLuggage() {
    luggage.value++;
  }

  void subLuggage() {
    if (luggage.value == 0) {
      luggage.value;
    } else {
      luggage.value--;
    }
  }
  void clear() {
  passengers.value = 0;
  luggage.value = 0;
  isOn.value = true;
}
}

//seocnd screen

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TapBar('Point-to-Point', 'Transfers', 'As Directed'),
          Expanded(
            child: TabBarView(
              children: [PointToPoint(), TransfersAirport(), AsDirected()],
            ),
          ),
        ],
      ),
    );
  }
}

class TapBar extends StatelessWidget {
  final String tab1;
  final String tab2;
  final String tab3;
  const TapBar(this.tab1, this.tab2, this.tab3);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(238, 236, 236, 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TabBar(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        labelPadding: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        splashFactory: NoSplash.splashFactory,
        indicatorPadding: EdgeInsets.zero,
        indicatorWeight: 0,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: Color.fromRGBO(218, 217, 217, 1),
          borderRadius: BorderRadius.circular(30),
        ),
        labelColor: Colors.black,
        labelStyle: AppTextStyles.h2,
        unselectedLabelColor: Color.fromRGBO(151, 148, 148, 1),
        unselectedLabelStyle: AppTextStyles.h3,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [Tab(text: tab1), Tab(text: tab2), Tab(text: tab3)],
      ),
    );
  }
}

class PointToPoint extends StatelessWidget {
   final TextEditingController pickupController = Get.put(TextEditingController(), tag: 'pickup'); // ✅ Created once
  final TextEditingController dropoffController = Get.put(TextEditingController(), tag: 'dropoff'); 
 final RxString pickupError = ''.obs;
  final RxString dropoffError = ''.obs;
  PointToPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          'The chosen driver will receive pickup and drop-off details immediately.',
          style: AppTextStyles.h4,
        ),
        SizedBox(height: 30),

        Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 4.5,
                  backgroundColor: Color.fromRGBO(65, 66, 67, 1),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  width: 1,
                  height: 46,
                  color: Color.fromRGBO(65, 66, 67, 1),
                ),

                CircleAvatar(
                  radius: 4.5,
                  backgroundColor: Color.fromRGBO(65, 66, 67, 1),
                ),
                SizedBox(height: 12),
              ],
            ),
            SizedBox(width: 10),
            Column(
              children: [
                THEtextfield(
      height: 46,
      width: 0.82,
      hintxt: 'Choose Pickup',
      controller: pickupController,
      errorText: pickupError,
    ),
    THEtextfield(
      height: 46,
      width: 0.82,
      hintxt: 'Choose Drop-off',
      controller: dropoffController,
      errorText: dropoffError,
    ),
              ],
            ),
          ],
        ),
        devider,
        SizedBox(height: 10),
        Row(children: [Reviewbtn(), Spacer(), NextBtn(
            validate: () {
              pickupError.value = '';
              dropoffError.value = '';
              
              final pickup = pickupController.text;
              final dropoff = dropoffController.text;
              
              bool isValid = true;
              
              if (pickup.trim().isEmpty) {
                pickupError.value = 'Pickup location is required';
                isValid = false;
              }
              
              if (dropoff.trim().isEmpty) {
                dropoffError.value = 'Drop-off location is required';
                isValid = false;
              }
              
              return isValid;
            },
            onPressedCallback: () {
              final tripController = Get.find<TripFormController>();
              tripController.tripType.value = 'Point-to-Point';
              tripController.startingPoint.value = pickupController.text;
              tripController.endPoint.value = dropoffController.text;
            },
          )])
      ],
    );
  }
}

class TransfersAirport extends StatelessWidget {
    final TextEditingController airportController = Get.put(TextEditingController(), tag: 'airport');
  final TextEditingController terminalController = Get.put(TextEditingController(), tag: 'terminal');
  final TextEditingController flightnbrController = Get.put(TextEditingController(), tag: 'flight');
  final TextEditingController directionController = Get.put(TextEditingController(), tag: 'direction');
  
  final RxString airportError = ''.obs;
  final RxString terminalError = ''.obs;
  final RxString flightError = ''.obs;
  final RxString directionError = ''.obs;
  TransfersAirport({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RadioController());
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Ensure the driver is available around the flight arrival time .',
            style: AppTextStyles.h4,
          ),
          SizedBox(height: 20),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<int>(
        activeColor: Colors.black,
        value: 1,
        groupValue: controller.selectedValue.value,
        onChanged: (value) {
          controller.selectedValue.value = value!;
          final tripController = Get.find<TripFormController>();
          tripController.transferType.value = 'Pick Up';
        },
      ),
      Text("Pick Up", style: AppTextStyles.subtitle),
      const SizedBox(width: 80),
      Radio<int>(
        activeColor: Colors.black,
        value: 2,
        groupValue: controller.selectedValue.value,
        onChanged: (value) {
          controller.selectedValue.value = value!;
          final tripController = Get.find<TripFormController>();
          tripController.transferType.value = 'Drop At';
        },
      ),
                Text("Drop At", style: AppTextStyles.subtitle),
              ],
            ),
          ),
          SizedBox(height: 20),
          THEtextfield(
            hintxt: 'Enter Airport Name',
            controller: airportController,
            height: 46,
            width: 0.9,
            label: 'Airport',
            errorText: airportError,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              THEtextfield(
                hintxt: 'Terminal',
                controller: terminalController,
                height: 50,
                width: 0.259,
                label: 'Terminal',
                errorText:terminalError ,
              ),
              SizedBox(width: 10),
              THEtextfield(
                hintxt: 'Flight Number',
                controller: flightnbrController,
                height: 50,
                width: 0.39,
                label: 'Flight Number',
                errorText: flightError,
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ETA',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.18,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(214, 0, 0, 0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          THEtextfield(
            hintxt: 'Departure / Arrival',
            controller: directionController,
            height: 46,
            width: 0.9,
            label: 'Direction',
            errorText: directionError,
          ),
          devider,
          Row(children: [Reviewbtn(), Spacer(), // At the bottom of TransfersAirport widget
 NextBtn(
              validate: () {
                airportError.value = '';
                terminalError.value = '';
                flightError.value = '';
                directionError.value = '';
                
                final airport = airportController.text;
                final terminal = terminalController.text;
                final flight = flightnbrController.text;
                final direction = directionController.text;
                
                bool isValid = true;
                
                if (airport.trim().isEmpty) {
                  airportError.value = 'Airport name is required';
                  isValid = false;
                }
                
                if (terminal.trim().isEmpty) {
                  terminalError.value = 'Terminal is required';
                  isValid = false;
                }
                
                if (flight.trim().isEmpty) {
                  flightError.value = 'Flight number is required';
                  isValid = false;
                }
                
                if (direction.trim().isEmpty) {
                  directionError.value = 'Direction is required';
                  isValid = false;
                }
                
                return isValid;
              },
              onPressedCallback: () {
                final tripController = Get.find<TripFormController>();
                tripController.tripType.value = 'Airport Transfer';
                tripController.startingPoint.value = airportController.text;
              },
            )])
        ],
      ),
    );
  }
}

class RadioController extends GetxController {
  var selectedValue = 0.obs;
}

class AsDirected extends StatelessWidget {
  final TextEditingController pickupADController = Get.put(TextEditingController(), tag: 'as_pickup');
  final TextEditingController durationController = Get.put(TextEditingController(), tag: 'duration');
  final TextEditingController specialnotesController = Get.put(TextEditingController(), tag: 'as_note');
   final RxString pickupError = ''.obs;
  final RxString durationError = ''.obs;
  final RxString noteError = ''.obs;
  AsDirected({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          'Assign a driver who is available for the full duration of this directed service.',
          style: AppTextStyles.h4,
        ),
        SizedBox(height: 25),
        THEtextfield(
          hintxt: 'Enter Pickup Point',
          controller: pickupADController,
          height: 50,
          width: 0.9,
          label: 'Pickup',
          errorText: pickupError,
        ),
        THEtextfield(
          hintxt: '',
          controller: durationController,
          height: 50,
          width: 0.9,
          label: 'Duration',
          errorText: durationError,
        ),
        THEtextfield(
          hintxt: 'Type...',
          controller: specialnotesController,
          height: 50,
          width: 0.9,
          label: 'Special Note',
          errorText: noteError,
        ),
        devider,
        Row(children: [Reviewbtn(), Spacer(), // At the bottom of TransfersAirport widget
// At the bottom of AsDirected widget
NextBtn(
            validate: () {
              pickupError.value = '';
              durationError.value = '';
              noteError.value = '';
              
              final pickup = pickupADController.text;
              final duration = durationController.text;
              
              
              bool isValid = true;
              
              if (pickup.trim().isEmpty) {
                pickupError.value = 'Pickup point is required';
                isValid = false;
              }
              
              if (duration.trim().isEmpty) {
                durationError.value = 'Duration is required';
                isValid = false;
              }
              
              
              
              return isValid;
            },
            onPressedCallback: () {
              final tripController = Get.find<TripFormController>();
              tripController.tripType.value = 'As Directed';
              tripController.startingPoint.value = pickupADController.text;
            },
          )])
      ],
    );
  }
}

class THEtextfield extends StatelessWidget {
  final String hintxt;
  final String? label;
  final double height;
  final double width;
  final TextEditingController controller;
  final RxString errorText;

  const THEtextfield({
    super.key,
    required this.hintxt,
    required this.controller,
    required this.height,
    required this.width,
    this.label,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Text(
              label!,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 2),
          ],
          SizedBox(
            height: height,
            width: MediaQuery.of(context).size.width * width,
            child: TextField(
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              controller: controller,
              onChanged: (value) {
                if (errorText.value.isNotEmpty && value.trim().isNotEmpty) {
                  errorText.value = '';
                }
              },
              decoration: InputDecoration(
                hintText: hintxt,
                hintStyle: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Color.fromRGBO(140, 140, 140, 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color.fromRGBO(65, 66, 67, 1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
          ),
          Obx(
            () => errorText.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 4, left: 8),
                    child: Text(
                      errorText.value,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}