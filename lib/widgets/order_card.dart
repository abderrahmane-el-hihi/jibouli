// import 'package:flutter/material.dart';
// import '../models/order.dart';

// class OrderCard extends StatelessWidget {
//   final Order order;
//   final VoidCallback onAccept;

//   const OrderCard({
//     super.key,
//     required this.order,
//     required this.onAccept,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isAccepted = order.status == OrderStatus.accepted;

//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Order Header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   order.orderNumber,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFF333333),
//                   ),
//                 ),
//               ),
//               Text(
//                 order.formattedCreatedAt,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Color(0xFF666666),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 15),

//           // Order Details
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Client Request
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 10),
//                 child: RichText(
//                   text: TextSpan(
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Color(0xFF333333),
//                       height: 1.5,
//                     ),
//                     children: [
//                       const TextSpan(
//                         text: 'Demande du client: ',
//                         style: TextStyle(fontWeight: FontWeight.w600),
//                       ),
//                       TextSpan(text: order.clientRequest),
//                     ],
//                   ),
//                 ),
//               ),

//               // Client Name
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 10),
//                 child: RichText(
//                   text: TextSpan(
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Color(0xFF333333),
//                       height: 1.5,
//                     ),
//                     children: [
//                       const TextSpan(
//                         text: 'Client: ',
//                         style: TextStyle(fontWeight: FontWeight.w600),
//                       ),
//                       TextSpan(text: order.clientName),
//                     ],
//                   ),
//                 ),
//               ),

//               // Address
//               RichText(
//                 text: TextSpan(
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color(0xFF333333),
//                     height: 1.5,
//                   ),
//                   children: [
//                     const TextSpan(
//                       text: 'Adresse: ',
//                       style: TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                     TextSpan(text: order.clientAddress),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 20),

//           // Accept Button
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: isAccepted ? null : onAccept,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: isAccepted
//                     ? const Color(0xFF6C757D)
//                     : const Color(0xFF28A745),
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 elevation: 0,
//               ),
//               child: Text(
//                 isAccepted ? 'Order Accepted' : 'Accept Order',
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//============================

// import 'package:flutter/material.dart';
// import '../models/order.dart';

// class OrderCard extends StatelessWidget {
//   final Order order;
//   final VoidCallback onAccept;

//   const OrderCard({super.key, required this.order, required this.onAccept});

//   @override
//   Widget build(BuildContext context) {
//     final isAccepted = order.status == OrderStatus.accepted;

//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Order Header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   'Commande #${order.id}', // Changed from order.orderNumber
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFF333333),
//                   ),
//                 ),
//               ),
//               Text(
//                 _formatDateTime(
//                   order.createdAt,
//                 ), // Changed from order.formattedCreatedAt
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Color(0xFF666666),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 15),

//           // Order Details
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Client Request
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 10),
//                 child: RichText(
//                   text: TextSpan(
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Color(0xFF333333),
//                       height: 1.5,
//                     ),
//                     children: [
//                       const TextSpan(
//                         text: 'Demande du client: ',
//                         style: TextStyle(fontWeight: FontWeight.w600),
//                       ),
//                       TextSpan(
//                         text: order.request,
//                       ), // Changed from order.clientRequest
//                     ],
//                   ),
//                 ),
//               ),

//               // Client Name
//               // Padding(
//               //   padding: const EdgeInsets.only(bottom: 10),
//               //   child: RichText(
//               //     text: TextSpan(
//               //       style: const TextStyle(
//               //         fontSize: 14,
//               //         color: Color(0xFF333333),
//               //         height: 1.5,
//               //       ),
//               //       children: [
//               //         const TextSpan(
//               //           text: 'Client: ',
//               //           style: TextStyle(fontWeight: FontWeight.w600),
//               //         ),
//               //         TextSpan(
//               //           text: order.client.name,
//               //         ), // Changed from order.clientName
//               //       ],
//               //     ),
//               //   ),
//               // ),

//               // Client Phone
//               // Padding(
//               //   padding: const EdgeInsets.only(bottom: 10),
//               //   child: RichText(
//               //     text: TextSpan(
//               //       style: const TextStyle(
//               //         fontSize: 14,
//               //         color: Color(0xFF333333),
//               //         height: 1.5,
//               //       ),
//               //       children: [
//               //         const TextSpan(
//               //           text: 'Téléphone: ',
//               //           style: TextStyle(fontWeight: FontWeight.w600),
//               //         ),
//               //         TextSpan(text: order.client.phone), // Added phone display
//               //       ],
//               //     ),
//               //   ),
//               // ),

//               // Address
//               RichText(
//                 text: TextSpan(
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color(0xFF333333),
//                     height: 1.5,
//                   ),
//                   children: [
//                     const TextSpan(
//                       text: 'Adresse: ',
//                       style: TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                     TextSpan(
//                       text: order.client.address,
//                     ), // Changed from order.clientAddress
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 20),

//           // Status Badge
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: _getStatusColor(order.status),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Text(
//               _getStatusText(order.status),
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),

//           const SizedBox(height: 15),

//           // Accept Button
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: isAccepted ? null : onAccept,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: isAccepted
//                     ? const Color(0xFF6C757D)
//                     : const Color(0xFF28A745),
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 elevation: 0,
//               ),
//               child: Text(
//                 isAccepted ? 'Commande Acceptée' : 'Accepter la Commande',
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper method to format DateTime
//   String _formatDateTime(DateTime dateTime) {
//     return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
//   }

//   // Helper method to get status color
//   Color _getStatusColor(OrderStatus status) {
//     switch (status) {
//       case OrderStatus.pending:
//         return Colors.orange;
//       case OrderStatus.accepted:
//         return Colors.green;
//       case OrderStatus.inProgress:
//         return Colors.blue;
//       case OrderStatus.delivered:
//         return Colors.purple;
//       case OrderStatus.canceled:
//         return Colors.red;
//       case OrderStatus.rejected:
//         return Colors.grey;
//     }
//   }

//   // Helper method to get status text
//   String _getStatusText(OrderStatus status) {
//     switch (status) {
//       case OrderStatus.pending:
//         return 'En Attente';
//       case OrderStatus.accepted:
//         return 'Acceptée';
//       case OrderStatus.inProgress:
//         return 'En Cours';
//       case OrderStatus.delivered:
//         return 'Livrée';
//       case OrderStatus.canceled:
//         return 'Annulée';
//       case OrderStatus.rejected:
//         return 'Rejetée';
//     }
//   }
// }

//=============================

// import 'package:flutter/material.dart';
// import 'package:jibouli/screens/order_detail_screen.dart';
// import '../models/order.dart';

// class OrderCard extends StatelessWidget {
//   final Order order;
//   final VoidCallback onAccept;
//   final Function(int) onAcceptWithId; // New callback that includes order ID

//   //==
//   final bool isRejected;
//   //==

//   const OrderCard({
//     super.key,
//     required this.order,
//     required this.onAccept,
//     required this.onAcceptWithId, // Add this parameter
//     //==
//     this.isRejected = false,
//     //==
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isAccepted = order.status == OrderStatus.accepted;

//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Order Header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   'Commande #${order.id}',
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFF333333),
//                   ),
//                 ),
//               ),
//               Text(
//                 // _formatDateTime(order.createdAt),
//                 _formatDateTimeForDisplay(order.createdAt),
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Color(0xFF666666),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 15),

//           // Order Details
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Client Request
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 10),
//                 child: RichText(
//                   text: TextSpan(
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Color(0xFF333333),
//                       height: 1.5,
//                     ),
//                     children: [
//                       const TextSpan(
//                         text: 'Demande du client: ',
//                         style: TextStyle(fontWeight: FontWeight.w600),
//                       ),
//                       TextSpan(text: order.request),
//                     ],
//                   ),
//                 ),
//               ),

//               // Client Name
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 10),
//                 child: RichText(
//                   text: TextSpan(
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Color(0xFF333333),
//                       height: 1.5,
//                     ),
//                     children: [
//                       const TextSpan(
//                         text: 'Client: ',
//                         style: TextStyle(fontWeight: FontWeight.w600),
//                       ),
//                       TextSpan(text: order.client.name),
//                     ],
//                   ),
//                 ),
//               ),

//               // Client Phone
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 10),
//                 child: RichText(
//                   text: TextSpan(
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Color(0xFF333333),
//                       height: 1.5,
//                     ),
//                     children: [
//                       const TextSpan(
//                         text: 'Téléphone: ',
//                         style: TextStyle(fontWeight: FontWeight.w600),
//                       ),
//                       TextSpan(text: order.client.phone),
//                     ],
//                   ),
//                 ),
//               ),

//               // Address
//               RichText(
//                 text: TextSpan(
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color(0xFF333333),
//                     height: 1.5,
//                   ),
//                   children: [
//                     const TextSpan(
//                       text: 'Adresse: ',
//                       style: TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                     TextSpan(text: order.client.address),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 20),

//           // Status Badge
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: _getStatusColor(order.status),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Text(
//               _getStatusText(order.status),
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),

//           const SizedBox(height: 15),

//           // Accept Button
//           // SizedBox(
//           //   width: double.infinity,
//           //   child: ElevatedButton(
//           //     onPressed: isAccepted
//           //         ? null
//           //         : () => _showAcceptConfirmation(context, order.id),
//           //     style: ElevatedButton.styleFrom(
//           //       backgroundColor: isAccepted
//           //           ? const Color(0xFF6C757D)
//           //           : const Color(0xFF28A745),
//           //       foregroundColor: Colors.white,
//           //       padding: const EdgeInsets.symmetric(vertical: 12),
//           //       shape: RoundedRectangleBorder(
//           //         borderRadius: BorderRadius.circular(8),
//           //       ),
//           //       elevation: 0,
//           //     ),
//           //     child: Text(
//           //       isAccepted ? 'Commande Acceptée' : 'Accepter la Commande',
//           //       style: const TextStyle(
//           //         fontSize: 16,
//           //         fontWeight: FontWeight.w600,
//           //       ),
//           //     ),
//           //   ),
//           // ),

//           //===========
//           // SizedBox(
//           //   width: double.infinity,
//           //   child: isRejected
//           //       ? ElevatedButton(
//           //           onPressed: null, // Disabled button for rejected orders
//           //           style: ElevatedButton.styleFrom(
//           //             backgroundColor: Colors.grey,
//           //             padding: const EdgeInsets.symmetric(vertical: 12),
//           //           ),
//           //           child: const Text(
//           //             'Commande Rejetée',
//           //             style: TextStyle(color: Colors.white),
//           //           ),
//           //         )
//           //       : ElevatedButton(
//           //           onPressed: () => _showAcceptConfirmation(context, order.id),
//           //           style: ElevatedButton.styleFrom(
//           //             backgroundColor: const Color(0xFF28A745),
//           //             padding: const EdgeInsets.symmetric(vertical: 12),
//           //           ),
//           //           child: const Text(
//           //             'Accepter la Commande',
//           //             style: TextStyle(color: Colors.white),
//           //           ),
//           //         ),
//           // ),
//           //=============
//           SizedBox(
//             width: double.infinity,
//             child: isRejected
//                 ? ElevatedButton(
//                     onPressed: null, // Disabled button for rejected orders
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.grey,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                     ),
//                     child: const Text(
//                       'Commande Rejetée',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   )
//                 : ElevatedButton(
//                     onPressed: () => _showAcceptConfirmation(context, order.id),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF28A745),
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                     ),
//                     child: const Text(
//                       'Accepter la Commande',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Show confirmation dialog before accepting order
//   void _showAcceptConfirmation(BuildContext context, int orderId) async {
//     final bool? shouldAccept = await showDialog<bool>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Accepter la commande'),
//           content: const Text(
//             'Êtes-vous sûr de vouloir accepter cette commande?',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(false),
//               child: const Text('Annuler'),
//             ),
//             ElevatedButton(
//               onPressed: () => Navigator.of(context).pop(true),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
//               child: const Text(
//                 'Accepter',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );

//     // If user confirmed acceptance
//     if (shouldAccept == true) {
//       // Call the parent's accept order method
//       onAcceptWithId(orderId);

//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Commande #$orderId acceptée!'),
//           backgroundColor: Colors.green,
//         ),
//       );

//       // Navigate to order detail screen
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) =>
//               // OrderInProgressScreen(order: _orderToMap(order))
//               OrderDetailScreen(order: _orderToMap(order)),
//         ),
//       );
//     }
//   }

//   // Helper method to convert Order to Map for OrderInProgressScreen
//   // Map<String, dynamic> _orderToMap(Order order) {
//   //   return {
//   //     'id': order.id.toString(),
//   //     'createdAt': _formatDateTime(order.createdAt),
//   //     'clientName': order.client.name,
//   //     'clientPhone': order.client.phone,
//   //     'clientAddress': order.client.address,
//   //     'request': order.request,
//   //     'clientNotes': order.clientNotes ?? '',
//   //     // 'centerNotes': order.centerNotes ?? '',
//   //   };
//   // }

//   // // Helper method to format DateTime
//   // String _formatDateTime(DateTime dateTime) {
//   //   return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
//   // }
//   //============
//   // Helper method to convert Order to Map for OrderDetailScreen
//   Map<String, dynamic> _orderToMap(Order order) {
//     return {
//       'id': order.id.toString(),
//       'createdAt': _formatDateTimeForDisplay(order.createdAt),
//       'clientName': order.client.name,
//       'clientPhone': order.client.phone,
//       'clientAddress': order.client.address,
//       'request': order.request,
//       'clientNotes': order.clientNotes ?? '',
//       // 'centerNotes': order.centerNotes ?? '',
//     };
//   }

//   // Special format for display (matches the image)
//   String _formatDateTimeForDisplay(DateTime dateTime) {
//     final months = {
//       1: 'Jan',
//       2: 'Feb',
//       3: 'Mar',
//       4: 'Apr',
//       5: 'May',
//       6: 'Jun',
//       7: 'Jul',
//       8: 'Aug',
//       9: 'Sep',
//       10: 'Oct',
//       11: 'Nov',
//       12: 'Dec',
//     };

//     final hour = dateTime.hour % 12;
//     final period = dateTime.hour < 12 ? 'AM' : 'PM';

//     return '${dateTime.day}/${dateTime.month}/${dateTime.year}, ${hour == 0 ? 12 : hour}:${dateTime.minute.toString().padLeft(2, '0')} $period';
//   }
//   //============

//   // Helper method to get status color
//   Color _getStatusColor(OrderStatus status) {
//     switch (status) {
//       case OrderStatus.pending:
//         return Colors.orange;
//       case OrderStatus.accepted:
//         return Colors.green;
//       case OrderStatus.inProgress:
//         return Colors.blue;
//       case OrderStatus.delivered:
//         return Colors.purple;
//       case OrderStatus.canceled:
//         return Colors.red;
//       case OrderStatus.rejected:
//         return Colors.grey;
//     }
//   }

//   // Helper method to get status text
//   String _getStatusText(OrderStatus status) {
//     switch (status) {
//       case OrderStatus.pending:
//         return 'En Attente';
//       case OrderStatus.accepted:
//         return 'Acceptée';
//       case OrderStatus.inProgress:
//         return 'En Cours';
//       case OrderStatus.delivered:
//         return 'Livrée';
//       case OrderStatus.canceled:
//         return 'Annulée';
//       case OrderStatus.rejected:
//         return 'Rejetée';
//     }
//   }
// }

//=========================================

import 'package:flutter/material.dart';
import '../models/order.dart';
import '../utils/responsive_helper.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback? onAccept;
  final Function(String)? onAcceptWithId;
  final bool isRejected;

  const OrderCard({
    Key? key,
    required this.order,
    this.onAccept,
    this.onAcceptWithId,
    this.isRejected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Order ID
                Text(
                  'Commande #${order.id}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                // Order Date
                Text(
                  _formatDate(order.createdAt),
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
            const Divider(),

            // Client info
            Text(
              order.clientName,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            const SizedBox(height: 4),

            // Client address
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    order.clientAddress,
                    style: TextStyle(color: Colors.grey[800], fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            // Order request preview
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                // order.request,
                order.request,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
            ),

            const SizedBox(height: 12),

            if (isRejected)
              Text(
                'Rejetée: ${order.rejectionReason ?? "Sans raison"}',
                style: const TextStyle(
                  color: Colors.red,
                  fontStyle: FontStyle.italic,
                ),
              )
            else
              // Accept button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF28A745),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Accepter la commande',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }
}
