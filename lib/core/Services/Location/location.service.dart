import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    debugPrint("permission");

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    debugPrint("serviceEnabled $serviceEnabled");

    if (!serviceEnabled) {
      // Location services are not enabled
      return false;
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    debugPrint("permission: $permission");
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Location permissions are denied
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      return false;
    }

    // Permissions are granted
    return true;
  }

  Future<Position?> getCurrentPosition() async {
    bool hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      return null;
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<String?> getCurrentCity() async {
    Position? position = await getCurrentPosition();

    if (position == null) {
      return null;
    }

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      return placemarks.first.locality;
    }

    return null;
  }
}
