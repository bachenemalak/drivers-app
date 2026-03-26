import 'package:car_app/managerScreens/reservation/materials.dart';
import 'package:car_app/managerScreens/reservation/res_screens.dart';
import 'package:car_app/managerScreens/reservation/screen06.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../navBars/Navbar.dart';

class DriverTrips extends StatefulWidget {
  const DriverTrips({super.key});

  @override
  State<DriverTrips> createState() => _DriverTripsState();
}

class _DriverTripsState extends State<DriverTrips> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;
    return SafeArea(
      child: Scaffold(
        
        bottomNavigationBar: Navbar(
          selectedIndex: selectedIndex,
          onItemTapped: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Manage Trips', style: AppTextStyles.h1),
              SizedBox(height: 10),
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      TapBar('Upcoming', 'Completed', 'Cancelled'),
                      SizedBox(height: 10),
                      Expanded(
                        child: TabBarView(
                          children: [
                            UpcomingScreen(),
                            CompletedScreen(),
                            CancelledScreen(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpcomingScreen extends StatelessWidget {
  const UpcomingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DateTimeRow(date: '17 June, 2025', time: '5:41 AM'),
          SizedBox(height: 10),
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
        ],
      ),
    );
  }
}

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DateTimeRow(date: '17 June, 2025', time: '5:41 AM'),
          SizedBox(height: 10),

          CompletedTripsContainer(
            passengers: '2',
            luggage: '4',
            type: 'Point to Point',
            startingPoint: 'Rue Lkoucha bab dar N°34',
            endPoint: 'Anasseur Street BV 2314',
          ),
          SizedBox(height: 10),
          devider,
        ],
      ),
    );
  }
}

class CompletedTripsContainer extends StatelessWidget {
  final String passengers;
  final String luggage;
  final String type;
  final String startingPoint;
  final String endPoint;

  const CompletedTripsContainer({
    super.key,
    required this.passengers,
    required this.luggage,
    required this.type,
    required this.startingPoint,
    required this.endPoint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color.fromRGBO(218, 218, 218, 1)),
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 4),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset('images/check_icon.png'),
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

          Divider(height: 15),
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
        ],
      ),
    );
  }
}

class CancelledScreen extends StatelessWidget {
  const CancelledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('images/X circle.png'),
        Text(
          'No Cancelled Trips',
          style: GoogleFonts.montserrat(
            fontSize: 32,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(208, 208, 208, 1),
          ),
        ),
      ],
    );
  }
}

class DateTimeRow extends StatelessWidget {
  final String date;
  final String time;
  const DateTimeRow({super.key, required this.date, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          date,
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        Spacer(),
        Text(
          time,
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
