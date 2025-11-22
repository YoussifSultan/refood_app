class OfferViewModel {
  final int id;
  final String name;
  final double price;
  final double orginalPrice;
  final bool isFree;
  final List<String> gallery;
  final double longitude;
  final double latitude;
  final int likes;
  final String status;
  final int views;

  OfferViewModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.isFree,
      this.gallery = const [],
      required this.status,
      this.likes = 0,
      this.views = 0,
      this.orginalPrice = 0,
      this.latitude = 0,
      this.longitude = 0});

  /// Create ViewModel directly from JSON
  factory OfferViewModel.fromJson(Map<String, dynamic> json) {
    try {
      return OfferViewModel(
          id: int.parse(json['id']) ?? 0,
          name: json['food_name'] ?? '',
          price: json['offer_price'] ?? 0.0,
          isFree: json['is_free'] == 0 ? false : true,
          gallery: json['gallery'].toString().split(","),
          likes: json['likes_count'] ?? 0,
          views: json['views_count'] ?? 0,
          longitude: json['longitude'] ?? 0,
          latitude: json['latitude'] ?? 0,
          orginalPrice: json['original_price'] ?? 0,
          status: json["status"] ?? "");
    } catch (e) {
      print(e);
      throw new Exception(e);
    }
  }

  /// Convert ViewModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'isFree': isFree,
      'imageUrl': gallery,
      'likes': likes,
      'views': views,
    };
  }
}
