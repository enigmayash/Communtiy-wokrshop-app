enum BookingStatus {
  pending,
  confirmed,
  cancelled,
  completed,
  refunded
}

enum PaymentStatus {
  pending,
  completed,
  failed,
  refunded
}

class Booking {
  final String id;
  final String workshopId;
  final String userId;
  final DateTime bookingDate;
  final BookingStatus status;
  final PaymentStatus paymentStatus;
  final double amount;
  final String transactionId;
  final bool isRated;
  final double? rating;
  final String? review;
  final Map<String, dynamic> paymentDetails;
  final Map<String, dynamic> metadata;

  Booking({
    required this.id,
    required this.workshopId,
    required this.userId,
    required this.bookingDate,
    this.status = BookingStatus.pending,
    this.paymentStatus = PaymentStatus.pending,
    required this.amount,
    required this.transactionId,
    this.isRated = false,
    this.rating,
    this.review,
    this.paymentDetails = const {},
    this.metadata = const {},
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      workshopId: json['workshopId'],
      userId: json['userId'],
      bookingDate: DateTime.parse(json['bookingDate']),
      status: BookingStatus.values.firstWhere(
        (e) => e.toString() == 'BookingStatus.${json['status']}',
        orElse: () => BookingStatus.pending,
      ),
      paymentStatus: PaymentStatus.values.firstWhere(
        (e) => e.toString() == 'PaymentStatus.${json['paymentStatus']}',
        orElse: () => PaymentStatus.pending,
      ),
      amount: json['amount'].toDouble(),
      transactionId: json['transactionId'],
      isRated: json['isRated'] ?? false,
      rating: json['rating']?.toDouble(),
      review: json['review'],
      paymentDetails: Map<String, dynamic>.from(json['paymentDetails'] ?? {}),
      metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workshopId': workshopId,
      'userId': userId,
      'bookingDate': bookingDate.toIso8601String(),
      'status': status.toString().split('.').last,
      'paymentStatus': paymentStatus.toString().split('.').last,
      'amount': amount,
      'transactionId': transactionId,
      'isRated': isRated,
      'rating': rating,
      'review': review,
      'paymentDetails': paymentDetails,
      'metadata': metadata,
    };
  }

  Booking copyWith({
    String? id,
    String? workshopId,
    String? userId,
    DateTime? bookingDate,
    BookingStatus? status,
    PaymentStatus? paymentStatus,
    double? amount,
    String? transactionId,
    bool? isRated,
    double? rating,
    String? review,
    Map<String, dynamic>? paymentDetails,
    Map<String, dynamic>? metadata,
  }) {
    return Booking(
      id: id ?? this.id,
      workshopId: workshopId ?? this.workshopId,
      userId: userId ?? this.userId,
      bookingDate: bookingDate ?? this.bookingDate,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      amount: amount ?? this.amount,
      transactionId: transactionId ?? this.transactionId,
      isRated: isRated ?? this.isRated,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      paymentDetails: paymentDetails ?? this.paymentDetails,
      metadata: metadata ?? this.metadata,
    );
  }
}