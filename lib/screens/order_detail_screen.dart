// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class OrderInProgressScreen extends StatelessWidget {
//   final Map<String, dynamic> order;

//   const OrderInProgressScreen({Key? key, required this.order})
//     : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Commande en Cours'),
//         backgroundColor: Colors.orange,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Order creation info
//             Text(
//               'Crée le: ${order['createdAt']}',
//               style: TextStyle(color: Colors.grey[600], fontSize: 14),
//             ),
//             const SizedBox(height: 20),

//             // Client information section
//             _buildSectionHeader('INFORMATION CLIENT'),
//             _buildInfoRow('Nom', order['clientName']),
//             _buildInfoRow('Tél', order['clientPhone']),
//             _buildInfoRow('Adresse', order['clientAddress']),
//             const SizedBox(height: 20),

//             // Order details section
//             _buildSectionHeader('DÉTAILS DE COMMANDE'),
//             _buildInfoRow('Demande', order['request'], isBold: true),
//             _buildInfoRow(
//               'Notes Client',
//               order['clientNotes']?.isEmpty ?? true
//                   ? '-'
//                   : order['clientNotes'],
//             ),
//             _buildInfoRow(
//               'Notes Centre',
//               order['centerNotes']?.isEmpty ?? true
//                   ? '-'
//                   : order['centerNotes'],
//             ),
//             const SizedBox(height: 30),

//             // Action buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     icon: const Icon(Icons.chat, color: Colors.white),
//                     label: const Text(
//                       'WhatsApp',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     onPressed: () => _launchWhatsApp(order['clientPhone']),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: OutlinedButton.icon(
//                     icon: const Icon(Icons.cancel, color: Colors.red),
//                     label: const Text(
//                       'Rejeter',
//                       style: TextStyle(color: Colors.red),
//                     ),
//                     onPressed: () => _rejectOrder(context, order['id']),
//                     style: OutlinedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       side: const BorderSide(color: Colors.red),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             // Status indicator
//             const SizedBox(height: 20),
//             Center(
//               child: Chip(
//                 label: const Text(
//                   'En Cours',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 backgroundColor: Colors.orange,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionHeader(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 16,
//           color: Colors.deepOrange,
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 100,
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 color: Colors.grey[700],
//               ),
//             ),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(
//                 fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _launchWhatsApp(String phone) async {
//     // Clean the phone number (remove any non-digit characters)
//     final cleanedPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
//     final url = 'https://wa.me/$cleanedPhone';

//     if (await canLaunchUrl(Uri.parse(url))) {
//       await launchUrl(Uri.parse(url));
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   void _rejectOrder(BuildContext context, String orderId) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Rejeter la commande'),
//           content: const Text(
//             'Êtes-vous sûr de vouloir rejeter cette commande?',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Annuler'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Implement rejection logic
//                 Navigator.of(context).pop();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Commande rejetée')),
//                 );
//                 // Navigate back to orders list
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Rejeter', style: TextStyle(color: Colors.red)),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

///////============================================================================

// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class OrderDetailScreen extends StatelessWidget {
//   final Map<String, dynamic> order;

//   const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Commande en Cours')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Order creation info
//             Text(
//               'Crée le: ${order['createdAt']}',
//               style: TextStyle(color: Colors.grey[600], fontSize: 14),
//             ),
//             const SizedBox(height: 24),

//             // Client information section
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.person, color: Colors.grey),
//                         SizedBox(width: 2),
//                         _buildSectionHeader('INFORMATION CLIENT'),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     _buildInfoRow('Nom', order['clientName']),
//                     _buildInfoRow('Tél', order['clientPhone']),
//                     _buildInfoRow('Adresse', order['clientAddress']),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),

//             // Order details section
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.paste, color: Colors.grey),
//                         SizedBox(width: 2),
//                         _buildSectionHeader('DÉTAILS DE COMMANDE'),
//                       ],
//                     ),

//                     const SizedBox(height: 8),
//                     _buildInfoRow('Demande', order['request'], isBold: true),
//                     _buildInfoRow(
//                       'Notes Client',
//                       order['clientNotes']?.isEmpty ?? true
//                           ? '-'
//                           : order['clientNotes'],
//                     ),
//                     _buildInfoRow(
//                       'Notes Centre',
//                       order['centerNotes']?.isEmpty ?? true
//                           ? '-'
//                           : order['centerNotes'],
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 32),
//             const Divider(),
//             const SizedBox(height: 24),

//             // Action buttons section
//             _buildActionSection(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionHeader(String title) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontWeight: FontWeight.bold,
//         fontSize: 16,
//         color: Colors.grey,
//         letterSpacing: 0.5,
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 100,
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 color: Colors.grey[700],
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(
//                 fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//                 fontSize: 14,
//                 color: Colors.black87,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionSection(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton.icon(
//             onPressed: () => _launchWhatsApp(context, order['clientPhone']),
//             icon: const Icon(Icons.chat, color: Colors.white),
//             label: const Text(
//               'Appeler WhatsApp',
//               style: TextStyle(color: Colors.white),
//             ),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.green,
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//         ),

//         const SizedBox(height: 16),

//         // Reject section - Red elevated button
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton.icon(
//             onPressed: () => _rejectOrder(context, order['id']),
//             icon: const Icon(Icons.cancel, color: Colors.white),
//             label: const Text(
//               'Rejeter la Commande',
//               style: TextStyle(color: Colors.white),
//             ),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   void _launchWhatsApp(BuildContext context, String phone) async {
//     try {
//       // Clean the phone number (remove any non-digit characters except +)
//       String cleanedPhone = phone.replaceAll(RegExp(r'[^0-9+]'), '');

//       // Handle Moroccan numbers specifically
//       if (cleanedPhone.startsWith('+2120')) {
//         cleanedPhone = cleanedPhone.replaceFirst('0', '');
//       } else if (cleanedPhone.startsWith('0')) {
//         cleanedPhone = '+212${cleanedPhone.substring(1)}';
//       } else if (!cleanedPhone.startsWith('+')) {
//         cleanedPhone = '+212$cleanedPhone';
//       }

//       final url = 'https://wa.me/$cleanedPhone';

//       if (await canLaunchUrl(Uri.parse(url))) {
//         await launchUrl(Uri.parse(url));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Impossible d\'ouvrir WhatsApp')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
//     }
//   }

//   void _rejectOrder(BuildContext context, String orderId) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Rejeter la commande'),
//           content: const Text(
//             'Êtes-vous sûr de vouloir rejetter cette commande?',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Annuler'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Close the dialog
//                 Navigator.of(context).pop();

//                 // Update order status to rejected
//                 _updateOrderStatus(context, orderId, 'rejected');

//                 // Navigate back to orders screen
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Rejeter', style: TextStyle(color: Colors.red)),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _updateOrderStatus(
//     BuildContext context,
//     String orderId,
//     String status,
//   ) async {
//     try {
//       // Call your API to update order status
//       // Example: await _dio.patch('/orders/$orderId', data: {'status': status});

//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Commande #$orderId rejetée!'),
//           backgroundColor: Colors.red,
//         ),
//       );

//       // Notify the orders screen to refresh or update its state
//       // This depends on your state management approach
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Erreur: $e'), backgroundColor: Colors.red),
//       );
//     }
//   }

//   //   void _rejectOrder(BuildContext context, String orderId) {
//   //     showDialog(
//   //       context: context,
//   //       builder: (BuildContext context) {
//   //         return AlertDialog(
//   //           title: const Text('Rejeter la commande'),
//   //           content: const Text(
//   //             'Êtes-vous sûr de vouloir rejeter cette commande?',
//   //           ),
//   //           actions: [
//   //             TextButton(
//   //               onPressed: () => Navigator.of(context).pop(),
//   //               child: const Text('Annuler'),
//   //             ),
//   //             TextButton(
//   //               onPressed: () {
//   //                 Navigator.of(context).pop();
//   //                 ScaffoldMessenger.of(context).showSnackBar(
//   //                   const SnackBar(content: Text('Commande rejetée')),
//   //                 );
//   //                 Navigator.of(context).pop();
//   //               },
//   //               child: const Text('Rejeter', style: TextStyle(color: Colors.red)),
//   //             ),
//   //           ],
//   //         );
//   //       },
//   //     );
//   //   }
// }

//========================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/order.dart';
import '../services/api_service.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order order;

  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final ApiService _apiService = ApiService();
  bool isLoading = false;
  String? selectedAction;
  final List<String> actions = ['Marquer comme livrée', 'Annuler la commande'];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent back button navigation unless order is completed/rejected
        _showExitWarning();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Commande #${widget.order.id}'),
          automaticallyImplyLeading: false, // Disable back button
        ),
        body: Stack(
          children: [
            // Make the content scrollable
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status indicator
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Statut: ${_getStatusText(widget.order.status)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Order creation info
                    Text(
                      'Crée le: ${widget.order.createdAt}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    const SizedBox(height: 24),

                    // Client information section
                    Container(
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
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.person, color: Colors.grey),
                                SizedBox(width: 8),
                                Text(
                                  'INFORMATION CLIENT',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow('Nom', widget.order.clientName),
                            _buildInfoRow('Tél', widget.order.clientPhone),
                            _buildInfoRow(
                              'Adresse',
                              widget.order.clientAddress,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Order details section
                    Container(
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
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.paste, color: Colors.grey),
                                SizedBox(width: 8),
                                Text(
                                  'DÉTAILS DE COMMANDE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                              'Demande',
                              widget.order.request,
                              isBold: true,
                            ),
                            _buildInfoRow(
                              'Notes Client',
                              widget.order.clientNotes.isEmpty
                                  ? '-'
                                  : widget.order.clientNotes,
                            ),
                            _buildInfoRow(
                              'Notes Centre',
                              widget.order.centerNotes.isEmpty
                                  ? '-'
                                  : widget.order.centerNotes,
                            ),
                            _buildInfoRow(
                              'Prix Total',
                              '${widget.order.totalPrice} DH',
                              isBold: true,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Status Dropdown
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: const Text('Sélectionner une action'),
                          value: selectedAction,
                          isExpanded: true,
                          items: actions.map((String action) {
                            return DropdownMenuItem<String>(
                              value: action,
                              child: Text(action),
                            );
                          }).toList(),
                          onChanged: isLoading
                              ? null
                              : (String? newValue) {
                                  if (newValue != null) {
                                    _showCommentDialog(newValue);
                                  }
                                },
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Communication buttons
                    Row(
                      children: [
                        // Call button
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: isLoading
                                ? null
                                : () => _callClient(widget.order.clientPhone),
                            icon: const Icon(Icons.call, color: Colors.white),
                            label: const Text(
                              'Appeler',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // WhatsApp button
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: isLoading
                                ? null
                                : () => _launchWhatsApp(
                                    context,
                                    widget.order.clientPhone,
                                  ),
                            icon: const Icon(Icons.chat, color: Colors.white),
                            label: const Text(
                              'WhatsApp',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Reject button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: isLoading
                            ? null
                            : () => _rejectOrder(
                                context,
                                widget.order.id.toString(),
                              ),
                        icon: const Icon(Icons.cancel, color: Colors.white),
                        label: const Text(
                          'Rejeter la Commande',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),

                    // Add extra padding at bottom for better visibility on mobile
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Loading overlay
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'En attente';
      case OrderStatus.accepted:
        return 'Acceptée';
      case OrderStatus.completed:
        return 'Livrée';
      case OrderStatus.rejected:
        return 'Rejetée';
      default:
        return 'Inconnue';
    }
  }

  Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _callClient(String phoneNumber) async {
    try {
      // Clean the phone number
      String cleanedPhone = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');

      // Handle Moroccan numbers
      if (cleanedPhone.startsWith('+2120')) {
        cleanedPhone = cleanedPhone.replaceFirst('0', '');
      } else if (cleanedPhone.startsWith('0')) {
        cleanedPhone = '+212${cleanedPhone.substring(1)}';
      } else if (!cleanedPhone.startsWith('+')) {
        cleanedPhone = '+212$cleanedPhone';
      }

      final Uri uri = Uri(scheme: 'tel', path: cleanedPhone);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Impossible d\'appeler ce numéro')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
      }
    }
  }

  void _launchWhatsApp(BuildContext context, String phone) async {
    try {
      // Clean the phone number (remove any non-digit characters except +)
      String cleanedPhone = phone.replaceAll(RegExp(r'[^0-9+]'), '');

      // Handle Moroccan numbers specifically
      if (cleanedPhone.startsWith('+2120')) {
        cleanedPhone = cleanedPhone.replaceFirst('0', '');
      } else if (cleanedPhone.startsWith('0')) {
        cleanedPhone = '+212${cleanedPhone.substring(1)}';
      } else if (!cleanedPhone.startsWith('+')) {
        cleanedPhone = '+212$cleanedPhone';
      }

      final url = 'https://wa.me/$cleanedPhone';

      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Impossible d\'ouvrir WhatsApp')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
      }
    }
  }

  void _showExitWarning() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Action requise'),
          content: const Text(
            'Vous devez compléter ou rejeter cette commande avant de retourner à l\'écran précédent.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Compris'),
            ),
            TextButton(
              onPressed: () =>
                  _rejectOrder(context, widget.order.id.toString()),
              child: const Text(
                'Rejeter la commande',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showCommentDialog(String action) {
    final TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(action),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Commentaire (optionnel):'),
              const SizedBox(height: 16),
              TextField(
                controller: commentController,
                decoration: const InputDecoration(
                  hintText: 'Entrez un commentaire...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _processAction(action, commentController.text);
              },
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }

  void _processAction(String action, String comment) async {
    setState(() {
      isLoading = true;
    });

    try {
      if (action == 'Marquer comme livrée') {
        await _apiService.updateOrderStatus(
          widget.order.id.toString(),
          'completed',
          notes: comment,
        );
        _completeOrder('Commande marquée comme livrée');
      } else if (action == 'Annuler la commande') {
        await _apiService.updateOrderStatus(
          widget.order.id.toString(),
          'cancelled',
          notes: comment,
        );
        _completeOrder('Commande annulée');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _rejectOrder(BuildContext context, String orderId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String reason = '';

        return AlertDialog(
          title: const Text('Rejeter la commande'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Êtes-vous sûr de vouloir rejeter cette commande?'),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Raison (optionnel)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
                onChanged: (value) {
                  reason = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();

                // Call the actual API
                _updateOrderStatus(orderId, 'rejected', reason);
              },
              child: const Text('Rejeter', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateOrderStatus(
    String orderId,
    String status,
    String reason,
  ) async {
    try {
      setState(() {
        isLoading = true;
      });

      // Call the API service
      await _apiService.rejectOrder(orderId, reason);
      _completeOrder('Commande #$orderId rejetée');
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _completeOrder(String message) {
    if (mounted) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.green),
      );

      // Go back to previous screen with result to refresh the list
      Navigator.of(
        context,
      ).pop({'status': 'completed', 'orderId': widget.order.id.toString()});
    }
  }
}
