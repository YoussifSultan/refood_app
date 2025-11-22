class Offer {
  final String id;
  final String foodName;
  final String? category;
  final String? description;
  final int quantity;
  final String? unit;
  final DateTime? expiryDate;
  final DateTime? postedDate;
  final DateTime? availableUntil;
  final double? originalPrice;
  final double? offerPrice;
  final double? discountPercentage;
  final bool isFree;
  final String? pickupLocationName;
  final String? address;
  final String? city;
  final String? country;
  final double? latitude;
  final double? longitude;
  final DateTime? pickupStartTime;
  final DateTime? pickupEndTime;
  final String? sellerId;
  final String? sellerName;
  final bool verifiedSeller;
  final String? gallery; // comma-separated URLs
  final int likesCount;
  final int viewsCount;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Offer({
    required this.id,
    required this.foodName,
    this.category,
    this.description,
    this.quantity = 1,
    this.unit,
    this.expiryDate,
    this.postedDate,
    this.availableUntil,
    this.originalPrice,
    this.offerPrice,
    this.discountPercentage,
    this.isFree = false,
    this.pickupLocationName,
    this.address,
    this.city,
    this.country,
    this.latitude,
    this.longitude,
    this.pickupStartTime,
    this.pickupEndTime,
    this.sellerId,
    this.sellerName,
    this.verifiedSeller = false,
    this.gallery,
    this.likesCount = 0,
    this.viewsCount = 0,
    this.status = 'active',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  // JSON serialization
  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      foodName: json['food_name'],
      category: json['category'],
      description: json['description'],
      quantity: json['quantity'] ?? 1,
      unit: json['unit'],
      expiryDate: json['expiry_date'] != null
          ? DateTime.parse(json['expiry_date'])
          : null,
      postedDate: json['posted_date'] != null
          ? DateTime.parse(json['posted_date'])
          : null,
      availableUntil: json['available_until'] != null
          ? DateTime.parse(json['available_until'])
          : null,
      originalPrice: (json['original_price'] != null)
          ? (json['original_price'] as num).toDouble()
          : null,
      offerPrice: (json['offer_price'] != null)
          ? (json['offer_price'] as num).toDouble()
          : null,
      discountPercentage: (json['discount_percentage'] != null)
          ? (json['discount_percentage'] as num).toDouble()
          : null,
      isFree: json['is_free'] == 1 ? true : false,
      pickupLocationName: json['pickup_location_name'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
      latitude: (json['latitude'] != null)
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: (json['longitude'] != null)
          ? (json['longitude'] as num).toDouble()
          : null,
      pickupStartTime: json['pickup_start_time'] != null
          ? DateTime.parse(json['pickup_start_time'])
          : null,
      pickupEndTime: json['pickup_end_time'] != null
          ? DateTime.parse(json['pickup_end_time'])
          : null,
      sellerId: json['seller_id'],
      sellerName: json['seller_name'],
      verifiedSeller: json['verified_seller'] == 1 ? true : false,
      gallery: json['gallery'],
      likesCount: json['likes_count'] ?? 0,
      viewsCount: json['views_count'] ?? 0,
      status: json['status'] ?? 'active',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
    );
  }
  List<String> galleryList() {
    if (gallery == null || gallery!.trim().isEmpty) return [];
    return gallery!.split(',').map((s) => s.trim()).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'food_name': foodName,
      'category': category,
      'description': description,
      'quantity': quantity,
      'unit': unit,
      'expiry_date': expiryDate?.toIso8601String(),
      'posted_date': postedDate?.toIso8601String(),
      'available_until': availableUntil?.toIso8601String(),
      'original_price': originalPrice,
      'offer_price': offerPrice,
      'discount_percentage': discountPercentage,
      'is_free': isFree,
      'pickup_location_name': pickupLocationName,
      'address': address,
      'city': city,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'pickup_start_time': pickupStartTime?.toIso8601String(),
      'pickup_end_time': pickupEndTime?.toIso8601String(),
      'seller_id': sellerId,
      'seller_name': sellerName,
      'verified_seller': verifiedSeller,
      'gallery': gallery,
      'likes_count': likesCount,
      'views_count': viewsCount,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
