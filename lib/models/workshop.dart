// models/workshop.dart
class Workshop {
  final String id;
  final String name;
  final String category;
  final String skillLevel;
  final int maxParticipants;
  final double price;
  final String hostId;
  final String location;
  final DateTime dateTime;

  Workshop({
    required this.id,
    required this.name,
    required this.category,
    required this.skillLevel,
    required this.maxParticipants,
    required this.price,
    required this.hostId,
    required this.location,
    required this.dateTime,
  });

  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      skillLevel: json['skillLevel'],
      maxParticipants: json['maxParticipants'],
      price: json['price'].toDouble(),
      hostId: json['hostId'],
      location: json['location'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'skillLevel': skillLevel,
      'maxParticipants': maxParticipants,
      'price': price,
      'hostId': hostId,
      'location': location,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}