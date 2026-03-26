import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const Navbar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    // List of image asset paths (hardcoded inside the widget)
    final List<String> iconPaths = [
      'images/homenav.png',
      'images/carnav.png',
      'images/notifnav.png',
      'images/profilenav.png',
    ];

    return Container(
      height: 65,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          iconPaths.length,
          (index) => GestureDetector(
            onTap: () {
              onItemTapped(index);
              // Empty click handlers - you can add navigation later
              switch (index) {
                case 0:
                  Navigator.pushNamed(context, '/driverHomeScreen');
                  break;
                case 1:
                  Navigator.pushNamed(context, '/manageTrips');
                  break;
                case 2:
                  Navigator.pushNamed(context, '/driverNotificaations');
                  break;
                case 3:
                  Navigator.pushNamed(context, '/driverProfile');
                  break;
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:
                    selectedIndex == index
                        ? Colors.grey.shade300
                        : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                iconPaths[index],
                width: 24,
                height: 24,
                color: selectedIndex == index ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
