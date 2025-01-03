// screens/profile/profile_screen.dart
import 'package:flutter/material.dart';
import '../../models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User user;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // In production, fetch from API
    user = User(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      phone: '+1234567890',
      bio: 'Passionate about learning new skills',
      interests: ['Art', 'Technology', 'Music'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _showEditProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildProfileInfo(),
            const SizedBox(height: 24),
            _buildInterests(),
            const SizedBox(height: 24),
            _buildSettings(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              user.name[0],
              style: const TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            user.email,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Me',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(user.bio),
            const SizedBox(height: 16),
            Text(
              'Contact',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.phone, size: 16),
                const SizedBox(width: 8),
                Text(user.phone),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterests() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Interests',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: user.interests.map((interest) {
                return Chip(
                  label: Text(interest),
                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettings() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // Implement notification settings
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Privacy Settings'),
            onTap: () {
              // Navigate to privacy settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Support'),
            onTap: () {
              // Navigate to help & support
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Implement logout
            },
          ),
        ],
      ),
    );
  }

  void _showEditProfile() {
    // Implement edit profile dialog
  }
}