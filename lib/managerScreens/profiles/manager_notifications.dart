import 'package:car_app/managerScreens/reservation/materials.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManagerNotifications extends StatelessWidget {
  const ManagerNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              NotificationsTopBar(),
              NotificationsContainer(),
              NotificationsContainer(),
              NotificationsContainer(),
              NotificationsContainer(),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationsTopBar extends StatelessWidget {
  const NotificationsTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: Image.asset('images/maki_arrow.png'),
        ),

        Text(
          'Notifications',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),

        Image.asset('images/notifications_done.png'),
      ],
    );
  }
}

class NotificationsContainer extends StatelessWidget {
  const NotificationsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 5),
      height: 90,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.05), blurRadius: 4),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('images/notifications_profile.png'),
          SizedBox(width: 5),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  overflow: TextOverflow.clip,
                  maxLines: 5,
                  TextSpan(
                    children: [
                      TextSpan(text: 'chourouk', style: AppTextStyles.h2),
                      TextSpan(
                        text: 'didn`t pick up the client and left him waiting ',
                        style: AppTextStyles.h3,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '2 min ago',
                  style: GoogleFonts.montserrat(
                    fontSize: 9,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 5),
          CircleAvatar(radius: 3.5, backgroundColor: Colors.blue),
        ],
      ),
    );
  }
}
