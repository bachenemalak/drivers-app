import 'package:car_app/managerScreens/profiles/profiles_mat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../navBars/Navbar.dart';

class DriverProfile extends StatefulWidget {
  DriverProfile({super.key});

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  final ProfileCotroller controller = Get.put(ProfileCotroller());

  @override
  Widget build(BuildContext context) {
    final hei = MediaQuery.of(context).size.height;
    int selectedIndex = 3;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(65, 66, 67, 1),
        bottomNavigationBar: Navbar(
          selectedIndex: selectedIndex,
          onItemTapped: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        body: Container(
          padding: EdgeInsets.only(top: 30, left: 30, right: 30),
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                TopSection(
                  name: 'Si Driver',
                  status: 'Driver',
                  icon: 'images/online.png',
                ),
                SizedBox(height: 10),
                Divider(color: Colors.white, thickness: 0.2),
                OptionButton(
                  ontap: () {},
                  icon: 'images/chat.png',
                  title: 'Chat with Supervisor',
                  arrow: Icons.keyboard_arrow_right_outlined,
                ),
                Obx(
                  () => OptionButton(
                    ontap: () {
                      controller.documentExpend.toggle();
                    },
                    icon: 'images/document.png',
                    title: 'Documents',
                    arrow:
                        controller.documentExpend.value
                            ? Icons.expand_less
                            : Icons.expand_more,
                  ),
                ),
                Obx(
                  () =>
                      controller.documentExpend.value
                          ? Column(
                            children: [
                              OptionButton(
                                ontap: () {},
                                title: 'Driver`s License',
                                arrow: Icons.keyboard_arrow_right_outlined,
                              ),
                              OptionButton(
                                ontap: () {},
                                title: 'Insurance Document',
                                arrow: Icons.keyboard_arrow_right_outlined,
                              ),
                            ],
                          )
                          : SizedBox(),
                ),

                Obx(
                  () => OptionButton(
                    ontap: () {
                      controller.vehicleExpand.toggle();
                    },
                    icon: 'images/vechicle.png',
                    title: 'Vehicle Details',
                    arrow:
                        controller.vehicleExpand.value
                            ? Icons.expand_less
                            : Icons.expand_more,
                  ),
                ),
                Obx(
                  () =>
                      controller.vehicleExpand.value
                          ? Column(
                            children: [
                              OptionButton(
                                ontap: () {},
                                title: 'Vehicle Registration',
                                arrow: Icons.keyboard_arrow_right_outlined,
                              ),
                              OptionButton(
                                ontap: () {},
                                title: 'Vehicle Type & Color',
                                arrow: Icons.keyboard_arrow_right_outlined,
                              ),
                            ],
                          )
                          : SizedBox(),
                ),

                SizedBox(height: hei * 0.09),
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
                LogOutButton(
                  ontap: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileCotroller extends GetxController {
  RxBool documentExpend = false.obs;
  RxBool vehicleExpand = false.obs;
}
