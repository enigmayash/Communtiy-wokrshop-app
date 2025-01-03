// services/workshop_service.dart
import 'package:flutter/foundation.dart';
import '../models/workshop.dart';

class WorkshopService extends ChangeNotifier {
  List<Workshop> _workshops = [];
  bool _isLoading = false;

  List<Workshop> get workshops => _workshops;
  bool get isLoading => _isLoading;

  Future<void> fetchWorkshops() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      _workshops = [
        Workshop(
          id: '1',
          name: 'Digital Art Basics',
          category: 'Art',
          skillLevel: 'Beginner',
          maxParticipants: 15,
          price: 49.99,
          hostId: 'host_1',
          location: 'Online',
          dateTime: DateTime.now().add(const Duration(days: 7)),
        ),
        Workshop(
          id: '2',
          name: 'Advanced Web Development',
          category: 'Technology',
          skillLevel: 'Advanced',
          maxParticipants: 10,
          price: 99.99,
          hostId: 'host_2',
          location: 'Tech Hub, Downtown',
          dateTime: DateTime.now().add(const Duration(days: 14)),
        ),
        // Add more sample workshops
      ];

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<Workshop> createWorkshop(Workshop workshop) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      _workshops.add(workshop);

      _isLoading = false;
      notifyListeners();
      return workshop;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteWorkshop(String workshopId) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      _workshops.removeWhere((workshop) => workshop.id == workshopId);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<Workshop?> getWorkshopById(String workshopId) async {
    try {
      return _workshops.firstWhere((workshop) => workshop.id == workshopId);
    } catch (e) {
      return null;
    }
  }
}