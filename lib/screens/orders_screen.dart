// import 'package:flutter/material.dart';
// import 'package:jibouli/screens/order_detail_screen.dart';
// import '../models/order.dart';
// import '../models/client.dart';
// import '../widgets/order_card.dart';
// import '../widgets/header_section.dart';
// import '../widgets/client_modal.dart';
// import '../utils/responsive_helper.dart';
// import '../services/api_service.dart';
// import '../services/auth_service.dart';
// import 'login_screen.dart';
// import '../services/periodic_refresh_service.dart';
// import 'dart:async';

// class OrdersScreen extends StatefulWidget {
//   const OrdersScreen({super.key});

//   @override
//   State<OrdersScreen> createState() => _OrdersScreenState();
// }

///////================================================================

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

//=====================================================================================================================

// class _OrdersScreenState extends State<OrdersScreen>
//     with SingleTickerProviderStateMixin {
//   bool isAvailable = true;
//   double balance = 98.00;
//   bool isLoading = true;
//   String? error;

//   final ApiService _apiService = ApiService();
//   final AuthService _authService = AuthService();
//   late PeriodicRefreshService _refreshService;

//   List<Order> orders = [];
//   StreamSubscription<List<Order>>? _ordersSubscription;

//   //====
//   late TabController _tabController;
//   List<Order> _pendingOrders = [];
//   List<Order> _rejectedOrders = [];
//   //===

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _refreshService = PeriodicRefreshService(_apiService);
//     _loadOrders();
//     _setupPeriodicRefresh();
//   }

//   @override
//   void dispose() {
//     _ordersSubscription?.cancel();
//     _refreshService.dispose();
//     super.dispose();
//   }

//   Future<void> _loadOrders() async {
//     try {
//       setState(() {
//         isLoading = true;
//         error = null;
//       });

//       // Initial load
//       final ordersData = await _apiService.getPendingOrders();

//       setState(() {
//         orders = ordersData;
//         isLoading = false;
//       });
//       // setState(() {
//       //   _pendingOrders = ordersData
//       //       .where((order) => order.status != 'rejected')
//       //       .toList();
//       //   _rejectedOrders = ordersData
//       //       .where((order) => order.status == 'rejected')
//       //       .toList();
//       // });
//     } catch (e) {
//       setState(() {
//         error = e.toString();
//         isLoading = false;
//       });
//     }
//   }

//   void _setupPeriodicRefresh() {
//     // Listen for periodic updates
//     _ordersSubscription = _refreshService.ordersStream.listen((newOrders) {
//       if (newOrders.isNotEmpty && mounted) {
//         setState(() {
//           orders = [...newOrders, ...orders];
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('${newOrders.length} nouvelle(s) commande(s)'),
//             duration: const Duration(seconds: 2),
//             backgroundColor: Colors.green,
//           ),
//         );
//       }
//     });

//     _refreshService.startPeriodicRefresh();
//   }

//   void _toggleAvailability(bool value) {
//     setState(() => isAvailable = value);

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(isAvailable ? 'Disponible' : 'Indisponible'),
//         backgroundColor: isAvailable ? Colors.green : Colors.orange,
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
//         content: Text('Commande #$orderId acceptée!'),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }

//   // void _acceptOrder(int orderId) async {
//   //   // Show confirmation dialog
//   //   final bool? shouldAccept = await showDialog<bool>(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         title: const Text('Accepter la commande'),
//   //         content: const Text(
//   //           'Êtes-vous sûr de vouloir accepter cette commande?',
//   //         ),
//   //         actions: [
//   //           TextButton(
//   //             onPressed: () => Navigator.of(context).pop(false), // No
//   //             child: const Text('Annuler'),
//   //           ),
//   //           ElevatedButton(
//   //             onPressed: () => Navigator.of(context).pop(true), // Yes
//   //             style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
//   //             child: const Text(
//   //               'Accepter',
//   //               style: TextStyle(color: Colors.white),
//   //             ),
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );

//   //   // If user confirmed acceptance
//   //   if (shouldAccept == true) {
//   //     // Update order status
//   //     setState(() {
//   //       final order = orders.firstWhere((order) => order.id == orderId);
//   //       order.status = OrderStatus.accepted;
//   //     });

//   //     // Show success message
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text('Commande #$orderId acceptée!'),
//   //         backgroundColor: Colors.green,
//   //       ),
//   //     );

//   //     // Navigate to order detail screen
//   //     final order = orders.firstWhere((order) => order.id == orderId);
//   //     Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //         builder: (context) =>
//   //             // OrderInProgressScreen(order: order as Map<String, dynamic>)
//   //             OrderDetailScreen(order: order as Map<String, dynamic>),
//   //       ),
//   //     );
//   //   }
//   //   // If user canceled, nothing happens (dialog just closes)
//   // }

//   void _onClientButtonPressed() {
//     showDialog(
//       context: context,
//       builder: (context) => ClientModal(onClientCreated: _handleClientCreated),
//     );
//   }

//   void _handleClientCreated(Client client) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Client "${client.name}" créé avec succès!'),
//         backgroundColor: Colors.green,
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
//     if (isLoading) return _buildLoading();
//     if (error != null) return _buildError();
//     return _buildContent();
//   }

//   Widget _buildLoading() {
//     return const Scaffold(
//       backgroundColor: Color(0xFFF5F5F5),
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }

//   Widget _buildError() {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.error_outline, size: 64, color: Colors.red),
//             const SizedBox(height: 16),
//             const Text('Erreur de chargement', style: TextStyle(fontSize: 18)),
//             const SizedBox(height: 8),
//             Text(error!, textAlign: TextAlign.center),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _loadOrders,
//               child: const Text('Réessayer'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildContent() {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),

//       // appBar: AppBar(
//       //   backgroundColor: Colors.white,
//       //   elevation: 0,
//       //   actions: [
//       //     IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
//       //   ],
//       // ),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Balance Display
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF28A745).withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//                   color: const Color(0xFF28A745).withOpacity(0.3),
//                 ),
//               ),
//               child: Text(
//                 '${balance.toStringAsFixed(2)} DH',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 14,
//                   color: Color(0xFF28A745),
//                 ),
//               ),
//             ),

//             // Availability Toggle
//             Row(
//               children: [
//                 Switch(
//                   value: isAvailable,
//                   onChanged: _toggleAvailability,
//                   activeColor: Colors.green,
//                   activeTrackColor: Colors.green.withOpacity(0.3),
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   isAvailable ? 'Disponible' : 'Indisponible',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: isAvailable ? Colors.green : Colors.orange,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           // Client Button
//           IconButton(
//             icon: const Icon(Icons.person_add, color: Color(0xFF007BFF)),
//             onPressed: _onClientButtonPressed,
//             tooltip: 'Nouveau Client',
//           ),

//           // Logout Button
//           IconButton(
//             icon: const Icon(Icons.logout, color: Colors.red),
//             onPressed: _logout,
//             tooltip: 'Déconnexion',
//           ),
//         ],
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: const [
//             Tab(text: 'En Attente'),
//             Tab(text: 'Rejetées'),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: orders.isEmpty ? _buildEmptyState() : _buildOrdersList(),
//             ),
//           ],
//         ),
//       ),
//       // body: TabBarView(
//       //   controller: _tabController,
//       //   children: [
//       //     // Pending Orders Tab
//       //     _buildOrdersList(_pendingOrders, false),

//       //     // Rejected Orders Tab
//       //     _buildOrdersList(_rejectedOrders, true),
//       //   ],
//       // ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.inbox, size: 64, color: Colors.grey),
//           SizedBox(height: 16),
//           Text(
//             'Aucune commande en attente',
//             style: TextStyle(fontSize: 16, color: Colors.grey),
//           ),
//         ],
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
//               onAcceptWithId: (int) {},
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
//             onAcceptWithId: (int) {},
//           );
//         },
//       );
//     }
//   }
//   // Widget _buildOrdersList(List<Order> orders, bool isRejectedTab) {
//   //   if (orders.isEmpty) {
//   //     return Center(
//   //       child: Text(
//   //         isRejectedTab
//   //             ? 'Aucune commande rejetée'
//   //             : 'Aucune commande en attente',
//   //         style: const TextStyle(fontSize: 18),
//   //       ),
//   //     );
//   //   }

//   //   return ListView.builder(
//   //     itemCount: orders.length,
//   //     itemBuilder: (context, index) {
//   //       final order = orders[index];
//   //       return OrderCard(
//   //         order: order,
//   //         onAccept: () => _acceptOrder(order.id),
//   //         onAcceptWithId: _acceptOrder,
//   //         isRejected: isRejectedTab,
//   //       );
//   //     },
//   //   );
//   // }
// }



//==============================================

// import 'package:flutter/material.dart';
// import 'package:jibouli/screens/order_detail_screen.dart';
// import '../models/order.dart';
// import '../models/client.dart';
// import '../models/delivery_person.dart';
// import '../widgets/order_card.dart';
// import '../widgets/header_section.dart';
// import '../widgets/client_modal.dart';
// import '../utils/responsive_helper.dart';
// import '../services/api_service.dart';
// import '../services/auth_service.dart';
// import 'login_screen.dart';
// import '../services/periodic_refresh_service.dart';
// import 'dart:async';

// class OrdersScreen extends StatefulWidget {
//   const OrdersScreen({super.key});

//   @override
//   State<OrdersScreen> createState() => _OrdersScreenState();
// }

// class _OrdersScreenState extends State<OrdersScreen>
//     with SingleTickerProviderStateMixin {
//   DeliveryPerson? deliveryPerson;
//   bool isLoading = true;
//   bool isActionLoading = false;
//   String? error;

//   final ApiService _apiService = ApiService();
//   final AuthService _authService = AuthService();
//   late PeriodicRefreshService _refreshService;

//   List<Order> orders = [];
//   StreamSubscription<List<Order>>? _ordersSubscription;

//   late TabController _tabController;
//   List<Order> _pendingOrders = [];
//   List<Order> _rejectedOrders = [];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _refreshService = PeriodicRefreshService(_apiService);
//     _loadDeliveryPersonInfo();
//     _loadOrders();
//     _setupPeriodicRefresh();
//   }

//   @override
//   void dispose() {
//     _ordersSubscription?.cancel();
//     _refreshService.dispose();
//     _tabController.dispose();
//     super.dispose();
//   }

//   Future<void> _loadDeliveryPersonInfo() async {
//     try {
//       final personInfo = await _apiService.getDeliveryPersonInfo();
//       setState(() {
//         deliveryPerson = personInfo;
//       });
//     } catch (e) {
//       debugPrint('Error loading delivery person info: $e');
//     }
//   }

//   Future<void> _loadOrders() async {
//     try {
//       setState(() {
//         isLoading = true;
//         error = null;
//       });

//       // Initial load
//       final ordersData = await _apiService.getPendingOrders();

//       setState(() {
//         orders = ordersData;
//         _filterOrders();
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         error = e.toString();
//         isLoading = false;
//       });
//     }
//   }

//   void _filterOrders() {
//     _pendingOrders = orders
//         .where((order) => order.status != OrderStatus.rejected)
//         .toList();
//     _rejectedOrders = orders
//         .where((order) => order.status == OrderStatus.rejected)
//         .toList();
//   }

//   void _setupPeriodicRefresh() {
//     // Listen for periodic updates
//     _ordersSubscription = _refreshService.ordersStream.listen((newOrders) {
//       if (newOrders.isNotEmpty && mounted) {
//         // Add only non-duplicate orders
//         final List<Order> uniqueNewOrders = [];
//         for (var newOrder in newOrders) {
//           if (!orders.any((existingOrder) => existingOrder.id == newOrder.id)) {
//             uniqueNewOrders.add(newOrder);
//           }
//         }

//         if (uniqueNewOrders.isNotEmpty) {
//           setState(() {
//             orders = [...uniqueNewOrders, ...orders];
//             _filterOrders();
//           });

//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 '${uniqueNewOrders.length} nouvelle(s) commande(s)',
//               ),
//               duration: const Duration(seconds: 2),
//               backgroundColor: Colors.green,
//             ),
//           );
//         }
//       }
//     });

//     _refreshService.startPeriodicRefresh();
//   }

//   Future<void> _updateDriverAvailability(bool available) async {
//     if (deliveryPerson == null) return;

//     try {
//       setState(() {
//         isActionLoading = true;
//       });

//       await _apiService.updateDriverAvailability(available);

//       setState(() {
//         deliveryPerson!.isAvailable = available;
//         isActionLoading = false;
//       });

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               deliveryPerson!.isAvailable ? 'Disponible' : 'Indisponible',
//             ),
//             backgroundColor: deliveryPerson!.isAvailable
//                 ? Colors.green
//                 : Colors.orange,
//           ),
//         );
//       }
//     } catch (e) {
//       setState(() {
//         isActionLoading = false;
//       });

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Erreur: ${e.toString()}'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   void _toggleAvailability(bool value) {
//     _updateDriverAvailability(value);
//   }

//   Future<void> _acceptOrder(int orderId) async {
//     try {
//       setState(() {
//         isActionLoading = true;
//       });

//       // Call API to accept order
//       // await _apiService.acceptOrder(orderId);

//       setState(() {
//         final order = orders.firstWhere((order) => order.id == orderId);
//         order.status = OrderStatus.accepted;
//         _filterOrders();
//         isActionLoading = false;
//       });

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Commande #$orderId acceptée!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       }

//       // Refresh delivery person info to get updated active orders
//       _loadDeliveryPersonInfo();
//     } catch (e) {
//       setState(() {
//         isActionLoading = false;
//       });

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Erreur: ${e.toString()}'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   void _onClientButtonPressed() {
//     showDialog(
//       context: context,
//       builder: (context) => ClientModal(onClientCreated: _handleClientCreated),
//     );
//   }

//   void _handleClientCreated(Client client) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Client "${client.name}" créé avec succès!'),
//         backgroundColor: Colors.green,
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

//   Future<void> _refreshData() async {
//     await _loadDeliveryPersonInfo();
//     await _loadOrders();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) return _buildLoading();
//     if (error != null) return _buildError();
//     return _buildContent();
//   }

//   Widget _buildLoading() {
//     return const Scaffold(
//       backgroundColor: Color(0xFFF5F5F5),
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }

//   Widget _buildError() {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.error_outline, size: 64, color: Colors.red),
//             const SizedBox(height: 16),
//             const Text('Erreur de chargement', style: TextStyle(fontSize: 18)),
//             const SizedBox(height: 8),
//             Text(error!, textAlign: TextAlign.center),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _loadOrders,
//               child: const Text('Réessayer'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildContent() {
//     final isAvailable = deliveryPerson?.isAvailable ?? false;
//     final balance = deliveryPerson?.balance ?? 0.0;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Balance Display
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF28A745).withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//                   color: const Color(0xFF28A745).withOpacity(0.3),
//                 ),
//               ),
//               child: Text(
//                 '${balance.toStringAsFixed(2)} DH',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 14,
//                   color: Color(0xFF28A745),
//                 ),
//               ),
//             ),

//             // Availability Toggle
//             Row(
//               children: [
//                 isActionLoading
//                     ? const SizedBox(
//                         height: 20,
//                         width: 20,
//                         child: CircularProgressIndicator(strokeWidth: 2),
//                       )
//                     : Switch(
//                         value: isAvailable,
//                         onChanged: _toggleAvailability,
//                         activeColor: Colors.green,
//                         activeTrackColor: Colors.green.withOpacity(0.3),
//                       ),
//                 const SizedBox(width: 4),
//                 Text(
//                   isAvailable ? 'Disponible' : 'Indisponible',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: isAvailable ? Colors.green : Colors.orange,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           // Driver Name Display
//           if (deliveryPerson != null)
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Text(
//                   deliveryPerson!.name,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ),
//             ),

//           // Refresh Button
//           IconButton(
//             icon: const Icon(Icons.refresh, color: Colors.blue),
//             onPressed: isActionLoading ? null : _refreshData,
//             tooltip: 'Actualiser',
//           ),

//           // Client Button
//           IconButton(
//             icon: const Icon(Icons.person_add, color: Color(0xFF007BFF)),
//             onPressed: _onClientButtonPressed,
//             tooltip: 'Nouveau Client',
//           ),

//           // Logout Button
//           IconButton(
//             icon: const Icon(Icons.logout, color: Colors.red),
//             onPressed: _logout,
//             tooltip: 'Déconnexion',
//           ),
//         ],
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: const [
//             Tab(text: 'En Attente'),
//             Tab(text: 'Rejetées'),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Active Orders Section
//             if (deliveryPerson != null &&
//                 deliveryPerson!.activeOrders.isNotEmpty)
//               Container(
//                 padding: const EdgeInsets.all(8.0),
//                 color: Colors.blue.shade50,
//                 child: Row(
//                   children: [
//                     const Icon(Icons.directions_car, color: Colors.blue),
//                     const SizedBox(width: 8),
//                     Text(
//                       'Commandes actives: ${deliveryPerson!.activeOrders.length}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//             Expanded(
//               child: RefreshIndicator(
//                 onRefresh: _refreshData,
//                 child: TabBarView(
//                   controller: _tabController,
//                   children: [
//                     // Pending Orders Tab
//                     _pendingOrders.isEmpty
//                         ? _buildEmptyState('Aucune commande en attente')
//                         : _buildOrdersList(_pendingOrders),

//                     // Rejected Orders Tab
//                     _rejectedOrders.isEmpty
//                         ? _buildEmptyState('Aucune commande rejetée')
//                         : _buildOrdersList(_rejectedOrders),
//                   ],
//                 ),
//               ),
//             ),
//             // Loading Indicator for Actions
//             if (isActionLoading)
//               const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 8.0),
//                 child: LinearProgressIndicator(),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState(String message) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.inbox, size: 64, color: Colors.grey),
//           const SizedBox(height: 16),
//           Text(
//             message,
//             style: const TextStyle(fontSize: 16, color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildOrdersList(List<Order> ordersList) {
//     final isMobile = ResponsiveHelper.isMobile(context);

//     if (isMobile) {
//       return ListView.builder(
//         padding: const EdgeInsets.all(20),
//         itemCount: ordersList.length,
//         itemBuilder: (context, index) {
//           final order = ordersList[index];
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 20),
//             child: OrderCard(
//               order: order,
//               onAccept: () => _acceptOrder(order.id),
//               onAcceptWithId: (orderId) => _acceptOrder(orderId),
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
//         itemCount: ordersList.length,
//         itemBuilder: (context, index) {
//           final order = ordersList[index];
//           return OrderCard(
//             order: order,
//             onAccept: () => _acceptOrder(order.id),
//             onAcceptWithId: (orderId) => _acceptOrder(orderId),
//           );
//         },
//       );
//     }
//   }
// }



///===========================================



import 'package:flutter/material.dart';
import 'package:jibouli/screens/order_detail_screen.dart';
import '../models/order.dart';
import '../models/client.dart';
import '../models/delivery_person.dart';
import '../widgets/order_card.dart';
import '../widgets/header_section.dart';
import '../widgets/client_modal.dart';
import '../utils/responsive_helper.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
import '../services/periodic_refresh_service.dart';
import '../utils/app_state_manager.dart';
import 'dart:async';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  DeliveryPerson? deliveryPerson;
  bool isLoading = true;
  bool isActionLoading = false;
  String? error;

  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();
  final AppStateManager _appStateManager = AppStateManager();
  late PeriodicRefreshService _refreshService;

  List<Order> orders = [];
  StreamSubscription<List<Order>>? _ordersSubscription;

  late TabController _tabController;
  List<Order> _pendingOrders = [];
  List<Order> _rejectedOrders = [];
  
  bool _refreshActive = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _refreshService = PeriodicRefreshService(_apiService);
    
    // Check if we have an active order
    _checkActiveOrder();
    
    // Load data if no active order
    _loadDeliveryPersonInfo();
    _loadOrders();
    
    // Setup periodic refresh only if no active order
    if (_refreshActive) {
      _setupPeriodicRefresh();
    }
  }

  void _checkActiveOrder() async {
    final activeOrder = await _appStateManager.getActiveOrder();
    if (activeOrder != null) {
      _refreshActive = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigateToOrderDetail(activeOrder);
      });
    }
  }

  @override
  void dispose() {
    _pauseRefresh();
    _tabController.dispose();
    super.dispose();
  }

  void _pauseRefresh() {
    _ordersSubscription?.cancel();
    _refreshService.dispose();
  }
  
  void _resumeRefresh() {
    _refreshActive = true;
    _setupPeriodicRefresh();
    _refreshData();
  }

  Future<void> _loadDeliveryPersonInfo() async {
    try {
      final personInfo = await _apiService.getDeliveryPersonInfo();
      setState(() {
        deliveryPerson = personInfo;
      });
    } catch (e) {
      debugPrint('Error loading delivery person info: $e');
    }
  }

  Future<void> _loadOrders() async {
    if (!_refreshActive) return;
    
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      // Initial load
      final ordersData = await _apiService.getPendingOrders();

      setState(() {
        orders = ordersData;
        _filterOrders();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  void _filterOrders() {
    _pendingOrders = orders
        .where((order) => order.status != OrderStatus.rejected)
        .toList();
    _rejectedOrders = orders
        .where((order) => order.status == OrderStatus.rejected)
        .toList();
  }

  void _setupPeriodicRefresh() {
    if (!_refreshActive) return;
    
    // Listen for periodic updates
    _ordersSubscription = _refreshService.ordersStream.listen((newOrders) {
      if (newOrders.isNotEmpty && mounted && _refreshActive) {
        // Add only non-duplicate orders
        final List<Order> uniqueNewOrders = [];
        for (var newOrder in newOrders) {
          if (!orders.any((existingOrder) => existingOrder.id == newOrder.id)) {
            uniqueNewOrders.add(newOrder);
          }
        }
        
        if (uniqueNewOrders.isNotEmpty) {
          setState(() {
            orders = [...uniqueNewOrders, ...orders];
            _filterOrders();
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${uniqueNewOrders.length} nouvelle(s) commande(s)'),
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    });

    _refreshService.startPeriodicRefresh();
  }

  Future<void> _updateDriverAvailability(bool available) async {
    if (deliveryPerson == null) return;
    
    try {
      setState(() {
        isActionLoading = true;
      });
      
      await _apiService.updateDriverAvailability(available);
      
      setState(() {
        deliveryPerson!.isAvailable = available;
        isActionLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(deliveryPerson!.isAvailable ? 'Disponible' : 'Indisponible'),
            backgroundColor: deliveryPerson!.isAvailable ? Colors.green : Colors.orange,
          ),
        );
      }
    } catch (e) {
      setState(() {
        isActionLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _toggleAvailability(bool value) {
    _updateDriverAvailability(value);
  }

  Future<void> _acceptOrder(Order order) async {
    try {
      setState(() {
        isActionLoading = true;
      });

      // Call API to accept order
      await _apiService.acceptOrder(order.id.toString());

      // Update order status locally
      order.status = OrderStatus.accepted;
      
      // Save as active order
      await _appStateManager.setActiveOrder(order);
      
      // Pause refresh while handling order
      _pauseRefresh();
      
      setState(() {
        isActionLoading = false;
      });

      // Navigate to order detail
      _navigateToOrderDetail(order);
      
    } catch (e) {
      setState(() {
        isActionLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  
  void _navigateToOrderDetail(Order order) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailScreen(order: order),
      ),
    );
    
    // Clear active order when returning from detail screen
    await _appStateManager.clearActiveOrder();
    
    // Resume refresh
    _resumeRefresh();
    
    // Handle result from OrderDetailScreen
    if (result != null && result is Map<String, dynamic>) {
      if (result['status'] == 'rejected') {
        // Move order to rejected tab
        final orderId = result['orderId'];
        setState(() {
          final order = orders.firstWhere((o) => o.id.toString() == orderId);
          order.status = OrderStatus.rejected;
          _filterOrders();
        });
      } else if (result['status'] == 'completed') {
        // Remove completed order from list
        final orderId = result['orderId'];
        setState(() {
          orders.removeWhere((o) => o.id.toString() == orderId);
          _filterOrders();
        });
      }
    }
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
    await _appStateManager.clearActiveOrder();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  Future<void> _refreshData() async {
    if (!_refreshActive) return;
    await _loadDeliveryPersonInfo();
    await _loadOrders();
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
    final isAvailable = deliveryPerson?.isAvailable ?? false;
    final balance = deliveryPerson?.balance ?? 0.0;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
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
                isActionLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Switch(
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
          // Driver Name Display
          if (deliveryPerson != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  deliveryPerson!.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          
          // Refresh Button
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.blue),
            onPressed: isActionLoading ? null : _refreshData,
            tooltip: 'Actualiser',
          ),
          
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
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'En Attente'),
            Tab(text: 'Rejetées'),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Active Orders Section
            if (deliveryPerson != null && deliveryPerson!.activeOrders.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.blue.shade50,
                child: Row(
                  children: [
                    const Icon(Icons.directions_car, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text(
                      'Commandes actives: ${deliveryPerson!.activeOrders.length}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshData,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Pending Orders Tab
                    _pendingOrders.isEmpty 
                      ? _buildEmptyState('Aucune commande en attente') 
                      : _buildOrdersList(_pendingOrders),
                    
                    // Rejected Orders Tab
                    _rejectedOrders.isEmpty 
                      ? _buildEmptyState('Aucune commande rejetée') 
                      : _buildOrdersList(_rejectedOrders, isRejected: true),
                  ],
                ),
              ),
            ),
            // Loading Indicator for Actions
            if (isActionLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: LinearProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inbox, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<Order> ordersList, {bool isRejected = false}) {
    final isMobile = ResponsiveHelper.isMobile(context);

    if (isMobile) {
      return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: ordersList.length,
        itemBuilder: (context, index) {
          final order = ordersList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: OrderCard(
              order: order,
              isRejected: isRejected,
              onAccept: isRejected ? null : () => _acceptOrder(order),
              onAcceptWithId: isRejected ? null : (orderId) => _acceptOrder(
                ordersList.firstWhere((o) => o.id.toString() == orderId)
              ),
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
        itemCount: ordersList.length,
        itemBuilder: (context, index) {
          final order = ordersList[index];
          return OrderCard(
            order: order,
            isRejected: isRejected,
            onAccept: isRejected ? null : () => _acceptOrder(order),
            onAcceptWithId: isRejected ? null : (orderId) => _acceptOrder(
              ordersList.firstWhere((o) => o.id.toString() == orderId)
            ),
          );
        },
      );
    }
  }
}