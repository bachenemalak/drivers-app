import 'package:car_app/managerScreens/reservation/materials.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../navBars/supervisorNavbar.dart';

class ManageRes extends StatefulWidget {
  const ManageRes({super.key});

  @override
  State<ManageRes> createState() => _ManageResState();
}

class _ManageResState extends State<ManageRes> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(247, 247, 247, 1),
        bottomNavigationBar: supervisorNavbar(
          selectedIndex: selectedIndex,
          onItemTapped: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Manage Reservation', style: AppTextStyles.h1),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Created Reseravtions', style: AppTextStyles.title),
                  TextButton(
                    onPressed: () {},
                    child: Text('See all', style: AppTextStyles.lessBold),
                  ),
                ],
              ),
              SizedBox(height: 9),
              OldResContainer(
                clientName: ' Joe baiden',
                type: 'point to point',
                time: '2 min ago',
              ),
              SizedBox(height: 6),
              OldResContainer(
                clientName: ' Joe baiden',
                type: 'point to point',
                time: '2 min ago',
              ),
              SizedBox(height: 6),
              OldResContainer(
                clientName: ' Joe baiden',
                type: 'point to point',
                time: '2 min ago',
              ),
              SizedBox(height: 30),
              Text('Create New Reseravtion', style: AppTextStyles.title),
              SizedBox(height: 20),
              Material(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromRGBO(229, 229, 229, 1),

                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/createReservation');
                  },

                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color.fromRGBO(140, 140, 140, 1),
                      ),
                    ),
                    child: Center(child: Image.asset('images/lucide_plus.png')),
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

class OldResContainer extends StatelessWidget {
  final String clientName;
  final String type;
  final String time;

  const OldResContainer({
    super.key,
    required this.clientName,
    required this.type,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      elevation: 2,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,

        onTap: () {},
        child: Container(
          height: 86,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color.fromRGBO(218, 218, 218, 1)),
          ),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    clientName,
                    style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Image.asset('images/mdi_location.png'),
                      const SizedBox(width: 6),
                      Text(
                        type,
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Text(
                time,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 15),
              Image.asset('images/weui_arrow-filled.png'),
            ],
          ),
        ),
      ),
    );
  }
}
