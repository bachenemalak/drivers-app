import 'package:car_app/managerScreens/reservation/create_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final h1 = GoogleFonts.montserrat(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static final title = GoogleFonts.montserrat(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static final lessBold = GoogleFonts.montserrat(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static final subtitle = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static final h2 = GoogleFonts.montserrat(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static final h3 = GoogleFonts.montserrat(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Color.fromRGBO(151, 148, 148, 1),
  );
  static final h4 = GoogleFonts.montserrat(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static final formstyle1 = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
}

final devider = Divider(color: const Color.fromARGB(118, 0, 0, 0), height: 20);
final theRow = Row(children: [Reviewbtn(), Spacer(), NextBtn()]);

class SwitchButton extends StatelessWidget {
  final RxBool ison;
  const SwitchButton({super.key, required this.ison});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ison.toggle(),
      child: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 44,
          height: 23.5,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: ison.value ? Colors.black : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Align(
            alignment:
                ison.value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NextBtn extends StatelessWidget {
  final StepController controller = Get.put(StepController());
  final VoidCallback? onPressedCallback;
  final bool Function()? validate; // Add this

  NextBtn({super.key, this.onPressedCallback, this.validate}); // Add validate

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        minimumSize: Size(97, 45),
      ),
      onPressed: () {
        // Run validation first
        if (validate != null && !validate!()) {
          return; // Validation failed, don't navigate
        }
        
        // Run custom callback
        if (onPressedCallback != null) {
          onPressedCallback!();
        }
        
        // Navigate to next step
        controller.nextStep();
      },
      child: Text(
        'Next',
        style: GoogleFonts.montserrat(
          fontSize: 21,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}

class Reviewbtn extends StatelessWidget {
  const Reviewbtn({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        'Review',
        style: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}
