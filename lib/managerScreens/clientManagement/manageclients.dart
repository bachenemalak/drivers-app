import 'package:car_app/navBars/supervisorNavbar.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
class Manageclients extends StatefulWidget {
  const Manageclients({super.key});

  @override
  State<Manageclients> createState() => _manageclientsState();
}

class _manageclientsState extends State<Manageclients> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  List<QueryDocumentSnapshot> searchResults = [];
  bool isSearching = false;
  bool isSearchLoading = false;

  Future<void> searchClients(String query) async {
    if (query.isEmpty) {
      setState(() {
        isSearching = false;
        searchResults = [];
        isSearchLoading = false;
      });
      return;
    }

    setState(() {
      isSearching = true;
      isSearchLoading = true;
    });

    try {
      // Search ALL clients by name or phone
      final results = await FirebaseFirestore.instance
          .collection('clients')
          .get();

      final filtered = results.docs.where((client) {
        final data = client.data() as Map<String, dynamic>;
        final name = data['fullName']?.toString().toLowerCase() ?? '';
        final phone = data['phoneNumber']?.toString() ?? '';
        final searchLower = query.toLowerCase().trim();
        
        return name.contains(searchLower) || phone.contains(searchLower);
      }).toList();

      setState(() {
        searchResults = filtered;
        isSearchLoading = false;
      });
    } catch (e) {
      print('Search error: $e');
      setState(() {
        searchResults = [];
        isSearchLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int selectedIndex = 3;

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
                    'Manage clients',
                    style: TextStyle(
                      fontSize: size.height * 0.045,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: size.height * 0.06,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          searchClients(value);
                        },
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

              SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                    ),
                    child: Text(
                      'Recent',
                      style: TextStyle(
                        fontSize: size.height * 0.027,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
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
                        builder: (context) => const FractionallySizedBox(
                          heightFactor: 0.45,
                          child: DriverFilterPanel(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.02),

              Expanded(
                child: isSearching
                    ? isSearchLoading
                        ? Center(child: CircularProgressIndicator())
                        : searchResults.isEmpty
                            ? Center(child: Text('No clients found'))
                            : ListView.builder(
                                itemCount: searchResults.length,
                                itemBuilder: (context, idx) {
                                  final client = searchResults[idx];
                                  final data = client.data() as Map<String, dynamic>;
                                  final name = data['fullName'] ?? 'Unknown';
                                  return ClientCard(
                                    name: name,
                                    clientId: client.id,
                                  );
                                },
                              )
                    : StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('clients')
                            .orderBy('createdAt', descending: true)
                            .limit(20)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            return Center(child: Text('No clients found'));
                          }
                          final clients = snapshot.data!.docs;
                          return ListView.builder(
                            itemCount: clients.length,
                            itemBuilder: (context, idx) {
                              final client = clients[idx];
                              final data = client.data() as Map<String, dynamic>;
                              final name = data['fullName'] ?? 'Unknown';
                              return ClientCard(
                                name: name,
                                clientId: client.id,
                              );
                            },
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

class ClientCard extends StatelessWidget {
  final String name;
  final String clientId;

  const ClientCard({super.key, required this.name, required this.clientId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    // If clientId is null or empty, don't show the dots menu
    final hasValidId = clientId.isNotEmpty;
    
    return Container(
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
            radius: size.width * 0.06,
            backgroundColor: Colors.grey.shade200,
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: TextStyle(
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: Row(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                if (hasValidId) // Only show if clientId exists
                  DotsMenuOverlay(clientId: clientId),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class DriverCard extends StatelessWidget {
  final String name;

  const DriverCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
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
            radius: size.width * 0.06,
            backgroundColor: Colors.grey.shade200,
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: TextStyle(
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
          ),

          SizedBox(width: size.width * 0.03),

          Expanded(
            child: Row(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                DotsMenuOverlay(),
              ],
            ),
          ),
        ],
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
  String? selectedservice;
  String? selectedstatus;

  final serviceOptions = ['Point-to-point', 'Transfers', 'as Directed'];
  final statusOptions = ['Saved to directory', 'Unassigned'];

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
                'Filter',
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
              "Service",
              style: TextStyle(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Wrap(
            spacing: 3,
            runSpacing: 10,
            children:
                serviceOptions.map((option) {
                  final isSelected = option == selectedservice;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedservice = option;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
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
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),

          SizedBox(height: size.height * 0.02),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "status",
              style: TextStyle(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 5,
            runSpacing: 10,
            children:
                statusOptions.map((option) {
                  final isSelected = option == selectedstatus;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedstatus = option;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
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
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}

class DotsMenuOverlay extends StatefulWidget {
  final String ? clientId;
  
  const DotsMenuOverlay({super.key,  this.clientId});

  @override
  _DotsMenuOverlayState createState() => _DotsMenuOverlayState();
}

class _DotsMenuOverlayState extends State<DotsMenuOverlay> {
  OverlayEntry? _overlayEntry;

  void _showOverlay(BuildContext context) {
    if (_overlayEntry != null) return;

    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = MediaQuery.of(context).size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _hideOverlay,
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            top: offset.dy - 6,
            left: offset.dx - size.width * 0.3,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: size.width * 0.4,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 227, 221, 221),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => _hideOverlay(),
                          child: Text(
                            "Assign driver",
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.more_vert,
                          color: Colors.black,
                          size: size.width * 0.05,
                        ),
                      ],
                    ),
                    Divider(color: Color.fromARGB(172, 155, 149, 152)),
                    GestureDetector(
                     onTap: () {
  _hideOverlay();
  print('Navigating to client details with ID: ${widget.clientId}'); // Debug
  if (widget.clientId != null && widget.clientId!.isNotEmpty) {
    Get.toNamed('/clientsDetails', arguments: widget.clientId);
  } else {
    print('Client ID is null or empty!');
  }
},
                      child: Text(
                        "View trips",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                        ),
                      ),
                    ),
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

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => _overlayEntry == null ? _showOverlay(context) : _hideOverlay(),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Icon(
          Icons.more_vert,
          color: Colors.black,
          size: size.width * 0.05,
        ),
      ),
    );
  }
}
