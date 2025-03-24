class Promotion {
  final String code;
  final String title;
  final String description;
  final String type;
  final double value;
  final double minPurchaseAmount;
  final int usageLimit;
  final int usageCount;
  final bool isActive;
  final DateTime startDate;
  final DateTime endDate;
  final String imageUrl;

  Promotion({
    required this.code,
    required this.title,
    required this.description,
    required this.type,
    required this.value,
    required this.minPurchaseAmount,
    required this.usageLimit,
    required this.usageCount,
    required this.isActive,
    required this.startDate,
    required this.endDate,
    required this.imageUrl,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      code: json['code'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      value: double.parse(json['value'].toString()), // Conversion explicite
      minPurchaseAmount: double.parse(json['min_purchase_amount'].toString()), // Conversion explicite
      usageLimit: json['usage_limit'],
      usageCount: json['usage_count'],
      isActive: json['is_active'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      imageUrl: json['image_url'],
    );
  }
}