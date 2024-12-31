// // import 'package:flutter/material.dart';
// // import 'package:emergency_app/screens/emergency_contact_service.dart';
// // import 'package:emergency_app/models/emergency_contact.dart';

// // class EmergencyContactPage extends StatefulWidget {
// //   @override
// //   _EmergencyContactPageState createState() => _EmergencyContactPageState();
// // }

// // class _EmergencyContactPageState extends State<EmergencyContactPage> {
// //   List<EmergencyContact> emergencyContacts = [];
// //   bool isLoading = true;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadEmergencyContacts();
// //   }

// //   Future<void> _loadEmergencyContacts() async {
// //     List<EmergencyContact> contacts = await EmergencyContactService()
// //         .fetchContacts(); // This method should return a list of EmergencyContact objects
// //     setState(() {
// //       emergencyContacts = contacts;
// //       isLoading = false;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Emergency Contacts'),
// //       ),
// //       body: isLoading
// //           ? Center(child: CircularProgressIndicator())
// //           : ListView.builder(
// //               itemCount: emergencyContacts.length,
// //               itemBuilder: (context, index) {
// //                 return ListTile(
// //                   title: Text(emergencyContacts[index].name),
// //                   subtitle: Text(emergencyContacts[index]
// //                       .phoneNumber), // Ensure the 'phone' field exists in EmergencyContact
// //                   trailing: IconButton(
// //                     icon: Icon(Icons.delete),
// //                     onPressed: () {
// //                       // Implement deletion logic here
// //                     },
// //                   ),
// //                 );
// //               },
// //             ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:emergency_app/screens/emergency_contact_service.dart';
// import 'package:emergency_app/models/emergency_contact.dart';

// class EmergencyContactPage extends StatefulWidget {
//   @override
//   _EmergencyContactPageState createState() => _EmergencyContactPageState();
// }

// class _EmergencyContactPageState extends State<EmergencyContactPage> {
//   List<EmergencyContact> emergencyContacts = [];
//   bool isLoading = true;

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _loadEmergencyContacts();
//   }

//   // Load all contacts from the backend
//   Future<void> _loadEmergencyContacts() async {
//     try {
//       List<EmergencyContact> contacts =
//           await EmergencyContactService().fetchContacts();
//       setState(() {
//         emergencyContacts = contacts;
//       });
//     } catch (error) {
//       _showErrorSnackBar("Failed to load contacts: $error");
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   // Add a new contact
//   Future<void> _addContact() async {
//     String name = nameController.text;
//     String phone = phoneController.text;

//     if (name.isEmpty || phone.isEmpty) {
//       _showErrorSnackBar("Name and phone cannot be empty");
//       return;
//     }

//     try {
//       EmergencyContact newContact =
//           EmergencyContact(name: name, phoneNumber: phone);
//       EmergencyContact addedContact =
//           await EmergencyContactService().createContact(newContact);

//       setState(() {
//         emergencyContacts.add(addedContact);
//       });

//       nameController.clear();
//       phoneController.clear();

//       _showSuccessSnackBar("Contact added successfully");
//     } catch (error) {
//       _showErrorSnackBar("Failed to add contact: $error");
//     }
//   }

//   // Delete a contact
//   Future<void> _deleteContact(String id) async {
//     try {
//       await EmergencyContactService().deleteContact(id);
//       setState(() {
//         emergencyContacts.removeWhere((contact) => contact.id == id);
//       });

//       _showSuccessSnackBar("Contact deleted successfully");
//     } catch (error) {
//       _showErrorSnackBar("Failed to delete contact: $error");
//     }
//   }

//   // Show success message
//   void _showSuccessSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message, style: TextStyle(color: Colors.green))),
//     );
//   }

//   // Show error message
//   void _showErrorSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message, style: TextStyle(color: Colors.red))),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Emergency Contacts'),
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       TextField(
//                         controller: nameController,
//                         decoration: InputDecoration(labelText: 'Contact Name'),
//                       ),
//                       SizedBox(height: 8),
//                       TextField(
//                         controller: phoneController,
//                         decoration: InputDecoration(labelText: 'Phone Number'),
//                         keyboardType: TextInputType.phone,
//                       ),
//                       SizedBox(height: 16),
//                       ElevatedButton(
//                         onPressed: _addContact,
//                         child: Text('Add Contact'),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: emergencyContacts.length,
//                     itemBuilder: (context, index) {
//                       final contact = emergencyContacts[index];
//                       return ListTile(
//                         title: Text(contact.name),
//                         subtitle: Text(contact.phoneNumber),
//                         trailing: IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () {
//                             print("Deleting contact with ID: ${contact.id}");
//                             if (contact.id != null) {
//                               _deleteContact(contact.id!);
//                             } else {
//                               _showErrorSnackBar("Invalid contact ID");
//                             }
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:emergency_app/screens/emergency_contact_service.dart';
import 'package:emergency_app/models/emergency_contact.dart';

class EmergencyContactPage extends StatefulWidget {
  @override
  _EmergencyContactPageState createState() => _EmergencyContactPageState();
}

class _EmergencyContactPageState extends State<EmergencyContactPage> {
  List<EmergencyContact> emergencyContacts = [];
  bool isLoading = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadEmergencyContacts();
  }

  Future<void> _loadEmergencyContacts() async {
    try {
      List<EmergencyContact> contacts =
          await EmergencyContactService().fetchContacts();
      setState(() {
        emergencyContacts = contacts;
      });
    } catch (error) {
      _showErrorSnackBar("Failed to load contacts: $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _addContact() async {
    String name = nameController.text;
    String phone = phoneController.text;

    if (name.isEmpty || phone.isEmpty) {
      _showErrorSnackBar("Name and phone cannot be empty");
      return;
    }

    try {
      EmergencyContact newContact =
          EmergencyContact(name: name, phoneNumber: phone);
      EmergencyContact addedContact =
          await EmergencyContactService().createContact(newContact);

      setState(() {
        emergencyContacts.add(addedContact);
      });

      nameController.clear();
      phoneController.clear();

      _showSuccessSnackBar("Contact added successfully");
    } catch (error) {
      _showErrorSnackBar("Contact added successfully: $error");
    }
  }

  Future<void> _deleteContact(String id) async {
    try {
      await EmergencyContactService().deleteContact(id);
      setState(() {
        emergencyContacts.removeWhere((contact) => contact.id == id);
      });

      _showSuccessSnackBar("Contact deleted successfully");
    } catch (error) {
      _showErrorSnackBar("Failed to delete contact: $error");
    }
  }

  Future<void> _callContact(String phoneNumber) async {
    final uri = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      _showErrorSnackBar("Cannot launch phone app");
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: TextStyle(color: Colors.green))),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message,
              style: TextStyle(color: const Color.fromARGB(255, 7, 7, 7)))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contacts'),
        backgroundColor: Colors.lightGreen,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: 'Contact Name'),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: phoneController,
                        decoration: InputDecoration(labelText: 'Phone Number'),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _addContact,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                        ),
                        child: Text('Add Contact'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: emergencyContacts.length,
                    itemBuilder: (context, index) {
                      final contact = emergencyContacts[index];
                      return ListTile(
                        title: Text(contact.name),
                        subtitle: Text(contact.phoneNumber),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.phone, color: Colors.lightGreen),
                              onPressed: () {
                                _callContact(contact.phoneNumber);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete,
                                  color:
                                      const Color.fromARGB(255, 54, 244, 70)),
                              onPressed: () {
                                if (contact.id != null) {
                                  _deleteContact(contact.id!);
                                } else {
                                  _showErrorSnackBar("Invalid contact ID");
                                }
                              },
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
