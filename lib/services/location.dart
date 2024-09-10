import 'package:geolocator/geolocator.dart';

class Location {
  late bool serviceEnabled;
  late LocationPermission permission;
  double? latitude; // Nullable variables to store latitude
  double? longitude; // Nullable variables to store longitude

  Future<void> getCurrentLocation() async {
    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return Future.error('Location services are disabled.');
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When permission is granted, get the location
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.low,
        distanceFilter: 100,
      ),
    );

    // Store latitude and longitude
    latitude = position.latitude;
    longitude = position.longitude;

    // print('Latitude: $latitude, Longitude: $longitude');
  }
}
