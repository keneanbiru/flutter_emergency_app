// class EmergencyContact {
//   String id;
//   String name;
//   String phoneNumber;
//   String relationship;

//   EmergencyContact({
//     required this.id,
//     required this.name,
//     required this.phoneNumber,
//     required this.relationship,
//   });

//   factory EmergencyContact.fromJson(Map<String, dynamic> json) {
//     return EmergencyContact(
//       id: json['_id'],
//       name: json['name'],
//       phoneNumber: json['phone_number'],
//       relationship: json['relationship'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'name': name,
//       'phone_number': phoneNumber,
//       'relationship': relationship,
//     };
//   }
// }

class EmergencyContact {
  String? id;
  String name;
  String phoneNumber;

  EmergencyContact({this.id, required this.name, required this.phoneNumber});

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      id: json['_id'],
      name: json['name'],
      phoneNumber: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // '_id': id,
      'name': name,
      'phone': phoneNumber,
    };
  }
}
