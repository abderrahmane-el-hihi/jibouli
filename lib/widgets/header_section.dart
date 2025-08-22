import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final double balance;
  final bool isAvailable;
  final ValueChanged<bool> onAvailabilityChanged;
  final VoidCallback onClientButtonPressed;

  const HeaderSection({
    super.key,
    required this.balance,
    required this.isAvailable,
    required this.onAvailabilityChanged,
    required this.onClientButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top row with client button and balance
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Client Button
              // GestureDetector(
              //   onTap: onClientButtonPressed,
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 15,
              //       vertical: 10,
              //     ),
              //     decoration: BoxDecoration(
              //       color: const Color(0xFF007BFF),
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     child: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         const Icon(
              //           Icons.person_add,
              //           color: Colors.white,
              //           size: 16,
              //         ),
              //         const SizedBox(width: 8),
              //         const Text(
              //           'Client',
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontWeight: FontWeight.w500,
              //             fontSize: 14,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              // Replace current client button with:
              ElevatedButton.icon(
                onPressed: onClientButtonPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007BFF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                icon: const Icon(Icons.person_add, size: 18),
                label: const Text(
                  'Nouveau Client',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),

              // Balance
              // Text(
              //   'Solde: ${balance.toStringAsFixed(2)} DH',
              //   style: const TextStyle(
              //     fontWeight: FontWeight.w600,
              //     fontSize: 16,
              //     color: Color(0xFF333333),
              //   ),
              // ),
              // Replace current balance text with:
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Solde: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xFF666666),
                      ),
                    ),
                    TextSpan(
                      text: '${balance.toStringAsFixed(2)} DH',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0xFF28A745), // Green for positive balance
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Availability Toggle Row
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     const Text(
          //       'Available:',
          //       style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
          //     ),
          //     const SizedBox(width: 10),
          //     Switch(
          //       value: isAvailable,
          //       onChanged: onAvailabilityChanged,
          //       activeColor: Colors.green,
          //       activeTrackColor: Colors.green.withOpacity(0.3),
          //     ),
          //   ],
          // ),
          // Replace current toggle with:
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isAvailable
                  ? Colors.green.withOpacity(0.1)
                  : Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isAvailable ? Colors.green : Colors.orange,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isAvailable ? Icons.check_circle : Icons.remove_circle,
                  size: 16,
                  color: isAvailable ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 6),
                Text(
                  isAvailable ? 'Disponible' : 'Indisponible',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isAvailable ? Colors.green : Colors.orange,
                  ),
                ),
                const SizedBox(width: 8),
                Switch(
                  value: isAvailable,
                  onChanged: onAvailabilityChanged,
                  activeColor: Colors.green,
                  activeTrackColor: Colors.green.withOpacity(0.3),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
