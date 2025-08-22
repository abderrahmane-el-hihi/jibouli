// periodic_refresh_service.dart
import 'dart:async';
import '../models/order.dart';
import '../services/api_service.dart';

class PeriodicRefreshService {
  // final ApiService _apiService = ApiService();
  final ApiService _apiService;
  final StreamController<List<Order>> _ordersStreamController =
      StreamController<List<Order>>.broadcast();
  Timer? _refreshTimer;
  bool _isRunning = false;

  PeriodicRefreshService(this._apiService);
  Stream<List<Order>> get ordersStream => _ordersStreamController.stream;

  // Start periodic refresh
  void startPeriodicRefresh() {
    if (_isRunning) return;

    _isRunning = true;

    // Initial fetch
    _fetchOrders();

    // Set up periodic timer
    _refreshTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _fetchOrders(isPeriodic: true);
    });
  }

  // Stop periodic refresh
  void stopPeriodicRefresh() {
    _refreshTimer?.cancel();
    _isRunning = false;
  }

  // Fetch orders
  Future<void> _fetchOrders({bool isPeriodic = false}) async {
    try {
      final orders = await _apiService.getPendingOrders(
        isPeriodicRefresh: isPeriodic,
      );

      if (orders.isNotEmpty) {
        _ordersStreamController.add(orders);
      }
    } catch (e) {
      print('Periodic fetch error: $e');
      // Don't add to stream on error for periodic refreshes
    }
  }

  // Dispose
  void dispose() {
    stopPeriodicRefresh();
    _ordersStreamController.close();
  }
}
