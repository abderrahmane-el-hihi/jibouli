import 'package:shared_preferences/shared_preferences.dart';
import 'token_storage.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();
  
  // Save token to storage
  Future<void> saveToken(String token) async {
    await TokenStorage.saveToken(
      token: token,
      userId: 0, // Will be updated when user data is available
      role: 'delivery_person', // Default role
    );
  }
  
  // Save user data to storage
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userData['id'] ?? 0);
    await prefs.setString('user_role', userData['role'] ?? 'delivery_person');
    await prefs.setString('user_email', userData['email'] ?? '');
  }

  // Login and store token
  Future<bool> login(String email, String password) async {
    try {
      final response = await _apiService.login(email, password);
      
      if (response['success'] == true) {
        // Store token and user info
        await TokenStorage.saveToken(
          token: response['token'],
          userId: response['userId'],
          role: response['role'],
        );
        
        // Update API service with new token
        _apiService.setToken(response['token']);
        return true;
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  // Check if user is already logged in
  Future<bool> isLoggedIn() async {
    return await TokenStorage.isLoggedIn();
  }

  // Get stored token
  Future<String?> getToken() async {
    return await TokenStorage.getToken();
  }

  // Logout and clear token
  Future<void> logout() async {
    await TokenStorage.clearToken();
    _apiService.clearToken();
  }

  // Auto-login if token exists
  Future<bool> autoLogin() async {
    final token = await getToken();
    if (token != null) {
      _apiService.setToken(token);
      return true;
    }
    return false;
  }
} 