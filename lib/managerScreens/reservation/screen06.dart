import 'package:flutter/material.dart';
import 'package:car_app/managerScreens/reservation/materials.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenSix extends StatelessWidget {
  final formController = Get.put(ClientFormController());

  ScreenSix({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ClientForm(
            fullName: 'Joe Biden Obama',
            passengers: '2',
            luggage: '4',
            type: 'Point-to-Point:',
            startingPoint: 'Rue Lkoucha bab dar N°34',
            endPoint: 'Anasseur Street BV 2314',
            date: '02/02/2025 ',
            time: '5:41 AM',
            vechicle: 'Sedan G class of 4 places',
            note: 'drive slowly',
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
                  onPressed: formController.assign.value ? null : () {},
                  child: Text(
                    'create',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color:
                          formController.assign.value
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
  });

  @override
  Widget build(BuildContext context) {
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
            Text(note, style: AppTextStyles.lessBold),
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
}
