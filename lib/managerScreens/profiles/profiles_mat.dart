import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopSection extends StatelessWidget {
  final String name;
  final String status;
  final String icon;
  const TopSection({
    super.key,
    required this.name,
    required this.status,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final hei = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textAlign: TextAlign.start,
          'My Profile',
          style: GoogleFonts.baskervville(
            fontSize: 39,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        SizedBox(height: hei * 0.05),
        Row(
          children: [
            Image.asset('images/profile.png'),
            SizedBox(width: 13),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Text(
                      status,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 5),
                    Image.asset(icon),
                  ],
                ),
                Text(
                  name,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class OptionButton extends StatelessWidget {
  final VoidCallback ontap;
  final String? icon;
  final String title;
  final IconData arrow;
  const OptionButton({
    super.key,
    required this.ontap,
     this.icon,
    required this.title,
    required this.arrow,
  });

  @override
  Widget build(BuildContext context) {
    final hei = MediaQuery.of(context).size.height;
    return SizedBox(
      height: hei * 0.065,

      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: ontap,
          child: Row(
            children: [
              if (icon != null) ... [
                Image.asset(icon!),

              ],
              SizedBox(width: 14),
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Icon(arrow, color: Colors.white, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class LogOutButton extends StatelessWidget {
  final VoidCallback ontap;
  const LogOutButton({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(174, 172, 172, 0.306),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.only(left: 13),
          side: BorderSide(color: Color.fromRGBO(220, 220, 220, 0.1)),
        ),
        onPressed: ontap,
        child: Row(
          children: [
            Image.asset('images/logOut.png'),
            SizedBox(width: 5),
            Text(
              'Log out',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
