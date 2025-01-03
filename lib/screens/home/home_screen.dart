// screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Workshop> workshops = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: const ScrollingBanner(),
        ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: workshops.length,
            itemBuilder: (context, index) {
              return WorkshopCard(
                workshop: workshops[index],
                onTap: () => _navigateToWorkshopDetail(workshops[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _navigateToWorkshopDetail(Workshop workshop) async {
    final deviceInfo = await _getDeviceInfo();
    final position = await _getCurrentLocation();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkshopDetailScreen(
          workshop: workshop,
          deviceInfo: deviceInfo,
          location: position,
        ),
      ),
    );
  }

  Future<Map<String, String>> _getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    return {
      'model': deviceInfo.data['model'] ?? 'Unknown',
      'make': deviceInfo.data['manufacturer'] ?? 'Unknown',
      'screen': '${MediaQuery.of(context).size.width.toStringAsFixed(0)}x'
          '${MediaQuery.of(context).size.height.toStringAsFixed(0)}',
    };
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}

class ScrollingBanner extends StatelessWidget {
  const ScrollingBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.8,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.blue.shade100,
          ),
          child: Center(
            child: Text('Trending Workshop ${index + 1}'),
          ),
        );
      },
    );
  }
}