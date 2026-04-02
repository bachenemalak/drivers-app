import 'package:car_app/managerScreens/clientManagement/client_details.dart';
import 'package:car_app/managerScreens/clientManagement/manageclients.dart';
import 'package:car_app/managerScreens/driverManagement/drivermanagment.dart';
import 'package:car_app/driverScreens/driverHomeScreen.dart';
import 'package:car_app/managerScreens/driverManagement/manageDriversScreen.dart';
import 'package:car_app/driverScreens/driver_trips.dart';
import 'package:car_app/managerScreens/dashboard.dart';
import 'package:car_app/managerScreens/reservation/manage_res.dart';
import 'package:car_app/driverScreens/driver_notifications.dart';
import 'package:car_app/driverScreens/driver_profile.dart';
import 'package:car_app/managerScreens/profiles/manager_notifications.dart';
import 'package:car_app/managerScreens/profiles/manager_profile.dart';
import 'package:car_app/managerScreens/reservation/create_res.dart';
import 'package:car_app/signInANDsignUp/chooserole.dart';
import 'package:car_app/signInANDsignUp/forgotpassword.dart';
import 'package:car_app/signInANDsignUp/signIn.dart';
import 'package:car_app/signInANDsignUp/signup.dart';
import 'package:car_app/signInANDsignUp/startingpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';  // Add this import
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(  // ← CHANGE THIS from MaterialApp to GetMaterialApp
      theme: ThemeData(textTheme: GoogleFonts.montserratTextTheme()),
      debugShowCheckedModeBanner: false,
      title: 'Car app',
      initialRoute: '/',  // Add this
      getPages: [  // Use getPages instead of routes for GetX
        GetPage(name: '/', page: () => Startingpage()),
        GetPage(name: '/chooseRole', page: () => chooserole()),
        GetPage(name: '/signIn', page: () => SignIn()),
        GetPage(name: '/signUp', page: () => signup()),
        GetPage(name: '/forgotPassword', page: () => forgotpassword()),
        GetPage(name: '/manageDrivers', page: () => drivermanagment()),
        GetPage(name: '/driverDetails', page: () => ManageDriversScreen()),
        GetPage(name: '/dashboard', page: () => Dashboard()),
        GetPage(name: '/clientsDetails', page: () => ClientDetails(clientId: Get.arguments?.toString() ?? '')),
        GetPage(name: '/clientsManagment', page: () => Manageclients()),
        GetPage(name: '/manageReservation', page: () => ManageRes()),
        GetPage(name: '/createReservation', page: () => CreateRes()),
        GetPage(name: '/managerProfile', page: () => ManagerProfile()),
        GetPage(name: '/managerNotifications', page: () => ManagerNotifications()),
        GetPage(name: '/driverHomeScreen', page: () => DriverHomeScreen()),
        GetPage(name: '/manageTrips', page: () => DriverTrips()),
        GetPage(name: '/driverProfile', page: () => DriverProfile()),
        GetPage(name: '/driverNotificaations', page: () => DriverNotifications()),
      ],
    );
  }
}