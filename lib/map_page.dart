import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        backgroundColor: Colors.lime[700],
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(51.5, -0.09), // Set initial center location
          initialZoom: 13.0,
          onTap: (tapPosition, latLng) {
            // Return the selected location to the previous screen
            Navigator.pop(context, latLng);
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
        ],
      ),
    );
  }
}
