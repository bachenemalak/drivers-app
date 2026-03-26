import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

class forgotpassword extends StatefulWidget {
  const forgotpassword({super.key});

  @override
  State<forgotpassword> createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
  int currentStep = 0;
  late final List<Widget> pages = const [
    PageOne(),
    PageTwo(),
    PageThree(),
    PageFour(),
  ];

  void nextPage() {
    if (currentStep < pages.length - 1) {
      setState(() {
        currentStep++;
      });
    }
  }

  void previousPage() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1C1C1C), Color(0xFF414243)],
            stops: [0.5433, 0.8894],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      currentStep == 0 ? Navigator.pop(context) : previousPage;
                    },

                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    iconSize: size.width * 0.05,
                  ),
                ),
                SizedBox(height: size.height * 0.15),
                if (currentStep == 3)
                  Center(
                    child: SingleChildScrollView(child: pages[currentStep]),
                  )
                else
                  Expanded(child: pages[currentStep]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Forgot Password?",
            maxLines: 1,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: size.width * 0.082,
              height: 1.2,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.015),
        Text(
          "Don’t worry! It happens. Please enter the  \nemail associated with your account.",
          maxLines: 2,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            fontSize: size.width * 0.045,
            height: 1.4,
            color: Colors.white,
          ),
        ),
        SizedBox(height: size.height * 0.05),

        CustomTextField(
          label: "Email Address",
          hintText: "Enter Email Address",
          icon: Icons.email_outlined,
        ),
        SizedBox(height: size.height * 0.03),
        Container(
          height: size.height * 0.06,
          width: size.width * 0.85,
          child: ElevatedButton(
            onPressed: () {
              context
                  .findAncestorStateOfType<_forgotpasswordState>()
                  ?.nextPage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              'Send code',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Please check your email",
            maxLines: 2,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: size.width * 0.082,
              height: 1.2,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.015),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "We’ve sent a code to choub@gmail.com",
            maxLines: 2,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              fontSize: size.width * 0.045,
              height: 1.4,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.05),

        OtpFields(),
        SizedBox(height: size.height * 0.03),
        Container(
          height: size.height * 0.06,
          width: size.width * 0.85,
          child: ElevatedButton(
            onPressed: () {
              context
                  .findAncestorStateOfType<_forgotpasswordState>()
                  ?.nextPage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              'verify',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        ResendCodeButton(),
      ],
    );
  }
}

class PageThree extends StatefulWidget {
  const PageThree({super.key});

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  bool _isPasswordHidden = false;
  bool _isConfirmPasswordHidden = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Reset password",
            maxLines: 1,

            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: size.width * 0.082,
              height: 1.2,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.015),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Please type something you’ll remember.",
            maxLines: 2,

            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              fontSize: size.width * 0.045,
              height: 1.4,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.05),

        CustomTextField(
          label: "New password",
          hintText: "Enter your new password",
          icon: Icons.lock_outline_rounded,
          isPassword: true,
          obscureText: _isPasswordHidden,
          onToggleVisibility: () {
            setState(() {
              _isPasswordHidden = !_isPasswordHidden;
            });
          },
        ),
        SizedBox(height: size.height * 0.03),
        CustomTextField(
          label: "Confirm new password",
          hintText: "Confirm new password",
          icon: Icons.lock_outline_rounded,
          isPassword: true,
          obscureText: _isConfirmPasswordHidden,
          onToggleVisibility: () {
            setState(() {
              _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
            });
          },
        ),
        SizedBox(height: size.height * 0.03),
        Container(
          height: size.height * 0.06,
          width: size.width * 0.85,
          child: ElevatedButton(
            onPressed: () {
              context
                  .findAncestorStateOfType<_forgotpasswordState>()
                  ?.nextPage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              'Set Password',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account?",
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 0.03,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/signIn');
              },
              child: Text(
                " Log in",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: size.width * 0.03,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PageFour extends StatelessWidget {
  const PageFour({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                height: size.height * 0.3,
                width: size.width * 0.4,
                child: Image.asset("images/stars.png"),
              ),
            ),
            Text(
              "Password changed",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                fontSize: size.width * 0.07,
                height: 1.2,
                color: Colors.white,
              ),
            ),

            SizedBox(height: size.height * 0.015),
            Text(
              "Your password has been changed \nsuccefully",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
                fontSize: size.width * 0.04,
                height: 1.4,
                color: Colors.white,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Container(
              height: size.height * 0.06,
              width: size.width * 0.85,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signIn');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Back to Log in',
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: size.width * 0.04,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          cursorColor: Colors.white,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: size.width * 0.036,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w300,
            ),
            prefixIcon: Icon(
              icon,
              size: size.width * 0.045,
              color: Colors.white,
            ),
            filled: true,
            fillColor: const Color(0xFF9B9B9B),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            suffixIcon:
                isPassword
                    ? IconButton(
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.white,
                        size: size.width * 0.045,
                      ),
                      onPressed: onToggleVisibility,
                    )
                    : null,
          ),
        ),
      ],
    );
  }
}

class OtpFields extends StatelessWidget {
  OtpFields({super.key});

  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        return SizedBox(
          width: size.width * 0.18,
          height: size.height * 0.10,

          child: TextField(
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: const TextStyle(color: Colors.white, fontSize: 22),
            decoration: InputDecoration(
              counterText: "",
              filled: true,
              fillColor: Colors.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white, width: 0.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white, width: 0.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 3) {
                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
              }
              if (value.isEmpty && index > 0) {
                FocusScope.of(context).requestFocus(focusNodes[index - 1]);
              }
            },
          ),
        );
      }),
    );
  }
}

class ResendCodeButton extends StatefulWidget {
  const ResendCodeButton({super.key});

  @override
  State<ResendCodeButton> createState() => _ResendCodeButtonState();
}

class _ResendCodeButtonState extends State<ResendCodeButton> {
  int seconds = 30;
  Timer? timer;

  void startTimer() {
    seconds = 30;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds == 0) {
        t.cancel();
      } else {
        setState(() => seconds--);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:
          seconds == 0
              ? () {
                startTimer();
              }
              : null,
      child: Text(
        seconds == 0 ? "Send code again" : "Send code again 00:$seconds ",
        style: const TextStyle(
          color: Color.fromARGB(158, 255, 255, 255),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
