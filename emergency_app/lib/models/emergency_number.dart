class EmergencyNumber {
  String id;
  String country;
  String number;
  String description;

  EmergencyNumber({
    required this.id,
    required this.country,
    required this.number,
    required this.description,
  });

  factory EmergencyNumber.fromJson(Map<String, dynamic> json) {
    return EmergencyNumber(
      id: json['_id'],
      country: json['country'],
      number: json['number'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'country': country,
      'number': number,
      'description': description,
    };
  }
}
