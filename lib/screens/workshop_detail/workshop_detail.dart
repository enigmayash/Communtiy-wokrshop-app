// screens/workshop_detail/workshop_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class WorkshopDetailScreen extends StatelessWidget {
  final Workshop workshop;
  final Map<String, String> deviceInfo;
  final Position location;

  const WorkshopDetailScreen({
    super.key,
    required this.workshop,
    required this.deviceInfo,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workshop.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoSection('Workshop Details', [
              'Category: ${workshop.category}',
              'Skill Level: ${workshop.skillLevel}',
              'Maximum Participants: ${workshop.maxParticipants}',
              'Price: \$${workshop.price.toStringAsFixed(2)}',
              'Date: ${_formatDateTime(workshop.dateTime)}',
            ]),
            const SizedBox(height: 20),
            _buildInfoSection('Device Information', [
              'Model: ${deviceInfo['model']}',
              'Make: ${deviceInfo['make']}',
              'Screen Size: ${deviceInfo['screen']}',
            ]),
            const SizedBox(height: 20),
            _buildInfoSection('Location Information', [
              'Latitude: ${location.latitude.toStringAsFixed(4)}',
              'Longitude: ${location.longitude.toStringAsFixed(4)}',
            ]),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () => _initiateBooking(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                child: const Text('Book Workshop'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, List<String> details) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...details.map((detail) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(detail),
                )),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} '
        '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _initiateBooking(BuildContext context) {
    final paymentService = PaymentService();
    // In production, get these details from user profile
    paymentService.initiatePayment(
      workshopId: workshop.id,
      amount: workshop.price,
      currency: 'USD',
      email: 'user@example.com',
      contact: '+1234567890',
    );
  }
}