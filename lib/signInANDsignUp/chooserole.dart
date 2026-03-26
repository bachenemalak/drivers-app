import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class chooserole extends StatefulWidget {
  const chooserole({super.key});

  @override
  State<chooserole> createState() => _chooseroleState();
}

String? selectedRole;

class _chooseroleState extends State<chooserole> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const baseWidth = 428;
    const baseHeight = 926;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: Image.asset("images/neon.jpg", fit: BoxFit.cover),
            ),
            Opacity(
              opacity: 0.6,
              child: Container(
                width: size.width,
                height: size.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xE6171717), //
                      Color(0x99505153), //
                    ],
                    stops: [0.3795, 1.0],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Choose Your Role",
                    style: GoogleFonts.montserrat(
                      fontSize: size.width * (33 / baseWidth), //
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    "to access your tailored dashboard and features.",
                    style: GoogleFonts.montserrat(
                      fontSize: size.width * (16.5 / baseWidth), //
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  GlassButton(
                    title: "Manager",
                    subtitle:
                        "Oversee bookings, assign drivers, and monitor operations.",
                    isActive: selectedRole == "Manager",
                    onTap: () {
                      setState(() {
                        selectedRole = "Manager";
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  GlassButton(
                    title: "Driver",
                    subtitle:
                        "Accept rides, manage pickups, and navigate efficiently.",
                    isActive: selectedRole == "Driver",
                    onTap: () {
                      setState(() {
                        selectedRole = "Driver";
                      });
                    },
                  ),
                ],
              ),
            ),

            Positioned(
              top: size.height * (800 / baseHeight),
              left: size.width * (40 / baseWidth),
              child: GestureDetector(
                onTap:
                    selectedRole != null
                        ? () {
                          Navigator.pushNamed(context, '/signIn');
                        }
                        : null,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      width: size.width * (350 / baseWidth),
                      height: size.height * (71 / baseHeight),
                      color: Colors.white.withOpacity(0.3),
                      child: Center(
                        child: Text(
                          "Continue",
                          style: GoogleFonts.montserrat(
                            fontSize: size.width * (25 / baseWidth),
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            height: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GlassButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isActive;
  final VoidCallback onTap;

  const GlassButton({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const baseWidth = 430;
    //onst baseHeight = 926;

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            width: size.width * 0.9,
            height: size.height * 0.21,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(179, 179, 179, 0.2),
                  Color.fromRGBO(255, 255, 255, 0.15),
                ],
                stops: [0.1645, 1.0],
              ),
              borderRadius: BorderRadius.circular(15),
              border:
                  isActive
                      ? Border.all(width: 3.0, color: Colors.white)
                      : Border.all(width: 1.0, color: Color(0x1ADCDCDC)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15),
                  child: Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontSize: size.width * (35 / baseWidth),
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 9),
                  child: Text(
                    subtitle,
                    style: GoogleFonts.montserrat(
                      fontSize: size.width * (16 / baseWidth),
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
