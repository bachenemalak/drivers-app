import 'package:car_app/navBars/Navbar.dart';

import 'package:flutter/material.dart';



class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  bool isAvailable = true;
  String status = "On Trip";

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      bottomNavigationBar: Navbar(
        selectedIndex: selectedIndex,
        onItemTapped: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
           
            Container(
              width: double.infinity,
              height: size.height * 0.25, // Increased height
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.98, -0.18),
                  end: Alignment(-0.98, 0.18),
                  colors: [
                    Color(0xFF757575),
                    Color(0xFF4B4949),
                    Color(0xFF202020),
                  ],
                  stops: [0.0639, 0.2411, 0.6948],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Row( 
                    children: [
                      const ImageIcon(
                        AssetImage("images/profile.png"),
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Hello, Driver!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                   SizedBox(height: size.height*0.06), 
                ],
              ),
            ),

            // Availability and Status Card - ONLY SHOWN WHEN isAvailable = true
            if (isAvailable)
              Transform.translate(
                offset: Offset(0, -50), // Pulls the card up into the header
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width*0.035),
                  padding: EdgeInsets.all(size.width*0.05),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                        color: Colors.black.withOpacity(0.08),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Availability",
                            style: TextStyle(
                              fontSize: size.width *0.045,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat'
                            ),
                          ),
                          Transform.scale(
                            scale: 0.7,
                            child: Switch(
                              value: isAvailable,
                              onChanged: (value) {
                                setState(() {
                                  isAvailable = value;
                                });
                              },
                              thumbColor: MaterialStateProperty.all(Colors.white),
                              trackColor: MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Colors.grey[850];
                                }
                                return Colors.grey; 
                              })
                            ),
                          ),
                        ],
                      ), 
                      SizedBox(height: size.height *0.015,),

                      Divider(height: 24 , color: Colors.grey[300],),
                      SizedBox(height: size.height *0.015,),
                      
                      Text(
                        "Status",
                        style: TextStyle(
                          fontSize: size.width *0.045,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat'
                        ),
                      ),
                      const SizedBox(height: 8),

                      Container(
                        width: size.width*0.6,
                        height: size.height*0.06,
                        padding: EdgeInsets.symmetric(horizontal: size.width*0.04),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: status,
                            isExpanded: true,
                            items: [
                              DropdownMenuItem(
                                value: "On Trip",
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.yellow,
                                    ),
                                    SizedBox(width: 8),
                                    Text("On Trip", style: TextStyle(
                                      fontSize: size.width *0.045,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Montserrat'
                                    ),),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "Available",
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.green,
                                    ),
                                    SizedBox(width: 8),
                                    Text("Available", style: TextStyle(
                                      fontSize: size.width *0.045,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Montserrat'
                                    ),),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "Scheduled",
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.blue,
                                    ),
                                    SizedBox(width: 8),
                                    Text("Scheduled", style: TextStyle(
                                      fontSize: size.width *0.045,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Montserrat'
                                    ),),
                                  ],
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                status = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Alternative Container when switch is OFF
            if (!isAvailable)
              Transform.translate(
                offset: Offset(0, -50),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width*0.035),
                  padding: EdgeInsets.all(size.width*0.05),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                        color: Colors.black.withOpacity(0.08),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Availability",
                            style: TextStyle(
                              fontSize: size.width *0.045,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat'
                            ),
                          ),
                          Transform.scale(
                            scale: 0.7,
                            child: Switch(
                              value: isAvailable,
                              onChanged: (value) {
                                setState(() {
                                  isAvailable = value;
                                });
                              },
                              thumbColor: MaterialStateProperty.all(Colors.white),
                              trackColor: MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Colors.grey[850];
                                }
                                return Colors.grey; 
                              })
                            ),
                          ),
                        ],
                      ),
                      
                      
                      
                      // Different content for when driver is unavailable
                     
                    ],
                  ),
                ),
              ),

            // Conditional Section
            Expanded(
              child: isAvailable
                  ? _currentTripCard()
                  : _placeholderWhenUnavailable(),
            ),
          
          ],
        ),
      ),
    );
  }

  // Current Trip Card
  Widget _currentTripCard() {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "  Current Trip",
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600, 
              fontSize: size.width * 0.045,
            )
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                  color: Colors.black.withOpacity(0.08),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Joe Biden Obama",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600, 
                    fontSize: size.width * 0.042,
                  )
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: size.width*0.045, color: Colors.black54),
                    SizedBox(width: 4),
                    Text(
                      "Point-to-Point",
                      style: TextStyle(color: Colors.black54 , fontSize: size.width*0.04),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _placeholderWhenUnavailable() {
    final size = MediaQuery.of(context).size;
    return  Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(height: size.height*0.25,
          width: size.width *0.6,
            child: Image.asset('images/X circle.png',)),
            
          Text(
            "Currently Not Available ",
            style: TextStyle(
              fontSize: size.width*0.07,
              color: Color.fromARGB(66, 0, 0, 0),
            ),
          ),
        ],
      ),
    );
  }
}