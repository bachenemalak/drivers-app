import 'package:car_app/signInANDsignUp/chooserole.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  final Controller controller = Get.put(Controller());
  SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final Hei = MediaQuery.of(context).size.height;
    //final wid = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                fit: BoxFit.fill,
                'images/background signin for user.png',
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  SizedBox(height: Hei * 0.11),
                  Text(
                    'Sign in to your \n Account',

                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      height: 0.9,
                      fontWeight: FontWeight.w600,
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Enter your email and password to log in',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    width: double.infinity,
                    height: Hei * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(135, 133, 133, 0.388),
                          Color.fromRGBO(77, 75, 75, 1),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          SizedBox(height: Hei * 0.05),
                          InputFields(hintTxt: 'Email', show: false),
                          SizedBox(height: 16),
                          Obx(
                            () => InputFields(
                              hintTxt: 'Password',
                              show: controller.show.value ? true : false,
                              icon:
                                  controller.show.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.toggle2();
                                },
                                child: Obx(
                                  () => Icon(
                                    size: 20,
                                    color: Colors.white,
                                    controller.remember.value
                                        ? Icons.check_box_outline_blank_rounded
                                        : Icons.check_box_outlined,
                                  ),
                                ),
                              ),

                              Text(
                                ' Remember me',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/forgotPassword',
                                  );
                                },
                                child: Text(
                                  'Forgot Password ?',
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40),
                          WhiteButton(
                            buttxt: 'Login',
                            ontap: () {
                              if (selectedRole == "Manager") {
                                Navigator.pushNamed(context, '/manageDrivers');
                              } else if (selectedRole == "Driver") {
                                Navigator.pushNamed(
                                  context,
                                  '/driverHomeScreen',
                                );
                              }
                            },
                          ),
                          SizedBox(height: 27),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 1.5,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '  Or login with  ',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 1.5,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 27),
                          WhiteButton(
                            buttxt: 'Continue with Google',
                            icon: 'images/google.png',
                            ontap: () {},
                          ),
                          SizedBox(height: 25),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don’t have an account?',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/signUp');
                                },
                                child: Text(
                                  'Sign Up',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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

class InputFields extends StatelessWidget {
  final Controller controller = Get.put(Controller());
  final String hintTxt;
  final bool show;
  final IconData? icon;
  InputFields({
    super.key,
    required this.hintTxt,
    required this.show,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,

      padding: EdgeInsets.only(left: 14, right: 14, bottom: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(228, 229, 231, 0.24), blurRadius: 2),
        ],
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(140, 140, 140, 1),
      ),
      child: TextField(
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        obscureText: show,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          suffixIcon:
              icon != null
                  ? Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: GestureDetector(
                      onTap: () {
                        controller.toggle1();
                      },
                      child: Icon(color: Colors.white, size: 18, icon),
                    ),
                  )
                  : null,

          border: InputBorder.none,
          hintText: hintTxt,
          hintStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class WhiteButton extends StatelessWidget {
  final String buttxt;
  final String? icon;
  final VoidCallback ontap;
  const WhiteButton({required this.buttxt, this.icon, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: ontap,
        child:
            icon != null
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(icon!),
                    SizedBox(width: 5),
                    Text(
                      buttxt,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
                : Text(
                  buttxt,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
      ),
    );
  }
}

class Controller extends GetxController {
  var show = false.obs;
  var remember = false.obs;

  void toggle1() {
    show.value = !show.value;
  }

  void toggle2() {
    remember.value = !remember.value;
  }
}
