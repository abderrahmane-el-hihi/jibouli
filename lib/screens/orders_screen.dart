import 'package:flutter/material.dart';
import '../models/order.dart';
import '../models/client.dart';
import '../widgets/order_card.dart';
import '../widgets/header_section.dart';
import '../widgets/client_modal.dart';
import '../utils/responsive_helper.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
import '../services/periodic_refresh_service.dart';
import 'dart:async';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

// class _OrdersScreenState extends State<OrdersScreen> {
//   bool isAvailable = true;
//   double balance = 98.00;
//   bool isLoading = true;
//   String? error;

//   // final ApiService _apiService = ApiService();
//   // final AuthService _authService = AuthService();
//   late ApiService _apiService;
//   late AuthService _authService;

//   List<Order> orders = [];

//   @override
//   void initState() {
//     super.initState();
//     _apiService = ApiService();
//     _authService = AuthService();
//     _loadOrders();
//   }

//   Future<void> _loadOrders() async {
//     try {
//       setState(() {
//         isLoading = true;
//         error = null;
//       });

//       // Get already-parsed Order models
//       final List<Order> ordersData = await _apiService.getPendingOrders();

//       setState(() {
//         orders = ordersData; // No conversion needed!
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         error = e.toString();
//         isLoading = false;
//       });
//     }
//   }
//   // Future<void> _loadOrders() async {
//   //   try {
//   //     setState(() {
//   //       isLoading = true;
//   //       error = null;
//   //     });

//   //     // Load real orders from API
//   //     final ordersData = await _apiService.getPendingOrders();

//   //     setState(() {
//   //       orders = ordersData.map((json) => Order.fromJson(json)).toList();
//   //       isLoading = false;
//   //     });
//   //   } catch (e) {
//   //     setState(() {
//   //       error = e.toString();
//   //       isLoading = false;
//   //     });
//   //   }
//   // }

//   void _toggleAvailability(bool value) {
//     setState(() {
//       isAvailable = value;
//     });

//     // Show notification
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           isAvailable ? 'Status: Available' : 'Status: Unavailable',
//         ),
//         backgroundColor: isAvailable ? Colors.green : Colors.orange,
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }

//   void _acceptOrder(int orderId) {
//     setState(() {
//       final order = orders.firstWhere((order) => order.id == orderId);
//       order.status = OrderStatus.accepted;
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Order #$orderId accepted successfully!'),
//         backgroundColor: Colors.green,
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }

//   void _onClientButtonPressed() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => ClientModal(onClientCreated: _handleClientCreated),
//     );
//   }

//   void _handleClientCreated(Client client) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Client "${client.name}" créé avec succès!'),
//         backgroundColor: Colors.green,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   Future<void> _logout() async {
//     await _authService.logout();
//     if (mounted) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Scaffold(
//         backgroundColor: Color(0xFFF5F5F5),
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     if (error != null) {
//       return Scaffold(
//         backgroundColor: const Color(0xFFF5F5F5),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Error: $error',
//                 style: const TextStyle(color: Colors.red),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _loadOrders,
//                 child: const Text('Retry'),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
//         ],
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header Section
//             HeaderSection(
//               balance: balance,
//               isAvailable: isAvailable,
//               onAvailabilityChanged: _toggleAvailability,
//               onClientButtonPressed: _onClientButtonPressed,
//             ),

//             // Orders List
//             Expanded(
//               child: orders.isEmpty
//                   ? const Center(
//                       child: Text(
//                         'Aucune commande en attente',
//                         style: TextStyle(fontSize: 16, color: Colors.grey),
//                       ),
//                     )
//                   : _buildOrdersList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOrdersList() {
//     final isMobile = ResponsiveHelper.isMobile(context);

//     if (isMobile) {
//       return ListView.builder(
//         padding: const EdgeInsets.all(20),
//         itemCount: orders.length,
//         itemBuilder: (context, index) {
//           final order = orders[index];
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 20),
//             child: OrderCard(
//               order: order,
//               onAccept: () => _acceptOrder(order.id),
//             ),
//           );
//         },
//       );
//     } else {
//       return GridView.builder(
//         padding: const EdgeInsets.all(20),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 1.2,
//           crossAxisSpacing: 20,
//           mainAxisSpacing: 20,
//         ),
//         itemCount: orders.length,
//         itemBuilder: (context, index) {
//           final order = orders[index];
//           return OrderCard(
//             order: order,
//             onAccept: () => _acceptOrder(order.id),
//           );
//         },
//       );
//     }
//   }
// }

class _OrdersScreenState extends State<OrdersScreen> {
  bool isAvailable = true;
  double balance = 98.00;
  bool isLoading = true;
  String? error;

  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();
  late PeriodicRefreshService _refreshService;

  List<Order> orders = [];
  StreamSubscription<List<Order>>? _ordersSubscription;

  @override
  void initState() {
    super.initState();
    _refreshService = PeriodicRefreshService(_apiService);
    _loadOrders();
    _setupPeriodicRefresh();
  }

  @override
  void dispose() {
    _ordersSubscription?.cancel();
    _refreshService.dispose();
    super.dispose();
  }

  Future<void> _loadOrders() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      // Initial load
      final ordersData = await _apiService.getPendingOrders();

      setState(() {
        orders = ordersData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  void _setupPeriodicRefresh() {
    // Listen for periodic updates
    _ordersSubscription = _refreshService.ordersStream.listen((newOrders) {
      if (newOrders.isNotEmpty && mounted) {
        setState(() {
          orders = [...newOrders, ...orders];
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${newOrders.length} nouvelle(s) commande(s)'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      }
    });

    _refreshService.startPeriodicRefresh();
  }

  void _toggleAvailability(bool value) {
    setState(() => isAvailable = value);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isAvailable ? 'Disponible' : 'Indisponible'),
        backgroundColor: isAvailable ? Colors.green : Colors.orange,
      ),
    );
  }

  void _acceptOrder(int orderId) {
    setState(() {
      final order = orders.firstWhere((order) => order.id == orderId);
      order.status = OrderStatus.accepted;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Commande #$orderId acceptée!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _onClientButtonPressed() {
    showDialog(
      context: context,
      builder: (context) => ClientModal(onClientCreated: _handleClientCreated),
    );
  }

  void _handleClientCreated(Client client) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Client "${client.name}" créé avec succès!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _logout() async {
    await _authService.logout();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return _buildLoading();
    if (error != null) return _buildError();
    return _buildContent();
  }

  Widget _buildLoading() {
    return const Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildError() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text('Erreur de chargement', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(error!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadOrders,
              child: const Text('Réessayer'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   actions: [
      //     IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
      //   ],
      // ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Balance Display
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF28A745).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF28A745).withOpacity(0.3),
                ),
              ),
              child: Text(
                '${balance.toStringAsFixed(2)} DH',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFF28A745),
                ),
              ),
            ),

            // Availability Toggle
            Row(
              children: [
                Switch(
                  value: isAvailable,
                  onChanged: _toggleAvailability,
                  activeColor: Colors.green,
                  activeTrackColor: Colors.green.withOpacity(0.3),
                ),
                const SizedBox(width: 4),
                Text(
                  isAvailable ? 'Disponible' : 'Indisponible',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isAvailable ? Colors.green : Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // Client Button
          IconButton(
            icon: const Icon(Icons.person_add, color: Color(0xFF007BFF)),
            onPressed: _onClientButtonPressed,
            tooltip: 'Nouveau Client',
          ),

          // Logout Button
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: _logout,
            tooltip: 'Déconnexion',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // HeaderSection(
            //   balance: balance,
            //   isAvailable: isAvailable,
            //   onAvailabilityChanged: _toggleAvailability,
            //   onClientButtonPressed: _onClientButtonPressed,
            // ),
            Expanded(
              child: orders.isEmpty ? _buildEmptyState() : _buildOrdersList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Aucune commande en attente',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList() {
    final isMobile = ResponsiveHelper.isMobile(context);

    if (isMobile) {
      return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: OrderCard(
              order: order,
              onAccept: () => _acceptOrder(order.id),
            ),
          );
        },
      );
    } else {
      return GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return OrderCard(
            order: order,
            onAccept: () => _acceptOrder(order.id),
          );
        },
      );
    }
  }
}
