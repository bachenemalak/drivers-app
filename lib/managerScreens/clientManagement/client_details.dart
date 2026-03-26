import 'package:car_app/managerScreens/reservation/materials.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../navBars/supervisorNavbar.dart';

class ClientDetails extends StatefulWidget {
  const ClientDetails({super.key});

  @override
  State<ClientDetails> createState() => _ClientDetailsState();
}

class _ClientDetailsState extends State<ClientDetails> {
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
                  label: Text('Chourouk', style: AppTextStyles.h1),
                  onPressed: () {
                    Navigator.pushNamed(context, '/clientsManagment');
                  },
                  icon: Icon(
                    color: Colors.black,
                    size: 25,
                    Icons.arrow_back_ios,
                  ),
                ),
                SizedBox(height: 10),
                ClientDetailsContainer(
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
                ClientDetailsContainer(
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 365,
      padding: const EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 15),

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
          SizedBox(height: 15),
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
          SizedBox(height: 15),
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
              SizedBox(width: 10),
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
          SizedBox(height: 10),
          Row(
            children: [
              Image.asset('images/carbon_time.png'),
              SizedBox(width: 3),
              Text('$date at $time', style: AppTextStyles.subtitle),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Image.asset('images/Vector.png'),
              SizedBox(width: 3),
              Text(vechicle, style: AppTextStyles.subtitle),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Image.asset('images/material-symbols_person.png'),
              SizedBox(width: 3),
              Text('Driver : Not assigned', style: AppTextStyles.subtitle),
            ],
          ),
          SizedBox(height: 10),
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
          Row(
            children: [
              Text(note, style: AppTextStyles.lessBold),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  size: 25,
                  Icons.file_download_outlined,
                  color: const Color.fromARGB(255, 93, 92, 92),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
