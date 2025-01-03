// services/auth_service.dart
import 'package:flutter/foundation.dart';
import '../models/user.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  Future<bool> signIn(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      _currentUser = User(
        id: 'user_123',
        name: 'John Doe',
        email: email,
        phone: '+1234567890',
        bio: 'Workshop enthusiast',
        interests: ['Art', 'Music', 'Technology'],
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    _currentUser = null;
    notifyListeners();
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      _currentUser = User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        email: email,
        phone: phone,
        bio: '',
        interests: [],
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateProfile({
    required String name,
    required String bio,
    required String phone,
    required List<String> interests,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      if (_currentUser != null) {
        _currentUser = User(
          id: _currentUser!.id,
          name: name,
          email: _currentUser!.email,
          phone: phone,
          bio: bio,
          interests: interests,
        );
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}