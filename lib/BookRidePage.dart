import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart'; // Import the geocoding package
import 'package:latlong2/latlong.dart';

class BookRidePage extends StatefulWidget {
  const BookRidePage({super.key});

  @override
  _BookRidePageState createState() => _BookRidePageState();
}

class _BookRidePageState extends State<BookRidePage> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();

  LatLng? selectedPickupLocation =
      LatLng(9.9252, 78.1198); // Madurai coordinates
  LatLng? selectedDropoffLocation;

  bool isFullScreen = false;

  @override
  void dispose() {
    _pickupController.dispose();
    _dropoffController.dispose();
    super.dispose();
  }

  // Function to get place name from coordinates
  Future<void> _getPlaceName(
      LatLng location, TextEditingController controller) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String placeName = "${place.name}, ${place.locality}, ${place.country}";
        setState(() {
          controller.text = placeName;
        });
      }
    } catch (e) {
      setState(() {
        controller.text = 'Unknown location';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bike Tuk Tuk'),
        backgroundColor: Colors.yellow[600],
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Where would you like to go?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Pickup Location Input
            GestureDetector(
              onTap: () {
                if (selectedPickupLocation != null) {
                  _getPlaceName(selectedPickupLocation!, _pickupController);
                }
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _pickupController,
                  decoration: InputDecoration(
                    labelText: 'Pickup Location',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    prefixIcon: const Icon(Icons.location_on),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Dropoff Location Input
            GestureDetector(
              onTap: () {
                if (selectedDropoffLocation != null) {
                  _getPlaceName(selectedDropoffLocation!, _dropoffController);
                }
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _dropoffController,
                  decoration: InputDecoration(
                    labelText: 'Drop-off Location',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    prefixIcon: const Icon(Icons.pin_drop),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Map with marker to select locations
            Expanded(
              child: Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(9.9252, 78.1198), // Madurai default
                      initialZoom: 13, // Set the initial zoom level
                      onTap: (tapPosition, point) {
                        setState(() {
                          if (_pickupController.text.isEmpty) {
                            selectedPickupLocation = point;
                            _getPlaceName(point, _pickupController);
                          } else {
                            selectedDropoffLocation = point;
                            _getPlaceName(point, _dropoffController);
                          }
                        });
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      ),
                      MarkerLayer(
                        markers: [
                          if (selectedPickupLocation != null)
                            Marker(
                              point: selectedPickupLocation!,
                              width: 40,
                              height: 40,
                              child: const Icon(
                                Icons.location_on,
                                size: 40.0,
                                color: Colors.red,
                              ),
                            ),
                          if (selectedDropoffLocation != null)
                            Marker(
                              point: selectedDropoffLocation!,
                              width: 40,
                              height: 40,
                              child: const Icon(
                                Icons.pin_drop,
                                size: 40.0,
                                color: Colors.blue,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: IconButton(
                      icon: Icon(
                        isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                        size: 30,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          isFullScreen = !isFullScreen;
                          if (isFullScreen) {
                            // Enter fullscreen
                            Navigator.of(context)
                                .push(
                              MaterialPageRoute(
                                builder: (context) => FullScreenMap(
                                  initialLocation: LatLng(9.9252, 78.1198),
                                  pickupLocation: selectedPickupLocation,
                                  dropoffLocation: selectedDropoffLocation,
                                ),
                              ),
                            )
                                .then((value) {
                              setState(() {
                                isFullScreen =
                                    false; // Reset fullscreen state after returning
                              });
                            });
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Confirm Ride Button
            ElevatedButton.icon(
              onPressed: () {
                _showConfirmationDialog(context);
              },
              icon: const Icon(Icons.directions_bike),
              label: const Text('Confirm Ride'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                backgroundColor: Colors.limeAccent[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Ride'),
          content: const Text('Are you sure you want to confirm this ride?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
                _showSnackBar(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Your ride has been confirmed!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

// FullScreenMap widget
class FullScreenMap extends StatelessWidget {
  final LatLng initialLocation;
  final LatLng? pickupLocation;
  final LatLng? dropoffLocation;

  const FullScreenMap({
    Key? key,
    required this.initialLocation,
    this.pickupLocation,
    this.dropoffLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        backgroundColor: Colors.yellow[600],
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: initialLocation,
          initialZoom: 13,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(
            markers: [
              if (pickupLocation != null)
                Marker(
                  point: pickupLocation!,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.location_on,
                    size: 40.0,
                    color: Colors.red,
                  ),
                ),
              if (dropoffLocation != null)
                Marker(
                  point: dropoffLocation!,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.pin_drop,
                    size: 40.0,
                    color: Colors.blue,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
