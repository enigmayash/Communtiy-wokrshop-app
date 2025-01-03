enum UserRole {
  participant,
  host,
  admin
}

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String bio;
  final List<String> interests;
  final String profileImageUrl;
  final UserRole role;
  final DateTime joinDate;
  final List<String> workshopsHosted;
  final List<String> workshopsAttended;
  final double rating;
  final Map<String, int> skillLevels;
  final bool isVerified;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.bio = '',
    this.interests = const [],
    this.profileImageUrl = '',
    this.role = UserRole.participant,
    required this.joinDate,
    this.workshopsHosted = const [],
    this.workshopsAttended = const [],
    this.rating = 0.0,
    this.skillLevels = const {},
    this.isVerified = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      bio: json['bio'] ?? '',
      interests: List<String>.from(json['interests'] ?? []),
      profileImageUrl: json['profileImageUrl'] ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.toString() == 'UserRole.${json['role']}',
        orElse: () => UserRole.participant,
      ),
      joinDate: DateTime.parse(json['joinDate']),
      workshopsHosted: List<String>.from(json['workshopsHosted'] ?? []),
      workshopsAttended: List<String>.from(json['workshopsAttended'] ?? []),
      rating: json['rating']?.toDouble() ?? 0.0,
      skillLevels: Map<String, int>.from(json['skillLevels'] ?? {}),
      isVerified: json['isVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'bio': bio,
      'interests': interests,
      'profileImageUrl': profileImageUrl,
      'role': role.toString().split('.').last,
      'joinDate': joinDate.toIso8601String(),
      'workshopsHosted': workshopsHosted,
      'workshopsAttended': workshopsAttended,
      'rating': rating,
      'skillLevels': skillLevels,
      'isVerified': isVerified,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? bio,
    List<String>? interests,
    String? profileImageUrl,
    UserRole? role,
    DateTime? joinDate,
    List<String>? workshopsHosted,
    List<String>? workshopsAttended,
    double? rating,
    Map<String, int>? skillLevels,
    bool? isVerified,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      interests: interests ?? this.interests,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      role: role ?? this.role,
      joinDate: joinDate ?? this.joinDate,
      workshopsHosted: workshopsHosted ?? this.workshopsHosted,
      workshopsAttended: workshopsAttended ?? this.workshopsAttended,
      rating: rating ?? this.rating,
      skillLevels: skillLevels ?? this.skillLevels,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
