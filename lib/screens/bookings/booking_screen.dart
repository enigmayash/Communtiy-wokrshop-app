// screens/bookings/bookings_screen.dart
import 'package:flutter/material.dart';
import '../../models/booking.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Bookings'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _BookingsList(bookings: _getUpcomingBookings()),
            _BookingsList(bookings: _getPastBookings()),
          ],
        ),
      ),
    );
  }

  List<Booking> _getUpcomingBookings() {
    // In production, fetch from API
    return [
      Booking(
        id: '1',
        workshopId: '1',
        workshopName: 'Digital Art Basics',
        dateTime: DateTime.now().add(const Duration(days: 2)),
        price: 49.99,
        status: BookingStatus.confirmed,
      ),
      // Add more bookings
    ];
  }

  List<Booking> _getPastBookings() {
    // In production, fetch from API
    return [
      Booking(
        id: '2',
        workshopId: '2',
        workshopName: 'Photography 101',
        dateTime: DateTime.now().subtract(const Duration(days: 5)),
        price: 39.99,
        status: BookingStatus.completed,
      ),
      // Add more bookings
    ];
  }
}

class _BookingsList extends StatelessWidget {
  final List<Booking> bookings;

  const _BookingsList({required this.bookings});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bookings.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return BookingCard(booking: bookings[index]);
      },
    );
  }
}

// screens/bookings/components/booking_card.dart
class BookingCard extends StatelessWidget {
  final Booking booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              booking.workshopName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  _formatDate(booking.dateTime),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${booking.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Chip(
                  label: Text(
                    booking.status.name.toUpperCase(),
                    style: TextStyle(
                      color: _getStatusColor(booking.status),
                    ),
                  ),
                  backgroundColor: _getStatusColor(booking.status).withOpacity(0.1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.confirmed:
        return Colors.green;
      case BookingStatus.completed:
        return Colors.blue;
      case BookingStatus.cancelled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}