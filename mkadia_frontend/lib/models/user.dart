class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? address;
  final String? phone;
  final String? avatarURL;
  final List<String>? orders;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.address,
    this.phone,
    this.avatarURL,
    this.orders,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'client',
      address: json['address'],
      phone: json['phone'],
      avatarURL: json['avatarURL'],
      orders: json['orders'] != null ? List<String>.from(json['orders']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'address': address,
      'phone': phone,
      'avatarURL': avatarURL,
      'orders': orders,
    };
  }
}