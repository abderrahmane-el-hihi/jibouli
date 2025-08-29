import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/order.dart';

class AppStateManager {
  static const String _activeOrderKey = 'active_order';
  
  /// Save active order to SharedPreferences
  Future<void> setActiveOrder(Order order) async {
    final prefs = await SharedPreferences.getInstance();
    final orderJson = jsonEncode(order.toJson());
    await prefs.setString(_activeOrderKey, orderJson);
  }
  
  /// Get active order from SharedPreferences
  Future<Order?> getActiveOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final orderJson = prefs.getString(_activeOrderKey);
    
    if (orderJson == null) return null;
    
    try {
      final orderMap = jsonDecode(orderJson);
      return Order.fromJson(orderMap);
    } catch (e) {
      // If there's an error parsing the order, clear it
      await clearActiveOrder();
      return null;
    }
  }
  
  /// Clear active order from SharedPreferences
  Future<void> clearActiveOrder() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_activeOrderKey);
  }
}