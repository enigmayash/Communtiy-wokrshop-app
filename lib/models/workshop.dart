
enum WorkshopStatus {
  upcoming,
  inProgress,
  completed,
  cancelled
}

class Workshop {
  final String id;
  final String name;
  final String description;
  final String category;
  final String skillLevel;
  final int maxParticipants;
  final double price;
  final String hostId;
  final String location;
  final DateTime dateTime;
  final Duration duration;
  final WorkshopStatus status;
  final List<String> requirements;
  final List<String> materials;
  final String coverImageUrl;
  final int currentParticipants;
  final double rating;
  final List<String> tags;

  Workshop({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.skillLevel,
    required this.maxParticipants,
    required this.price,
    required this.hostId,
    required this.location,
    required this.dateTime,
    required this.duration,
    this.status = WorkshopStatus.upcoming,
    this.requirements = const [],
    this.materials = const [],
    this.coverImageUrl = '',
    this.currentParticipants = 0,
    this.rating = 0.0,
    this.tags = const [],
  });

  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      skillLevel: json['skillLevel'],
      maxParticipants: json['maxParticipants'],
      price: json['price'].toDouble(),
      hostId: json['hostId'],
      location: json['location'],
      dateTime: DateTime.parse(json['dateTime']),
      duration: Duration(minutes: json['durationMinutes']),
      status: WorkshopStatus.values.firstWhere(
        (e) => e.toString() == 'WorkshopStatus.${json['status']}',
        orElse: () => WorkshopStatus.upcoming,
      ),
      requirements: List<String>.from(json['requirements'] ?? []),
      materials: List<String>.from(json['materials'] ?? []),
      coverImageUrl: json['coverImageUrl'] ?? '',
      currentParticipants: json['currentParticipants'] ?? 0,
      rating: json['rating']?.toDouble() ?? 0.0,
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'skillLevel': skillLevel,
      'maxParticipants': maxParticipants,
      'price': price,
      'hostId': hostId,
      'location': location,
      'dateTime': dateTime.toIso8601String(),
      'durationMinutes': duration.inMinutes,
      'status': status.toString().split('.').last,
      'requirements': requirements,
      'materials': materials,
      'coverImageUrl': coverImageUrl,
      'currentParticipants': currentParticipants,
      'rating': rating,
      'tags': tags,
    };
  }

  Workshop copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? skillLevel,
    int? maxParticipants,
    double? price,
    String? hostId,
    String? location,
    DateTime? dateTime,
    Duration? duration,
    WorkshopStatus? status,
    List<String>? requirements,
    List<String>? materials,
    String? coverImageUrl,
    int? currentParticipants,
    double? rating,
    List<String>? tags,
  }) {
    return Workshop(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      skillLevel: skillLevel ?? this.skillLevel,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      price: price ?? this.price,
      hostId: hostId ?? this.hostId,
      location: location ?? this.location,
      dateTime: dateTime ?? this.dateTime,
      duration: duration ?? this.duration,
      status: status ?? this.status,
      requirements: requirements ?? this.requirements,
      materials: materials ?? this.materials,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      currentParticipants: currentParticipants ?? this.currentParticipants,
      rating: rating ?? this.rating,
      tags: tags ?? this.tags,
    );
  }
}