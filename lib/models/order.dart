// import 'client.dart';

// enum OrderStatus {
//   pending,
//   accepted,
//   inProgress,
//   delivered,
//   canceled,
//   rejected,
// }

// class Order {
//   final int id;
//   final String clientId;
//   final String userId;
//   final int? deliveryPersonId;
//   OrderStatus status; // Remove 'final' to allow modification
//   final String request;
//   final String? clientNotes;
//   final String? userNotes;
//   final String? deliveryPersonNotes;
//   final DateTime? deliveredCanceledAt;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int? partnerId;
//   final Client client;

//   Order({
//     required this.id,
//     required this.clientId,
//     required this.userId,
//     this.deliveryPersonId,
//     required this.status,
//     required this.request,
//     this.clientNotes,
//     this.userNotes,
//     this.deliveryPersonNotes,
//     this.deliveredCanceledAt,
//     required this.createdAt,
//     required this.updatedAt,
//     this.partnerId,
//     required this.client,
//   });

//   factory Order.fromJson(Map<String, dynamic> json) {
//     // Debug: Print all keys and their types
//     print('=== DEBUG ORDER PARSING ===');
//     json.forEach((key, value) {
//       print('$key: $value (type: ${value?.runtimeType})');
//     });
//     print('==========================');
//     return Order(
//       id: json['id'] as int, // Server provides int
//       // clientId: json['client_id'] as int, // Server provides int
//       clientId: json['client_id'], // Server provides int
//       // userId: json['user_id'] as int, // Server provides int
//       userId: json['user_id'], // Server provides int
//       deliveryPersonId: json['delivery_person_id'] as int?, // Can be null
//       status: _parseStatus(json['status'] as String),
//       request: json['request'] as String,
//       clientNotes: json['client_notes'] as String?,
//       userNotes: json['user_notes'] as String?,
//       deliveryPersonNotes: json['delivery_person_notes'] as String?,
//       deliveredCanceledAt: json['delivered_canceled_at'] != null
//           ? DateTime.parse(json['delivered_canceled_at'] as String)
//           : null,
//       createdAt: DateTime.parse(json['created_at'] as String),
//       updatedAt: DateTime.parse(json['updated_at'] as String),
//       partnerId: json['partner_id'] as int?, // Can be null
//       client: Client.fromJson(json['client'] as Map<String, dynamic>),
//     );
//   }

//   static OrderStatus _parseStatus(String? status) {
    
//     switch (status?.toLowerCase()) {
//       case 'pending':
//         return OrderStatus.pending;
//       case 'accepted':
//         return OrderStatus.accepted;
//       case 'in_progress':
//       case 'inprogress':
//         return OrderStatus.inProgress;
//       case 'delivered':
//         return OrderStatus.delivered;
//       case 'canceled':
//       case 'cancelled':
//         return OrderStatus.canceled;
//       case 'rejected':
//         return OrderStatus.rejected;
//       default:
//         return OrderStatus.pending;
//     }
//   }

//   String get formattedCreatedAt {
//     return '${createdAt.day.toString().padLeft(2, '0')}/${createdAt.month.toString().padLeft(2, '0')}/${createdAt.year} ${createdAt.hour.toString().padLeft(2, '0')}:${createdAt.minute.toString().padLeft(2, '0')}';
//   }

//   String get orderNumber => 'Commande #$id';

//   bool get isPending => status == OrderStatus.pending;
//   bool get isActive =>
//       status == OrderStatus.accepted || status == OrderStatus.inProgress;
//   bool get isRejected => status == OrderStatus.rejected;
//   bool get isCompleted =>
//       status == OrderStatus.delivered || status == OrderStatus.canceled;

//   // Getter for client request (matches the server field name)
//   String get clientRequest => request;

//   // Getter for client address (from nested client object)
//   String get clientAddress => client.address;

//   // Getter for client name (from nested client object)
//   String get clientName => client.name;

//   // Getter for client phone (from nested client object)
//   String get clientPhone => client.phone;
// }
import 'client.dart';

enum OrderStatus {
  pending,
  accepted,
  inProgress,
  delivered,
  canceled,
  rejected,
}

class Order {
  final int id;
  final int clientId;
  final int userId;
  final int? deliveryPersonId;
  OrderStatus status;
  final String request;
  final String? clientNotes;
  final String? userNotes;
  final String? deliveryPersonNotes;
  final DateTime? deliveredCanceledAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? partnerId;
  final Client client;

  Order({
    required this.id,
    required this.clientId,
    required this.userId,
    this.deliveryPersonId,
    required this.status,
    required this.request,
    this.clientNotes,
    this.userNotes,
    this.deliveryPersonNotes,
    this.deliveredCanceledAt,
    required this.createdAt,
    required this.updatedAt,
    this.partnerId,
    required this.client,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    // Debug: Print the raw JSON to see the structure
    print('Order JSON: $json');
    
    return Order(
      id: _parseInt(json['id']),
      clientId: _parseInt(json['client_id']),
      userId: _parseInt(json['user_id']),
      deliveryPersonId: _parseNullableInt(json['delivery_person_id']),
      status: _parseStatus(_parseString(json['status'])),
      request: _parseString(json['request']),
      clientNotes: _parseNullableString(json['client_notes']),
      userNotes: _parseNullableString(json['user_notes']),
      deliveryPersonNotes: _parseNullableString(json['delivery_person_notes']),
      deliveredCanceledAt: _parseNullableDateTime(json['delivered_canceled_at']),
      createdAt: _parseDateTime(json['created_at']),
      updatedAt: _parseDateTime(json['updated_at']),
      partnerId: _parseNullableInt(json['partner_id']),
      client: Client.fromJson(_parseMap(json['client'])),
    );
  }

  // Helper methods
  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.toInt();
    return 0;
  }

  static int? _parseNullableInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    if (value is double) return value.toInt();
    return null;
  }

  static String _parseString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    if (value is int) return value.toString();
    if (value is double) return value.toString();
    if (value is bool) return value.toString();
    return '';
  }

  static String? _parseNullableString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is int) return value.toString();
    if (value is double) return value.toString();
    if (value is bool) return value.toString();
    return null;
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is DateTime) return value;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        print('Failed to parse DateTime: $value');
        return DateTime.now();
      }
    }
    return DateTime.now();
  }

  static DateTime? _parseNullableDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        print('Failed to parse nullable DateTime: $value');
        return null;
      }
    }
    return null;
  }

  static Map<String, dynamic> _parseMap(dynamic value) {
    if (value == null) return {};
    if (value is Map<String, dynamic>) return value;
    if (value is Map<dynamic, dynamic>) {
      return value.map((key, value) => MapEntry(key.toString(), value));
    }
    return {};
  }

  static OrderStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return OrderStatus.pending;
      case 'accepted':
        return OrderStatus.accepted;
      case 'in_progress':
      case 'inprogress':
        return OrderStatus.inProgress;
      case 'delivered':
        return OrderStatus.delivered;
      case 'canceled':
      case 'cancelled':
        return OrderStatus.canceled;
      case 'rejected':
        return OrderStatus.rejected;
      default:
        return OrderStatus.pending;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': clientId,
      'user_id': userId,
      'delivery_person_id': deliveryPersonId,
      'status': _statusToString(status),
      'request': request,
      'client_notes': clientNotes,
      'user_notes': userNotes,
      'delivery_person_notes': deliveryPersonNotes,
      'delivered_canceled_at': deliveredCanceledAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'partner_id': partnerId,
      'client': client.toJson(),
    };
  }

  static String _statusToString(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'pending';
      case OrderStatus.accepted:
        return 'accepted';
      case OrderStatus.inProgress:
        return 'in_progress';
      case OrderStatus.delivered:
        return 'delivered';
      case OrderStatus.canceled:
        return 'canceled';
      case OrderStatus.rejected:
        return 'rejected';
    }
  }

  @override
  String toString() {
    return 'Order{id: $id, clientId: $clientId, status: $status}';
  }
}