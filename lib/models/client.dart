// class Client {
//   final int id; // Server always provides this
//   final String name;
//   final String phone;
//   final String address;
//   final int addedBy; // Server always provides this
//   final DateTime? deletedAt;
//   final DateTime createdAt; // Server always provides this
//   final DateTime updatedAt; // Server always provides this

//   Client({
//     required this.id,
//     required this.name,
//     required this.phone,
//     required this.address,
//     required this.addedBy,
//     this.deletedAt,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Client.fromJson(Map<String, dynamic> json) {
//     return Client(
//       id: json['id'] as int, // Server provides int
//       name: json['client_name'] as String,
//       phone: json['client_phone'] as String,
//       address: json['client_address'] as String,
//       addedBy: json['added_by'] as int, // Server provides int
//       deletedAt: json['deleted_at'] != null
//           ? DateTime.parse(json['deleted_at'] as String)
//           : null,
//       createdAt: DateTime.parse(json['created_at'] as String),
//       updatedAt: DateTime.parse(json['updated_at'] as String),
//     );
//   }

//   // Factory for creating new clients (when sending to server)
//   factory Client.createNew({
//     required String name,
//     required String phone,
//     required String address,
//     int? addedBy,
//   }) {
//     final now = DateTime.now();
//     return Client(
//       id: 0, // Will be assigned by server
//       name: name,
//       phone: phone,
//       address: address,
//       addedBy: addedBy ?? 0,
//       createdAt: now,
//       updatedAt: now,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'client_name': name,
//       'client_phone': phone,
//       'client_address': address,
//       'added_by': addedBy,
//       'deleted_at': deletedAt?.toIso8601String(),
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(),
//     };
//   }
// }

// class Client {
//   final int id;
//   final String name;
//   final String phone;
//   final String address;
//   final int addedBy;
//   final DateTime? deletedAt;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   Client({
//     required this.id,
//     required this.name,
//     required this.phone,
//     required this.address,
//     required this.addedBy,
//     this.deletedAt,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Client.fromJson(Map<String, dynamic> json) {
//     // Debug: Print the JSON to see what we're getting
//     print('Client JSON: $json');
    
//     return Client(
//       id: _parseInt(json['id']),
//       name: _parseString(json['client_name']),
//       phone: _parseString(json['client_phone']),
//       address: _parseString(json['client_address']),
//       addedBy: _parseInt(json['added_by']),
//       deletedAt: _parseNullableDateTime(json['deleted_at']),
//       createdAt: _parseDateTime(json['created_at']),
//       updatedAt: _parseDateTime(json['updated_at']),
//     );
//   }

//   // Helper methods for safe parsing
//   static int _parseInt(dynamic value) {
//     if (value == null) return 0;
//     if (value is int) return value;
//     if (value is String) return int.tryParse(value) ?? 0;
//     if (value is double) return value.toInt();
//     return 0;
//   }

//   static String _parseString(dynamic value) {
//     if (value == null) return '';
//     if (value is String) return value;
//     if (value is int) return value.toString();
//     if (value is double) return value.toString();
//     if (value is bool) return value.toString();
//     return '';
//   }

//   static DateTime _parseDateTime(dynamic value) {
//     if (value is DateTime) return value;
//     if (value is String) {
//       try {
//         return DateTime.parse(value);
//       } catch (e) {
//         print('Failed to parse DateTime: $value');
//         return DateTime.now();
//       }
//     }
//     return DateTime.now();
//   }

//   static DateTime? _parseNullableDateTime(dynamic value) {
//     if (value == null) return null;
//     if (value is DateTime) return value;
//     if (value is String) {
//       try {
//         return DateTime.parse(value);
//       } catch (e) {
//         print('Failed to parse nullable DateTime: $value');
//         return null;
//       }
//     }
//     return null;
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'client_name': name,
//       'client_phone': phone,
//       'client_address': address,
//       'added_by': addedBy,
//       'deleted_at': deletedAt?.toIso8601String(),
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(),
//     };
//   }

//   @override
//   String toString() {
//     return 'Client{id: $id, name: $name, phone: $phone}';
//   }
// }




class Client {
  final int id;
  final String name;
  final String phone;
  final String address;
  final int addedBy;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Client({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.addedBy,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  // Add this factory constructor
  factory Client.createNew({
    required String name,
    required String phone,
    required String address,
    required int addedBy,
  }) {
    final now = DateTime.now();
    return Client(
      id: 0, // Will be assigned by server
      name: name,
      phone: phone,
      address: address,
      addedBy: addedBy,
      createdAt: now,
      updatedAt: now,
    );
  }

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: _parseInt(json['id']),
      name: _parseString(json['client_name']),
      phone: _parseString(json['client_phone']),
      address: _parseString(json['client_address']),
      addedBy: _parseInt(json['added_by']),
      deletedAt: _parseNullableDateTime(json['deleted_at']),
      createdAt: _parseDateTime(json['created_at']),
      updatedAt: _parseDateTime(json['updated_at']),
    );
  }

  // Helper methods for safe parsing
  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.toInt();
    return 0;
  }

  static String _parseString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    if (value is int) return value.toString();
    if (value is double) return value.toString();
    if (value is bool) return value.toString();
    return '';
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is DateTime) return value;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
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
        return null;
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_name': name,
      'client_phone': phone,
      'client_address': address,
      'added_by': addedBy,
      'deleted_at': deletedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Client{id: $id, name: $name, phone: $phone, address: $address}';
  }
}