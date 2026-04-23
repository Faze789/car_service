class TourPackage {
  final String id;
  final String title;
  final String imagePath;
  final String priceType;
  double price;

  TourPackage({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.price,
    required this.priceType,
  });

  // Convert to Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imagePath': imagePath,
      'price': price,
      'priceType': priceType,
    };
  }

  // Create from Map for database retrieval
  factory TourPackage.fromMap(Map<String, dynamic> map) {
    return TourPackage(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      imagePath: map['imagePath'] ?? '',
      price: (map['price'] as num).toDouble(),
      priceType: map['priceType'] ?? '',
    );
  }
}