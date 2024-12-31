import 'package:flutter/material.dart';
import 'package:emergency_app/screens/emergency_numbers_page.dart';
import 'package:emergency_app/screens/emergency_contacts_page.dart';
import 'package:emergency_app/screens/sos_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Emergency App',
          style: TextStyle(color: Colors.black), // White AppBar text
        ),
        backgroundColor: Colors.lightGreen, // LightGreen AppBar
        iconTheme: IconThemeData(color: Colors.white), // Ensure icons are white
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.lightGreen],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.white, // White icon color
                  size: 150, // Adjust size of the icon
                ),
                SizedBox(height: 26), // Space between icon and welcome message
                Text(
                  'Welcome to the Emergency App!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Stay prepared and stay safe. Access emergency features at your fingertips.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32), // Space before buttons

                ElevatedButton(
                  onPressed: () {
                    // Navigate to the Emergency Numbers page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmergencyNumberListPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen, // LightGreen button
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    'Emergency Numbers',
                    style: TextStyle(color: Colors.white), // White text
                  ),
                ),
                SizedBox(height: 8), // Space between button and description
                Text(
                  'View a list of important emergency numbers.',
                  style: TextStyle(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16), // Space between buttons

                ElevatedButton(
                  onPressed: () {
                    // Navigate to the Emergency Contacts page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmergencyContactPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen, // LightGreen button
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    'Emergency Contacts',
                    style: TextStyle(color: Colors.white), // White text
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Manage and access your emergency contacts.',
                  style: TextStyle(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {
                    // Navigate to the SOS page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SosPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen, // LightGreen button
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    'SOS',
                    style: TextStyle(color: Colors.white), // White text
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Send an SOS alert with your location.',
                  style: TextStyle(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
