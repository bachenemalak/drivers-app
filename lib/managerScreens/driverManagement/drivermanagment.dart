import 'package:car_app/navBars/supervisorNavbar.dart';

import 'package:flutter/material.dart';

enum DriverStatus { available, scheduled, onTrip, offline }

class drivermanagment extends StatefulWidget {
  const drivermanagment({super.key});

  @override
  State<drivermanagment> createState() => _drivermanagmentState();
}

class _drivermanagmentState extends State<drivermanagment> {
  //this is just to help me when i add the database
  List<Driver> get demoDrivers => [
    Driver(
      id: 'd1',
      name: 'Chourouk Ba',
      status: DriverStatus.onTrip,
      clientInfo: 'Client: John • Airport drop-off',
      phone: '+213 6 00 00 000',
      vehicle: 'suv',
    ),
    Driver(
      id: 'd2',
      name: 'Djihane Lao',
      status: DriverStatus.available,
      clientInfo: 'Ready for assignment',
      phone: '+213 6 11 11 111',
      vehicle: 'suv',
    ),
    Driver(
      id: 'd3',
      name: 'Racha Chouali',
      status: DriverStatus.offline,
      clientInfo: 'Offline - last seen 2h ago',
      vehicle: 'suv',
    ),
    Driver(
      id: 'd4',
      name: 'Malak Bachene',
      status: DriverStatus.scheduled,
      clientInfo: 'Pickup at 14:00 — University Campus',
      vehicle: 'suv',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final drivers = demoDrivers;
    final size = MediaQuery.of(context).size;
    int selectedIndex = 2;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        bottomNavigationBar: supervisorNavbar(
          selectedIndex: selectedIndex,
          onItemTapped: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 25, 16, 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Manage drivers',
                    style: TextStyle(
                      fontSize: size.height * 0.045,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02), // not working search
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: size.height * 0.06,
                      padding: EdgeInsets.symmetric(horizontal: 10),
      
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: ' Search.. ',
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.01),
                  Container(
                    height: size.height * 0.06,
                    width: size.width * 0.09,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.grey),
                  ),
                ],
              ),
      
              const SizedBox(height: 14),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    child: Text(
                      'Recent ',
                      style: TextStyle(
                        fontSize: size.height * 0.027,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  //filter not working
                  InkWell(
                    child: Row(
                      children: [
                        Image.asset('images/filtericon.png'),
                        SizedBox(width: size.width * 0.01),
                        Text(
                          'Filter ',
                          style: TextStyle(
                            fontSize: size.height * 0.022,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
      
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                        ),
                        builder:
                            (context) => FractionallySizedBox(
                              heightFactor: 0.45,
                              child: const DriverFilterPanel(),
                            ),
                      );
                    },
                  ),
                ],
              ),
      
              SizedBox(height: size.height * 0.02),
      
              // list
              Expanded(
                child: ListView.builder(
                  itemCount: drivers.length,
                  itemBuilder: (context, idx) {
                    final d = drivers[idx];
                    return DriverCard(
                      driver: d,
                      onTap: () {
                        Navigator.pushNamed(context, '/driverDetails');
                      },
                      onCall: () {},
                      onMessage: () {},
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Driver {
  final String id;
  final String name;
  final DriverStatus status;
  final String? clientInfo;
  final String? phone;
  final String? image;
  final String? vehicle;

  Driver({
    required this.id,
    required this.name,
    required this.status,
    this.clientInfo,
    this.phone,
    this.image,
    this.vehicle,
  });
}

class DriverCard extends StatelessWidget {
  final Driver driver;
  final VoidCallback? onCall;
  final VoidCallback? onMessage;
  final VoidCallback? onTap;

  DriverCard({
    super.key,
    required this.driver,
    this.onCall,
    this.onMessage,
    this.onTap,
  });

  Color _statusColor() {
    switch (driver.status) {
      case DriverStatus.available:
        return Colors.green;
      case DriverStatus.onTrip:
        return Colors.blue;
      case DriverStatus.scheduled:
        return Colors.orange;
      case DriverStatus.offline:
        return Colors.grey;
    }
  }

  String _statusText() {
    switch (driver.status) {
      case DriverStatus.available:
        return "Available";
      case DriverStatus.onTrip:
        return "On Trip";
      case DriverStatus.scheduled:
        return "Scheduled";
      case DriverStatus.offline:
        return "Offline";
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(size.height * 0.018),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 2,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.grey.shade100,
              backgroundImage:
                  (driver.image != null && driver.image!.isNotEmpty)
                      ? AssetImage(driver.image!)
                      : null,
              child:
                  (driver.image == null || driver.image!.isEmpty)
                      ? Text(
                        driver.name.isNotEmpty
                            ? driver.name[0].toUpperCase()
                            : '?',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                      : null,
            ),

            SizedBox(width: size.width * 0.03),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name
                  Text(
                    driver.name,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: size.height * 0.002),

                  Row(
                    children: [
                      Container(
                        width: size.width * 0.02,
                        height: size.height * 0.02,
                        decoration: BoxDecoration(
                          color: _statusColor(),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        _statusText(),
                        style: TextStyle(
                          fontSize: 13,
                          color: _statusColor(),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  if (driver.clientInfo != null) ...[
                    SizedBox(height: size.height * 0.003),
                    Text(
                      driver.clientInfo!,
                      style: TextStyle(
                        fontSize: size.width * 0.03,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),

            Row(
              children: [
                InkWell(
                  onTap: () {
                    onMessage;
                  },
                  child: Image.asset(
                    'images/messageicon.png',
                    width: size.width * 0.06,
                    height: size.height * 0.06,
                  ),
                ),
                SizedBox(width: size.height * 0.01),
                InkWell(
                  onTap: () {
                    onCall;
                  },
                  child: Image.asset(
                    'images/callicon.png',
                    width: size.width * 0.04,
                    height: size.height * 0.04,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DriverFilterPanel extends StatefulWidget {
  const DriverFilterPanel({super.key});

  @override
  _DriverFilterPanelState createState() => _DriverFilterPanelState();
}

class _DriverFilterPanelState extends State<DriverFilterPanel> {
  String? selectedAvailability;
  String? selectedVehicle;

  final availabilityOptions = ['Available', 'On Trip', 'Scheduled', 'Offline'];
  final vehicleOptions = ['Sedan', 'SUV', 'Multi-Pax'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset('images/filtericon.png'),
              SizedBox(width: size.width * 0.015),
              Text(
                'Filter ',
                style: TextStyle(
                  fontSize: size.height * 0.028,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Status",
              style: TextStyle(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Center(
            child: Wrap(
              spacing: 5,
              runSpacing: 10,
              children:
                  availabilityOptions.map((option) {
                    final isSelected = option == selectedAvailability;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAvailability = option;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 2),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : Colors.white,
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          option,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montesserat',
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),

          SizedBox(height: size.height * 0.02),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Vehicle ",
              style: TextStyle(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Wrap(
              spacing: 5,
              runSpacing: 10,
              children:
                  vehicleOptions.map((option) {
                    final isSelected = option == selectedVehicle;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedVehicle = option;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 2),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : Colors.white,
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          option,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montesserat',
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
