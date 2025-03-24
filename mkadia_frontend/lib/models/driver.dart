class Driver {
  final String id;
  final String name;
  final String phone;
  final double latitude;
  final double longitude;

  Driver({
    required this.id,
    required this.name,
    required this.phone,
    required this.latitude,
    required this.longitude,
  });
}

final List<Driver> drivers = [
  Driver(
    id: "D001",
    name: "Ali Mohamed",
    phone: "0600000000",
    latitude: 34.0522,
    longitude: -118.2437,
  ),
  Driver(
    id: "D002",
    name: "Sara Ben",
    phone: "0611111111",
    latitude: 40.7128,
    longitude: -74.0060,
  ),
];