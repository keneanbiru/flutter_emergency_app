import 'package:flutter/material.dart';
import 'package:emergency_app/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emergency App',
      // theme: ThemeData(
      //   primarySwatch: Colors.lightGreen,
      // ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false, // Disable debug banner
//       home: EmergencyConnect(),
//     );
//   }
// }

// class EmergencyConnect extends StatefulWidget {
//   const EmergencyConnect({super.key});

//   @override
//   _EmergencyConnectState createState() => _EmergencyConnectState();
// }

// class _EmergencyConnectState extends State<EmergencyConnect> {
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

//   // Function to request permissions
//   Future<void> requestPermissions() async {
//     // Request SMS and location permissions
//     await Permission.sms.request();
//     await Permission.location.request();
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
//         title: Text('Emergency Connect'),
//         centerTitle: true,
//         backgroundColor: Colors.redAccent,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Dropdown menu to choose a predefined message
//               DropdownButton<String>(
//                 hint: Text('Select a message'),
//                 value: selectedMessage.isEmpty ? null : selectedMessage,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedMessage = newValue!;
//                   });
//                 },
//                 items: predefinedMessages
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),

//               SizedBox(height: 20),

//               // Button to send the selected SOS message
//               ElevatedButton(
//                 onPressed: selectedMessage.isNotEmpty ? sendSOS : null,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.redAccent,
//                   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                   textStyle: TextStyle(fontSize: 18),
//                 ),
//                 child: Text('Send SOS'),
//               ),

//               SizedBox(height: 20),

//               // Additional info text
//               Text(
//                 'Ensure SMS and location permissions are granted.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 14, color: Colors.grey),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
