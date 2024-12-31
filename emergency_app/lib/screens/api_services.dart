import 'dart:convert';
import 'package:emergency_app/models/emergency_number.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://keneanbackende.onrender.com'; // Replace with your backend URL
  static const String userId = '10'; // ID for the single user

  // Get all emergency numbers
  Future<List<EmergencyNumber>> getEmergencyNumbers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/emergency-numbers/'));

      if (response.statusCode == 200) {
        List<EmergencyNumber> emergencyNumbers = json.decode(response.body);
        return emergencyNumbers;
      } else {
        throw Exception('Failed to load emergency numbers');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Search emergency numbers by country or description
  Future<List<dynamic>> searchEmergencyNumbers(String query) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/emergency-numbers/search?query=$query'));

      if (response.statusCode == 200) {
        List<dynamic> emergencyNumbers = json.decode(response.body);
        return emergencyNumbers;
      } else {
        throw Exception('Failed to search emergency numbers');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get emergency contacts (for the single user)
  Future<List<dynamic>> getEmergencyContacts() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/emergency-contacts/'));

      if (response.statusCode == 200) {
        List<dynamic> contacts = json.decode(response.body);
        return contacts;
      } else {
        throw Exception('Failed to load emergency contacts');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Add new emergency contact (for the single user)
  Future<String> addEmergencyContact(Map<String, String> contactData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/emergency-contacts/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(contactData),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body)['id'];
      } else {
        throw Exception('Failed to add emergency contact');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Update an emergency contact (for the single user)
  Future<bool> updateEmergencyContact(
      String contactId, Map<String, String> contactData) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/emergency-contacts/$contactId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(contactData),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update emergency contact');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Delete an emergency contact (for the single user)
  Future<bool> deleteEmergencyContact(String contactId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/emergency-contacts/$contactId'),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete emergency contact');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
