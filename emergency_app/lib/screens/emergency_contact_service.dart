// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:emergency_app/models/emergency_contact.dart';
// import 'package:emergency_app/utils/constants.dart';

// class EmergencyContactService {
//   // Fetch all emergency contacts
//   Future<List<EmergencyContact>> fetchContacts() async {
//     final response =
//         await http.get(Uri.parse('${Constants.baseUrl}/emergency-contacts'));

//     if (response.statusCode == 200) {
//       List<dynamic> data = json.decode(response.body);
//       return data.map((contact) => EmergencyContact.fromJson(contact)).toList();
//     } else {
//       throw Exception('Failed to load contacts');
//     }
//   }

//   // Add a new emergency contact

//   // Update an existing emergency contact
//   Future<EmergencyContact> updateContact(EmergencyContact contact) async {
//     final response = await http.put(
//       Uri.parse('${Constants.baseUrl}/emergency-contacts/${contact.id}'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(contact.toJson()),
//     );

//     if (response.statusCode == 200) {
//       return EmergencyContact.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to update contact');
//     }
//   }

//   // Delete an emergency contact
//   Future<void> deleteContact(String id) async {
//     final response = await http.delete(
//       Uri.parse('${Constants.baseUrl}/emergency-contacts/$id'),
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Failed to delete contact');
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:emergency_app/models/emergency_contact.dart';

class EmergencyContactService {
  final String baseUrl =
      "https://emergency-app-5.onrender.com/emergency-contacts";

  // Fetch all contacts
  Future<List<EmergencyContact>> fetchContacts() async {
    final response = await http.get(Uri.parse('$baseUrl/'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((contact) => EmergencyContact.fromJson(contact)).toList();
    } else {
      throw Exception("Failed to fetch contacts");
    }
  }

  // Add a new contact
  // Future<EmergencyContact> createContact(EmergencyContact contact) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode(contact.toJson()),
  //   );

  //   if (response.statusCode == 201) {
  //     return EmergencyContact.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception("Failed to create contact");
  //   }
  // }

  Future<EmergencyContact> createContact(EmergencyContact contact) async {
    final response = await http.post(
      Uri.parse('$baseUrl/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(contact.toJson()),
    );

    if (response.statusCode == 201) {
      return EmergencyContact.fromJson(json.decode(response.body));
    } else {
      // Throw the error directly without a catch block
      throw Exception('Failed to add contact');
    }
  }

  // Delete a contact
  Future<void> deleteContact(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception("Failed to delete contact");
    }
  }
}
