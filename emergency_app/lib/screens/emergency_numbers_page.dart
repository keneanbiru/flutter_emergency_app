import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class EmergencyNumber {
  final String country;
  final String description;
  final String number;

  EmergencyNumber(
      {required this.country, required this.description, required this.number});

  factory EmergencyNumber.fromJson(Map<String, dynamic> json) {
    return EmergencyNumber(
      country: json['country'],
      description: json['description'],
      number: json['number'],
    );
  }
}

class EmergencyNumberListPage extends StatefulWidget {
  @override
  _EmergencyNumberListPageState createState() =>
      _EmergencyNumberListPageState();
}

class _EmergencyNumberListPageState extends State<EmergencyNumberListPage> {
  List<EmergencyNumber> emergencyNumbers = [];
  List<EmergencyNumber> filteredNumbers = [];
  bool isLoading = true;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadEmergencyNumbers();
  }

  Future<void> _loadEmergencyNumbers() async {
    try {
      final response = await http.get(
          Uri.parse('https://emergency-app-5.onrender.com/emergency-numbers/'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          emergencyNumbers =
              data.map((json) => EmergencyNumber.fromJson(json)).toList();
          filteredNumbers = emergencyNumbers;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Error fetching emergency numbers: ${response.statusCode}');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching emergency numbers: $error');
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      filteredNumbers = emergencyNumbers
          .where((number) =>
              number.country.toLowerCase().contains(query.toLowerCase()) ||
              number.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      print("Could not launch phone dialer.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Emergency Numbers',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: Container(
        color: Colors.white, // Pure white background
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search Emergency Numbers',
                  labelStyle: TextStyle(color: Colors.lightGreen),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightGreen),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightGreen),
                  ),
                  suffixIcon: Icon(Icons.search, color: Colors.lightGreen),
                ),
                style: TextStyle(color: Colors.black),
                onChanged: _onSearchChanged,
              ),
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(color: Colors.lightGreen))
                : Expanded(
                    child: ListView.builder(
                      itemCount: filteredNumbers.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors
                              .white, // Ensure white background for the card
                          elevation:
                              0, // Optional: Remove shadow for a flat look
                          child: ListTile(
                            title: Text(
                              filteredNumbers[index].country,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black, // Country name in black
                              ),
                            ),
                            subtitle: Text(
                              filteredNumbers[index].description,
                              style: TextStyle(color: Colors.black54),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  filteredNumbers[index].number,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.lightGreen,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.phone,
                                      color: Colors.lightGreen),
                                  onPressed: () => _launchPhone(
                                      filteredNumbers[index].number),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
