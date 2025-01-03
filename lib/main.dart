// main.dart
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

void main() {
  runApp(const WorkshopApp());
}

class WorkshopApp extends StatelessWidget {
  const WorkshopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workshop Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  
  final List<Widget> _screens = [
    const HomeScreen(),
    const BookingsScreen(),
    const ProfileScreen(),
    const CommunityScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Platform.isIOS
          ? _buildIOSNavBar()
          : null,
      appBar: Platform.isAndroid
          ? _buildAndroidNavBar()
          : null,
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () => _showCreateWorkshopDialog(),
      ),
    );
  }

  Widget _buildIOSNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) => setState(() => _selectedIndex = index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Bookings'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Community'),
      ],
    );
  }

  PreferredSizeWidget _buildAndroidNavBar() {
    return AppBar(
      title: const Text('Workshop Booking'),
      bottom: TabBar(
        onTap: (index) => setState(() => _selectedIndex = index),
        tabs: const [
          Tab(icon: Icon(Icons.home), text: 'Home'),
          Tab(icon: Icon(Icons.book), text: 'Bookings'),
          Tab(icon: Icon(Icons.person), text: 'Profile'),
          Tab(icon: Icon(Icons.people), text: 'Community'),
        ],
      ),
    );
  }

  void _showCreateWorkshopDialog() {
    // Workshop creation dialog implementation
    showDialog(
      context: context,
      builder: (context) => const CreateWorkshopDialog(),
    );
  }
}