import 'package:flutter/material.dart';

class ManageDriversScreen extends StatelessWidget {
  const ManageDriversScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(height: size.height * 0.025),
              
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
              
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0D000000), // #0000000D
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.asset(
                            'images/car.png',
                            height: size.width * 0.3,
                          ),
                        ),
                        DotsMenuOverlay(),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      children: [
                        Text(
                          'Class:',
                          style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Text(
                          ' SUV',
                          style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Type: ',
                          style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Text(
                          'Cadillac Escalade',
                          style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Plate Number: ',
                          style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Text(
                          '8JXW321',
                          style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: size.height * 0.01),
              
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x0D000000), // #0000000D
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(radius: 24),
                            SizedBox(height: 8),
                            Text(
                              'Chourouk Ba',
                              style: TextStyle(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            SizedBox(height: size.height * 0.002),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.phone_outlined,
                                  size: size.width * 0.03,
                                ),
                                Text(
                                  '+213 77389069',
                                  style: TextStyle(
                                    fontSize: size.width * 0.027,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.mail_outline,
                                  size: size.width * 0.03,
                                ),
                                Text(
                                  ' chourouk@gmail.com',
                                  style: TextStyle(
                                    fontSize: size.width * 0.027,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x0D000000), // #0000000D
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
              
                        child: const Center(
                          child: Icon(Icons.map, size: 30, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: size.height * 0.02),
              
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF202020),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ImageIcon(
                            AssetImage('images/license.png'),
                            size: size.height * 0.02,
                            color: Colors.white,
                          ),
              
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              splashFactory: NoSplash.splashFactory,
                            ),
                            child: Text(
                              "  View Driver's License",
                              style: TextStyle(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: size.height * 0.02,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    _Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ImageIcon(
                            AssetImage('images/insurance.png'),
                            size: size.height * 0.02,
                            color: Colors.white,
                          ),
              
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              splashFactory: NoSplash.splashFactory,
                            ),
                            child: Text(
                              "  View Insurance Document",
                              style: TextStyle(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: size.height * 0.02,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
              
                    _Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ImageIcon(
                            AssetImage('images/registration.png'),
                            size: size.height * 0.02,
                            color: Colors.white,
                          ),
              
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              splashFactory: NoSplash.splashFactory,
                            ),
                            child: Text(
                              "  View Vehicle Registration",
                              style: TextStyle(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: size.height * 0.02,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              
              Row(
                children: [
                  SizedBox(width: size.width * 0.03),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF202020),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Assign Driver',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'images/chaticon.png',
                      width: size.height * 0.04,
                      height: size.height * 0.04,
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'images/ion_call.png',
                      width: size.height * 0.03,
                      height: size.height * 0.03,
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(color: Colors.white24, height: 1);
  }
}

class DotsMenuOverlay extends StatefulWidget {
  const DotsMenuOverlay({super.key});

  @override
  _DotsMenuOverlayState createState() => _DotsMenuOverlayState();
}

class _DotsMenuOverlayState extends State<DotsMenuOverlay> {
  OverlayEntry? _overlayEntry;

  void _showOverlay(BuildContext context) {
    if (_overlayEntry != null) return;

    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final box = MediaQuery.of(context).size;

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: _hideOverlay,
                  child: Container(color: Colors.transparent),
                ),
              ),

              Positioned(
                top: offset.dy,
                right:
                    MediaQuery.of(context).size.width - offset.dx - size.width,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: box.width * 0.55,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.more_vert,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {},

                            child: Text(
                              "  View Ongoing Trip",
                              style: TextStyle(
                                fontSize: size.height * 0.35,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: _divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {},

                            child: Text(
                              "  Set driver on a break",
                              style: TextStyle(
                                fontSize: size.height * 0.35,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: _divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {},

                            child: Text(
                              "  Remove Driver",
                              style: TextStyle(
                                fontSize: size.height * 0.35,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Widget _divider() =>
      const Divider(color: Colors.white24, height: 1, thickness: 1);

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_overlayEntry == null) {
          _showOverlay(context);
        } else {
          _hideOverlay();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: const Icon(Icons.more_vert, color: Colors.black, size: 24),
      ),
    );
  }
}
