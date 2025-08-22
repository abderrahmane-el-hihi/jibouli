import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:jibouli/models/order.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'token_storage.dart'; // Add this import

class ApiService {
  static const String baseUrl = 'https://jibouli.lvmanager.net/api';
  late Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'X-Client-Domain': 'jibouli-mobile',
        },
      ),
    );

    // Add logging for debugging
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true, error: true),
      );
    }

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add auth token if available
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('auth_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          // Set required headers
          options.headers['Accept'] = 'application/json';
          options.headers['Content-Type'] = 'application/json';

          // Try the domain header that should work
          options.headers['X-Client-Domain'] = 'https://jibouli.lvmanager.net';

          handler.next(options);
        },
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            _handleUnauthorized();
          }
          handler.next(error);
        },
      ),
    );
  }

  void _handleUnauthorized() {
    // TODO: Navigate to login screen
  }

  // Test connection method
  Future<bool> testConnection() async {
    try {
      final response = await _dio.get('/');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Login method - Fixed to handle the actual server response
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // Make the login request
      final response = await _dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );

      // Check if we got a successful response (status 200)
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;

        // Check if we have the required fields
        if (data['token'] != null && data['userId'] != null) {
          // Return success response in the format the app expects

          // TODO if  'role': data['role'] != 'delivery_person' it will show this account is not a delivery person

          return {
            'success': true,
            'token': data['token'],
            'user': {
              'id': data['userId'],
              'role': data['role'],
              'email': email, // Add email from the request
            },
            'message': 'Login successful',
          };
        } else {
          // Missing required fields
          return {
            'success': false,
            'message': 'Invalid response format from server',
            'error_code': 'INVALID_RESPONSE',
          };
        }
      } else {
        // Unexpected status code
        return {
          'success': false,
          'message': 'Unexpected response from server',
          'error_code': 'UNEXPECTED_RESPONSE',
        };
      }
    } catch (e) {
      // Handle DioException specifically
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;

        // Handle different error scenarios
        if (statusCode == 401) {
          return {
            'success': false,
            'message': 'Email ou mot de passe incorrect',
            'error_code': 'INVALID_CREDENTIALS',
          };
        } else if (statusCode == 422) {
          final errors = responseData?['errors'] ?? {};
          final errorMessage =
              errors.values.first?.first ?? 'Données invalides';
          return {
            'success': false,
            'message': errorMessage,
            'error_code': 'VALIDATION_ERROR',
          };
        } else if (statusCode == 500) {
          return {
            'success': false,
            'message': 'Erreur interne du serveur',
            'error_code': 'SERVER_ERROR',
          };
        } else if (responseData != null &&
            responseData['error'] == 'Unauthorized domain') {
          return {
            'success': false,
            'message': 'Domaine non autorisé',
            'error_code': 'UNAUTHORIZED_DOMAIN',
          };
        } else {
          return {
            'success': false,
            'message': 'Erreur de connexion: ${e.message}',
            'error_code': 'NETWORK_ERROR',
          };
        }
      }

      // Handle other exceptions
      return {
        'success': false,
        'message': 'Erreur inattendue: $e',
        'error_code': 'UNEXPECTED_ERROR',
      };
    }
  }

  // Rest of the methods...
  Future<Map<String, dynamic>> getDeliveryPersonInfo() async {
    try {
      final response = await _dio.get('/delivery/me');
      return response.data;
    } catch (e) {
      throw Exception('Failed to get delivery person info: $e');
    }
  }

  Future<bool> updateAvailability(bool isAvailable) async {
    try {
      await _dio.post(
        '/delivery/availability',
        data: {'available': isAvailable},
      );
      return true;
    } catch (e) {
      throw Exception('Failed to update availability: $e');
    }
  }

  // Get Pending Orders - Updated to handle real server data
  // Future<List<Order>> getPendingOrders() async {
  //   try {
  //     final response = await _dio.get('/orders/pending');

  //     List<dynamic> rawData;

  //     if (response.data is List) {
  //       rawData = response.data;
  //     } else {
  //       final data = response.data;
  //       rawData = data['data'] is List ? data['data'] : [];
  //     }

  //     // Convert to Order models here
  //     return rawData.map((json) => Order.fromJson(json)).toList();
  //   } catch (e) {
  //     throw Exception('Failed to get pending orders: $e');
  //   }
  // }
  // Add these variables to your ApiService class
  bool _isFirstLoad = true;
  List<Order> _previousOrders = [];

  Future<List<Order>> getPendingOrders({bool isPeriodicRefresh = false}) async {
    try {
      // Show loading only on first load, not on periodic refreshes
      if (_isFirstLoad && !isPeriodicRefresh) {
        _isFirstLoad = false;
      }

      final response = await _dio.get('/orders/pending');

      List<dynamic> rawData;

      if (response.data is List) {
        rawData = response.data;
      } else {
        final data = response.data;
        rawData = data['data'] is List ? data['data'] : [];
      }

      // Convert to Order models
      final List<Order> currentOrders = rawData
          .map((json) => Order.fromJson(json))
          .toList();

      // For periodic refreshes, only return new orders
      if (isPeriodicRefresh) {
        final newOrders = _findNewOrders(currentOrders, _previousOrders);
        _previousOrders = currentOrders; // Update previous orders
        return newOrders;
      } else {
        _previousOrders = currentOrders; // Store for future comparisons
        return currentOrders;
      }
    } catch (e) {
      // Don't throw on periodic refreshes to avoid breaking the stream
      if (!isPeriodicRefresh) {
        throw Exception('Failed to get pending orders: $e');
      }
      return []; // Return empty list on periodic refresh errors
    }
  }

  // Helper method to find new orders
  List<Order> _findNewOrders(
    List<Order> currentOrders,
    List<Order> previousOrders,
  ) {
    final currentIds = currentOrders.map((order) => order.id).toSet();
    final previousIds = previousOrders.map((order) => order.id).toSet();

    // Return only orders that are in current but not in previous
    return currentOrders
        .where((order) => !previousIds.contains(order.id))
        .toList();
  }

  Future<bool> acceptOrder(String orderId) async {
    try {
      await _dio.post('/orders/$orderId/accept');
      return true;
    } catch (e) {
      throw Exception('Failed to accept order: $e');
    }
  }

  Future<bool> rejectOrder(String orderId, String reason) async {
    try {
      await _dio.post('/order/$orderId/reject', data: {'reason': reason});
      return true;
    } catch (e) {
      throw Exception('Failed to reject order: $e');
    }
  }

  Future<bool> updateOrderStatus(
    String orderId,
    String status, {
    String? notes,
  }) async {
    try {
      await _dio.post(
        '/orders/$orderId/status',
        data: {'status': status, if (notes != null) 'notes': notes},
      );
      return true;
    } catch (e) {
      throw Exception('Failed to update order status: $e');
    }
  }

  Future<bool> createClient(String name, String phone, String address) async {
    try {
      await _dio.post(
        '/client',
        data: {'name': name, 'phone': phone, 'address': address},
      );
      return true;
    } catch (e) {
      throw Exception('Failed to create client: $e');
    }
  }

  Future<bool> sendLocationUpdate(double latitude, double longitude) async {
    try {
      await _dio.post(
        '/delivery/location',
        data: {
          'latitude': latitude,
          'longitude': longitude,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
      return true;
    } catch (e) {
      throw Exception('Failed to send location update: $e');
    }
  }

  Future<bool> stopLocationTracking() async {
    try {
      await _dio.post('/delivery/location/stop');
      return true;
    } catch (e) {
      throw Exception('Failed to stop location tracking: $e');
    }
  }

  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearToken() {
    _dio.options.headers.remove('Authorization');
  }

  Future<void> _restoreToken() async {
    final token = await TokenStorage.getToken();
    if (token != null) {
      setToken(token);
    }
  }
}
