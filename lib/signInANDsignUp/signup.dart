import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  int currentStep = 0;
  late final List<Widget> pages = const [
    PageOne(),
    PageTwo(),
    PageThree(),
    PageFour(),
    PageFive(),
    pageSix(),
    pageSeven(),
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
    double progress = (currentStep + 1) / pages.length;
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          currentStep == 0
                              ? Navigator.pop(context)
                              : previousPage;
                        },

                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        iconSize: size.width * 0.05,
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Container(
                          width: size.width * 0.5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 8,
                              backgroundColor: Colors.grey.shade800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.05),
                  ],
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: pages[currentStep],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                  indent: 20,
                  endIndent: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 10,
                  ),

                  child: Container(
                    height: size.height * 0.06,
                    width: size.width * 0.85,
                    child: ElevatedButton(
                      onPressed: () {
                        currentStep == pages.length - 1
                            ? Navigator.pushNamed(context, '/signIn')
                            : nextPage();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        currentStep == pages.length - 1
                            ? "Log In"
                            : currentStep == pages.length - 2
                            ? "Create Account"
                            : "Continue",

                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                if (currentStep == 0)
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Create your account",
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: size.width * 0.082,
            height: 1.2,
            color: Colors.white,
          ),
        ),
        SizedBox(height: size.height * 0.015),
        Text(
          "Enter your personal details to get \n started",
          maxLines: 2,
          textAlign: TextAlign.center,
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
          label: "Full Name",
          hintText: "Full Name",
          icon: Icons.person_2_outlined,
        ),
        SizedBox(height: size.height * 0.03),
        CustomTextField(
          label: "Phone Number",
          hintText: "Phone Number",
          icon: Icons.phone_outlined,
        ),
        SizedBox(height: size.height * 0.03),
        CustomTextField(
          label: "Email Address",
          hintText: "Enter Email Address",
          icon: Icons.email_outlined,
        ),
      ],
    );
  }
}

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  bool _isPasswordHidden = false;
  bool _isConfirmPasswordHidden = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Create a Password",
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: size.width * 0.082,
            height: 1.2,
            color: Colors.white,
          ),
        ),
        SizedBox(height: size.height * 0.015),
        Text(
          "Set a secure password to protect \n your account",
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            fontSize: size.width * 0.045,
            height: 1.4,
            color: Colors.white,
          ),
        ),
        SizedBox(height: size.height * 0.1),

        CustomTextField(
          label: "Password",
          hintText: "Enter your Password",
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
          label: "Confirm Password",
          hintText: "Confirm Password",
          icon: Icons.lock_outline_rounded,
          isPassword: true,
          obscureText: _isConfirmPasswordHidden,
          onToggleVisibility: () {
            setState(() {
              _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
            });
          },
        ),

        SizedBox(height: size.height * 0.12),
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
  String? selectedCar;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Vehicle Details",
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: size.width * 0.082,
            height: 1.2,
            color: Colors.white,
          ),
        ),
        SizedBox(height: size.height * 0.015),
        Text(
          "Enter your vehicle information",
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            fontSize: size.width * 0.045,
            height: 1.4,
            color: Colors.white,
          ),
        ),
        SizedBox(height: size.height * 0.085),
        CustomDropdownField(
          label: "Vehicle type",
          hintText: "Vehicle type",
          icon: Icons.car_repair_outlined,
          items: const ["Sedan", "Suv", "Multi_Pax"],
          value: selectedCar,
          onChanged: (val) => setState(() => selectedCar = val),
        ),
        SizedBox(height: size.height * 0.03),
        CustomTextField(
          label: "License plate ",
          hintText: "e.g. 123-ABC",
          icon: Icons.card_travel_outlined,
        ),
        SizedBox(height: size.height * 0.03),
        CustomDropdownField(
          label: "Vehicle Color",
          hintText: "Vehicle Color",
          icon: Icons.water_drop_outlined,
          items: const ["Black", "White", "Grey"],
          value: selectedCar,
          onChanged: (val) => setState(() => selectedCar = val),
        ),
      ],
    );
  }
}

class PageFour extends StatefulWidget {
  const PageFour({super.key});

  @override
  State<PageFour> createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  File? _image;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Upload a photo of your \nDriver’s License",
            maxLines: 2,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              fontSize: size.width * 0.06,
              height: 1.2,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Please upload a clear photo of your driver’s \nlicense. Make sure all details are visible",
            maxLines: 2,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              fontSize: size.width * 0.04,
              height: 1.4,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.085),
        ImageUploadField(
          label: "Upload ID",
          hintText: "Select File",
          icon: Icons.photo,
          onImageSelected: (file) {
            if (file != null) {
              print("Image selected: ${file.path}");
            }
          },
        ),
        SizedBox(height: size.height * 0.02),
        Padding(
          padding: const EdgeInsets.all(11),
          child: Row(
            children: [
              Expanded(child: Divider(color: Colors.grey, thickness: 1)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('or', style: TextStyle(color: Colors.white70)),
              ),
              Expanded(child: Divider(color: Colors.grey, thickness: 1)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),

          child: Container(
            height: size.height * 0.06,
            width: size.width * 0.85,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8c8c8c),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: size.width * 0.05,
                  ),
                  SizedBox(width: size.width * 0.05),

                  Text(
                    "Open Camera & Take Photo ",

                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: size.width * 0.035,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PageFive extends StatefulWidget {
  const PageFive({super.key});

  @override
  State<PageFive> createState() => _PageFiveState();
}

class _PageFiveState extends State<PageFive> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Upload a photo of your \nInsurance Document",
            maxLines: 2,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              fontSize: size.width * 0.06,
              height: 1.2,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Upload a valid insurance document. Ensure \nthat the policy number and dates are clearly \nreadable.",
            maxLines: 3,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              fontSize: size.width * 0.04,
              height: 1.4,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.085),
        ImageUploadField(
          label: "Upload ID",
          hintText: "Select File",
          icon: Icons.photo,
          onImageSelected: (file) {
            if (file != null) {
              print("Image selected: ${file.path}");
            }
          },
        ),
        SizedBox(height: size.height * 0.02),
        Padding(
          padding: const EdgeInsets.all(11),
          child: Row(
            children: [
              Expanded(child: Divider(color: Colors.grey, thickness: 1)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('or', style: TextStyle(color: Colors.white70)),
              ),
              Expanded(child: Divider(color: Colors.grey, thickness: 1)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),

          child: Container(
            height: size.height * 0.06,
            width: size.width * 0.85,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8c8c8c),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: size.width * 0.05,
                  ),
                  SizedBox(width: size.width * 0.05),

                  Text(
                    "Open Camera & Take Photo ",

                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: size.width * 0.035,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class pageSix extends StatelessWidget {
  const pageSix({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Upload a photo of your \nVehicle Registration",
            maxLines: 2,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              fontSize: size.width * 0.06,
              height: 1.2,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Please upload your vehicle registration \ndocument. Ensure the owner details are visible",
            maxLines: 2,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              fontSize: size.width * 0.04,
              height: 1.4,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.085),
        ImageUploadField(
          label: "Upload ID",
          hintText: "Select File",
          icon: Icons.photo,
          onImageSelected: (file) {
            if (file != null) {
              print("Image selected: ${file.path}");
            }
          },
        ),
        SizedBox(height: size.height * 0.02),
        Padding(
          padding: const EdgeInsets.all(11),
          child: Row(
            children: [
              Expanded(child: Divider(color: Colors.grey, thickness: 1)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('or', style: TextStyle(color: Colors.white70)),
              ),
              Expanded(child: Divider(color: Colors.grey, thickness: 1)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),

          child: Container(
            height: size.height * 0.06,
            width: size.width * 0.85,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8c8c8c),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: size.width * 0.05,
                  ),
                  SizedBox(width: size.width * 0.05),

                  Text(
                    "Open Camera & Take Photo ",

                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: size.width * 0.035,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class pageSeven extends StatelessWidget {
  const pageSeven({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            height: size.height * 0.3,
            width: size.width * 0.4,
            child: Image.asset("images/Vector.png"),
          ),
        ),
        Text(
          "Account Created \nSuccefully",
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
          "Your driver account has been set up \nsuccessfully",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            fontSize: size.width * 0.04,
            height: 1.4,
            color: Colors.white,
          ),
        ),
      ],
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
            fontWeight: FontWeight.w500,
            fontSize: size.width * 0.04,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          cursorColor: Colors.white,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: size.width * 0.036,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w400,
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

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.hintText,
    required this.icon,
    required this.items,
    required this.value,
    required this.onChanged,
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
            fontWeight: FontWeight.w500,
            fontSize: size.width * 0.04,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF8c8c8c),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: size.width * 0.045),
              SizedBox(width: size.width * 0.03),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: value,
                    hint: Text(
                      hintText,
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.035,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    dropdownColor: const Color(0xFF8c8c8c),
                    icon: const Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.white,
                    ),
                    isExpanded: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.036,
                    ),
                    items:
                        items
                            .map(
                              (item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: onChanged,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ImageUploadField extends StatefulWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final void Function(File?)? onImageSelected;

  const ImageUploadField({
    super.key,
    required this.label,
    required this.hintText,
    required this.icon,
    this.onImageSelected,
  });

  @override
  State<ImageUploadField> createState() => _ImageUploadFieldState();
}

class _ImageUploadFieldState extends State<ImageUploadField> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
      if (widget.onImageSelected != null) {
        widget.onImageSelected!(_selectedImage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: size.height * 0.22,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF303030),
              borderRadius: BorderRadius.circular(35),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child:
                _selectedImage == null
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          widget.icon,
                          color: Colors.white,
                          size: size.width * 0.08,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.hintText,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: size.width * 0.036,
                          ),
                        ),
                      ],
                    )
                    : ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
          ),
        ),
      ],
    );
  }
}
