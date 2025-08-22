import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'api_service.dart';

class LocationService {
  final ApiService _apiService = ApiService();
  bool _isTracking = false;

  // Request location permissions
  Future<bool> requestPermissions() async {
    final locationStatus = await Permission.location.request();
    final locationAlwaysStatus = await Permission.locationAlways.request();

    return locationStatus.isGranted && locationAlwaysStatus.isGranted;
  }

  // Check if location services are enabled
  Future<bool> isLocationEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // Start location tracking
  Future<void> startTracking() async {
    if (!await requestPermissions()) {
      throw Exception('Location permissions not granted');
    }

    if (!await isLocationEnabled()) {
      throw Exception('Location services not enabled');
    }

    _isTracking = true;

    // Start periodic location updates
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Update every 10 meters
      ),
    ).listen((Position position) {
      if (_isTracking) {
        _sendLocationUpdate(position.latitude, position.longitude);
      }
    });
  }

  // Stop location tracking
  Future<void> stopTracking() async {
    _isTracking = false;
    try {
      await _apiService.stopLocationTracking();
    } catch (e) {
      // Handle error
    }
  }

  // Send location update to API
  Future<void> _sendLocationUpdate(double latitude, double longitude) async {
    try {
      await _apiService.sendLocationUpdate(latitude, longitude);
    } catch (e) {
      // Queue for later sync if offline
      _queueLocationUpdate(latitude, longitude);
    }
  }

  // Queue location update for offline sync
  void _queueLocationUpdate(double latitude, double longitude) {
    // TODO: Implement offline queue
  }

  // Get current position
  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
