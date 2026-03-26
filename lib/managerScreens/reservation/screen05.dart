import 'package:car_app/managerScreens/reservation/res_screens.dart';
import 'package:flutter/material.dart';
import 'package:car_app/managerScreens/reservation/materials.dart';


class ScreenFive extends StatelessWidget {
  final specialController = TextEditingController();
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
        theRow,
      ],
    );
  }
}
