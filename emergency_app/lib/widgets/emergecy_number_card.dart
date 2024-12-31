import 'package:flutter/material.dart';
import '../models/emergency_number.dart';

class EmergencyNumberCard extends StatelessWidget {
  final EmergencyNumber emergencyNumber;

  EmergencyNumberCard({required this.emergencyNumber});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 5,
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        title: Text(
          emergencyNumber.country,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Text("Emergency Number: ${emergencyNumber.number}"),
            SizedBox(height: 5),
            Text("Description: ${emergencyNumber.description}"),
          ],
        ),
      ),
    );
  }
}
