import 'package:car_app/managerScreens/reservation/res_screens.dart';
import 'package:car_app/managerScreens/reservation/screen03.dart';
import 'package:car_app/managerScreens/reservation/screen04.dart';
import 'package:car_app/managerScreens/reservation/screen05.dart';
import 'package:car_app/managerScreens/reservation/screen06.dart';
import 'package:flutter/material.dart';
import 'package:car_app/managerScreens/reservation/materials.dart';
import 'package:get/get.dart';

import '../../navBars/supervisorNavbar.dart';
//import 'res_screens.dart';

class CreateRes extends StatefulWidget {
  const CreateRes({super.key});

  @override
  State<CreateRes> createState() => _CreateResState();
}

class _CreateResState extends State<CreateRes> {
  final StepController controller = Get.put(StepController());

  final List<Widget> steps = [
    ScreenOne(),
    ScreenTwo(),
    ScreenThree(),
    ScreenFour(),
    ScreenFive(),
    ScreenSix(),
  ];

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;
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
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      controller.currentStep.value == 0
                          ? Navigator.pushNamed(context, '/manageReservation')
                          : controller.previousStep();
                    },

                    icon: Image.asset('images/maki_arrow.png'),
                  ),
                  Text('Create Reservation', style: AppTextStyles.h1),
                ],
              ),
              SizedBox(height: 20),
              StepIndicator(),
              SizedBox(height: 20),
              Obx(() => Expanded(child: steps[controller.currentStep.value])),
            ],
          ),
        ),
      ),
    );
  }
}

class StepController extends GetxController {
  final int totalSteps = 6;
  final RxInt currentStep = 0.obs;

  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }
}

class StepIndicator extends StatelessWidget {
  StepIndicator({super.key});

  final StepController controller = Get.put(StepController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              controller.totalSteps,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),

                width: MediaQuery.of(context).size.width * 0.13,
                height: 8,
                decoration: BoxDecoration(
                  color:
                      index <= controller.currentStep.value
                          ? Color.fromRGBO(65, 66, 67, 1)
                          : Color.fromRGBO(217, 217, 217, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
