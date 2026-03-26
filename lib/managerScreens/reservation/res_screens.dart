import 'package:car_app/managerScreens/reservation/screen06.dart';
import 'package:flutter/material.dart';
import 'package:car_app/managerScreens/reservation/materials.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenOne extends StatelessWidget {
  final formController = Get.put(ClientFormController());
  final NumberController controller = Get.put(NumberController());
  ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoInput(
          title: 'Full Name',
          hintxt: 'Enter Full Name',
          onChanged: (value) => formController.fullName.value = value,
        ),
        InfoInput(
          title: 'Phone number',
          hintxt: 'Enter Phone Number',
          onChanged: (value) => formController.phoneNumber.value = value,
        ),
        InfoInput(
          title: 'Email',
          hintxt: 'Enter Email',
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
        Align(alignment: Alignment.bottomRight, child: NextBtn()),
      ],
    );
  }
}

class InfoInput extends StatelessWidget {
  final String title;
  final String hintxt;
  final Function(String) onChanged;

  const InfoInput({
    super.key,
    required this.title,
    required this.hintxt,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.subtitle),
        SizedBox(height: 3),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          child: TextField(
            onChanged: onChanged,
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
        SizedBox(height: 5),
      ],
    );
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
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController dropoffController = TextEditingController();
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
                ),
                THEtextfield(
                  height: 46,
                  width: 0.82,
                  hintxt: 'Choose Drop-off',
                  controller: dropoffController,
                ),
              ],
            ),
          ],
        ),
        devider,
        SizedBox(height: 10),
        theRow,
      ],
    );
  }
}

class TransfersAirport extends StatelessWidget {
  final TextEditingController airportController = TextEditingController();
  final TextEditingController terminalController = TextEditingController();
  final TextEditingController flightnbrController = TextEditingController();
  final TextEditingController directionController = TextEditingController();
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
              ),
              SizedBox(width: 10),
              THEtextfield(
                hintxt: 'Flight Number',
                controller: flightnbrController,
                height: 50,
                width: 0.39,
                label: 'Flight Number',
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
          ),
          devider,
          theRow,
        ],
      ),
    );
  }
}

class RadioController extends GetxController {
  var selectedValue = 0.obs;
}

class AsDirected extends StatelessWidget {
  final TextEditingController pickupADController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController specialnotesController = TextEditingController();
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
        ),
        THEtextfield(
          hintxt: '',
          controller: durationController,
          height: 50,
          width: 0.9,
          label: 'Duration',
        ),
        THEtextfield(
          hintxt: 'Type...',
          controller: specialnotesController,
          height: 50,
          width: 0.9,
          label: 'Special Note',
        ),
        devider,
        theRow,
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
  const THEtextfield({
    super.key,
    required this.hintxt,
    required this.controller,
    required this.height,
    required this.width,
    this.label,
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
        ],
      ),
    );
  }
}
