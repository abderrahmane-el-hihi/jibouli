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

import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onAccept;

  const OrderCard({super.key, required this.order, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    final isAccepted = order.status == OrderStatus.accepted;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Commande #${order.id}', // Changed from order.orderNumber
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
              Text(
                _formatDateTime(
                  order.createdAt,
                ), // Changed from order.formattedCreatedAt
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF666666),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Order Details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Client Request
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF333333),
                      height: 1.5,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Demande du client: ',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: order.request,
                      ), // Changed from order.clientRequest
                    ],
                  ),
                ),
              ),

              // Client Name
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 10),
              //   child: RichText(
              //     text: TextSpan(
              //       style: const TextStyle(
              //         fontSize: 14,
              //         color: Color(0xFF333333),
              //         height: 1.5,
              //       ),
              //       children: [
              //         const TextSpan(
              //           text: 'Client: ',
              //           style: TextStyle(fontWeight: FontWeight.w600),
              //         ),
              //         TextSpan(
              //           text: order.client.name,
              //         ), // Changed from order.clientName
              //       ],
              //     ),
              //   ),
              // ),

              // Client Phone
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 10),
              //   child: RichText(
              //     text: TextSpan(
              //       style: const TextStyle(
              //         fontSize: 14,
              //         color: Color(0xFF333333),
              //         height: 1.5,
              //       ),
              //       children: [
              //         const TextSpan(
              //           text: 'Téléphone: ',
              //           style: TextStyle(fontWeight: FontWeight.w600),
              //         ),
              //         TextSpan(text: order.client.phone), // Added phone display
              //       ],
              //     ),
              //   ),
              // ),

              // Address
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF333333),
                    height: 1.5,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Adresse: ',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: order.client.address,
                    ), // Changed from order.clientAddress
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getStatusColor(order.status),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              _getStatusText(order.status),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Accept Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isAccepted ? null : onAccept,
              style: ElevatedButton.styleFrom(
                backgroundColor: isAccepted
                    ? const Color(0xFF6C757D)
                    : const Color(0xFF28A745),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                isAccepted ? 'Commande Acceptée' : 'Accepter la Commande',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to format DateTime
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  // Helper method to get status color
  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.accepted:
        return Colors.green;
      case OrderStatus.inProgress:
        return Colors.blue;
      case OrderStatus.delivered:
        return Colors.purple;
      case OrderStatus.canceled:
        return Colors.red;
      case OrderStatus.rejected:
        return Colors.grey;
    }
  }

  // Helper method to get status text
  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'En Attente';
      case OrderStatus.accepted:
        return 'Acceptée';
      case OrderStatus.inProgress:
        return 'En Cours';
      case OrderStatus.delivered:
        return 'Livrée';
      case OrderStatus.canceled:
        return 'Annulée';
      case OrderStatus.rejected:
        return 'Rejetée';
    }
  }
}
