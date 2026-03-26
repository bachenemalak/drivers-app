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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.montserratTextTheme()),
      debugShowCheckedModeBanner: false,
      title: 'Car app',
       routes: {
        '/': (context) => Startingpage(),
        '/chooseRole': (context) => chooserole(),
        '/signIn': (context) => SignIn(),
        '/signUp': (context) => signup(),
        '/forgotPassword': (context) => forgotpassword(),
        '/manageDrivers': (context) => drivermanagment(),
        '/driverDetails': (context) => ManageDriversScreen(),
        '/dashboard': (context) => Dashboard(),
        '/clientsDetails': (context) => ClientDetails(),
        '/clientsManagment': (context) => Manageclients(),
        '/manageReservation': (context) => ManageRes(),
        '/createReservation': (context) => CreateRes(),
        '/managerProfile': (context) => ManagerProfile(),
        '/managerNotifications': (context) => ManagerNotifications(),
        '/driverHomeScreen': (context) => DriverHomeScreen(),
        '/manageTrips': (context) => DriverTrips(),
        '/driverProfile': (context) => DriverProfile(),
        '/driverNotificaations': (context) => DriverNotifications(),
      },
     
    );
  }
}


