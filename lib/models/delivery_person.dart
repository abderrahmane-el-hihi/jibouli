class DeliveryPerson {
  final int id;
  final String name;
  final String phone;
  bool isAvailable;
  double balance;
  final double? latitude;
  final double? longitude;
  final int userId;
  final String? createdAt;
  final String? updatedAt;
  final List<dynamic> activeOrders;

  DeliveryPerson({
    required this.id,
    required this.name,
    required this.phone,
    required this.isAvailable,
    required this.balance,
    this.latitude,
    this.longitude,
    required this.userId,
    this.createdAt,
    this.updatedAt,
    required this.activeOrders,
  });

  factory DeliveryPerson.fromJson(Map<String, dynamic> json) {
    return DeliveryPerson(
      id: json['delivery_person']['id'],
      name: json['delivery_person']['delivery_person_name'],
      phone: json['delivery_person']['delivery_phone'],
      isAvailable: json['delivery_person']['is_available'] == '1',
      balance: double.parse(json['balance']),
      latitude: json['delivery_person']['latitude'] != null
          ? double.parse(json['delivery_person']['latitude'])
          : null,
      longitude: json['delivery_person']['longitude'] != null
          ? double.parse(json['delivery_person']['longitude'])
          : null,
      userId: int.parse(json['delivery_person']['user_id']),
      createdAt: json['delivery_person']['created_at'],
      updatedAt: json['delivery_person']['updated_at'],
      activeOrders: json['active_orders'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'delivery_person': {
        'id': id,
        'delivery_person_name': name,
        'delivery_phone': phone,
        'is_available': isAvailable ? '1' : '0',
        'balance': balance.toString(),
        'latitude': latitude?.toString(),
        'longitude': longitude?.toString(),
        'user_id': userId.toString(),
        'created_at': createdAt,
        'updated_at': updatedAt,
      },
      'active_orders': activeOrders,
      'balance': balance.toString(),
    };
  }
}
