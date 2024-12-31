// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:url_launcher/url_launcher.dart';

// class SosPage extends StatefulWidget {
//   @override
//   _SosPageState createState() => _SosPageState();
// }

// class _SosPageState extends State<SosPage> {
//   // List of predefined SOS messages
//   List<String> predefinedMessages = [
//     'Help! My location is: ',
//     'Emergency! I need help at: ',
//     'Please assist me! Location: ',
//   ];

//   // Selected message
//   String selectedMessage = '';

//   // List of emergency contacts
//   List<String> emergencyContacts = ['+1234567890', '+0987654321'];

//   // Function to get the current location
//   Future<String> getLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return 'Location services are disabled.';
//     }

//     // Check and request location permissions
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return 'Location permissions are denied.';
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return 'Location permissions are permanently denied.';
//     }

//     // Get the current position
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     return 'https://maps.google.com/?q=${position.latitude},${position.longitude}';
//   }

//   // Function to send an SOS message
//   void sendSOS() async {
//     // Request permissions
//     final smsStatus = await Permission.sms.request();
//     final locationStatus = await Permission.location.request();

//     if (smsStatus.isGranted && locationStatus.isGranted) {
//       // Get the user's current location
//       String locationLink = await getLocation();
//       String message = selectedMessage + locationLink;

//       // Create the SMS URI
//       final uri = Uri(
//         scheme: 'sms',
//         path: emergencyContacts.join(','), // Comma-separated recipients
//         queryParameters: {'body': message}, // Message body
//       );

//       // Debug: Log the generated URI
//       print('SMS URI: ${uri.toString()}');

//       // Launch the SMS app
//       if (await canLaunch(uri.toString())) {
//         await launch(uri.toString());
//       } else {
//         print('Could not launch SMS app. Please check your device settings.');
//       }
//     } else {
//       print('Permissions are not granted for SMS or location.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Send SOS'),
//         backgroundColor: const Color.fromARGB(255, 221, 218, 218),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Dropdown menu to choose a predefined message
//             DropdownButton<String>(
//               hint: Text('Select a message'),
//               value: selectedMessage.isEmpty ? null : selectedMessage,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedMessage = newValue!;
//                 });
//               },
//               items: predefinedMessages
//                   .map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 20),
//             // Button to send the selected SOS message
//             ElevatedButton(
//               onPressed: selectedMessage.isNotEmpty ? sendSOS : null,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color.fromARGB(255, 219, 216, 216),
//                 padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                 textStyle: TextStyle(fontSize: 18),
//               ),
//               child: Text('Send SOS'),
//             ),
//             SizedBox(height: 20),
//             // Additional info text
//             Text(
//               'Ensure SMS and location permissions are granted.',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 14, color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class SosPage extends StatefulWidget {
  @override
  _SosPageState createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {
  List<Map<String, String>> contacts = [];
  bool isLoading = false;
  TextEditingController _searchController = TextEditingController();
  String selectedMessage = 'Help! My location is: ';

  @override
  void initState() {
    super.initState();
    _loadEmergencyContacts();
  }

  // Fetch emergency contacts from the API
  Future<void> _loadEmergencyContacts() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'https://emergency-app-5.onrender.com/emergency-contacts/'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          contacts = data.map<Map<String, String>>((json) {
            return {
              'name': json['name'],
              'phone': json['phone'],
            };
          }).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Error fetching contacts: ${response.statusCode}');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching contacts: $error');
    }
  }

  // Function to launch the phone dialer with the given number
  // Future<void> _launchPhone(String phoneNumber) async {
  //   final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  //   if (await canLaunchUrl(phoneUri)) {
  //     await launchUrl(phoneUri);
  //   } else {
  //     print("Could not launch phone dialer.");
  //   }
  // }

  // Function to get the current location
  Future<String> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return 'Location services are disabled.';

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'Location permissions are denied.';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return 'Location permissions are permanently denied.';
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return 'https://maps.google.com/?q=${position.latitude},${position.longitude}';
  }

  // Function to send the SOS message
  Future<void> _sendSOS(String phoneNumber) async {
    final smsStatus = await Permission.sms.request();
    final locationStatus = await Permission.location.request();

    if (smsStatus.isGranted && locationStatus.isGranted) {
      String locationLink = await _getLocation();
      String message = '$selectedMessage $locationLink';

      final uri = Uri(
        scheme: 'sms',
        path: phoneNumber,
        queryParameters: {'body': message},
      );

      if (await canLaunch(uri.toString())) {
        await launch(uri.toString());
      } else {
        print('Could not send SMS. Please check your device settings.');
      }
    } else {
      print('Permissions are not granted for SMS or location.');
    }
  }

  // Function to filter contacts based on the search input
  void _onSearchChanged(String query) {
    setState(() {
      contacts = contacts
          .where((contact) =>
              contact['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOS Emergency'),
        backgroundColor: Colors.lightGreen, // Set AppBar color to green
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Contacts',
                border: OutlineInputBorder(),
                suffixIcon:
                    Icon(Icons.search, color: Colors.lightGreen), // Green icon
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(contacts[index]['name']!),
                        subtitle: Text('Emergency Contact'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(contacts[index]['phone']!),
                            IconButton(
                              icon: Icon(Icons.sms,
                                  color: Colors.lightGreen), // Green SMS icon
                              onPressed: () =>
                                  _sendSOS(contacts[index]['phone']!),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
