import 'package:car_app/managerScreens/profiles/profiles_mat.dart';
import 'package:flutter/material.dart';

class ManagerProfile extends StatelessWidget {
  const ManagerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final hei = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(30),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(28, 28, 28, 1),
                Color.fromRGBO(65, 66, 67, 1),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              TopSection(
                name: 'Salah Kherif',
                status: 'Manager',
                icon: 'images/manager_role.png',
              ),
              SizedBox(height: 10),
              Divider(color: Colors.white, thickness: 0.2),
              OptionButton(
                ontap: () {},
                icon: 'images/notifications.png',
                title: 'Notifications',
                arrow: Icons.keyboard_arrow_right_outlined,
              ),
              OptionButton(
                ontap: () {},
                icon: 'images/team_managemet.png',
                title: 'Team Management',
                arrow: Icons.expand_more,
              ),
              OptionButton(
                ontap: () {},
                icon: 'images/reports.png',
                title: 'Reports',
                arrow: Icons.expand_more,
              ),
              SizedBox(height: hei * 0.11),
              Divider(color: Colors.white, thickness: 0.2),
              OptionButton(
                ontap: () {},
                icon: 'images/settings.png',
                title: 'Settings',
                arrow: Icons.keyboard_arrow_right_outlined,
              ),
              OptionButton(
                ontap: () {},
                icon: 'images/help.png',
                title: 'Help & Support',
                arrow: Icons.keyboard_arrow_right_outlined,
              ),
              SizedBox(height: 30),
              LogOutButton(ontap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
