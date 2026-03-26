import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class Startingpage extends StatelessWidget {
  const Startingpage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const baseWidth = 430;
    const baseHeight = 926;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: Image.asset("images/image.png", fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80, left: 30),
              child: Column(
                children: [
                  Text(
                    "Luxury Concierge",
                    style: GoogleFonts.baskervville(
                      fontSize: size.width * (50 / baseWidth), //
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Your personal assistant to a luxurious lifestyle",
                    maxLines: 2,
                    style: GoogleFonts.montserrat(
                      fontSize: size.width * (22 / baseWidth),
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/chooseRole');
                    ;
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        width: size.width * (370 / baseWidth),
                        height: size.height * (71 / baseHeight),
                        color: Colors.white.withOpacity(0.3),
                        child: Center(
                          child: Text(
                            "Get Started",
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
            ),
          ],
        ),
      ),
    );
  }
}
