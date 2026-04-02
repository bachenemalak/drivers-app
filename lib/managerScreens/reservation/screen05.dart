import 'package:car_app/managerScreens/reservation/res_screens.dart';
import 'package:flutter/material.dart';
import 'package:car_app/managerScreens/reservation/materials.dart';
import 'package:car_app/managerScreens/reservation/screen06.dart';
import 'package:get/get.dart';

class ScreenFive extends StatelessWidget {
  final specialController = Get.put(TextEditingController(), tag: 'special');
  final RxString specialError = ''.obs;
  ScreenFive({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        THEtextfield(
          hintxt: 'Type..',
          controller: specialController,
          height: 132,
          width: 0.9,
          label: 'Special Instructions',
          errorText: specialError,

        ),
        SizedBox(height: 30),
        Material(
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color.fromRGBO(218, 218, 218, 1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(6, 8, 8, 8),
                    blurRadius: 5,
                    offset: Offset(0, 4),
                  ),
                ],
              ),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Attachments', style: AppTextStyles.subtitle),
                  Icon(Icons.attach_file_rounded),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 40),
        devider,
        Row(children: [Reviewbtn(), Spacer(), // At the bottom of TransfersAirport widget
// At the bottom of AsDirected widget
// At the bottom of ScreenThree
// At the bottom of ScreenFour
// At the bottom of ScreenFive
NextBtn(
  onPressedCallback: () {
    final tripController = Get.find<TripFormController>();
    tripController.specialInstructions.value = specialController.text;
  },
)])
      ],
    );
  }
}
