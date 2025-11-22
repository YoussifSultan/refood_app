import 'package:http/http.dart' as http;
import 'package:refood_app/core/config/globalvariables.dart';
import 'dart:convert';

import 'package:refood_app/features/offers/models/offer.dart';
import 'package:refood_app/features/offers/viewmodels/offer_vm.dart';

class OfferSql {
  static Future<Offer> fetchOfferDetails(int offerID) async {
    final url = Uri.parse('${gc.apiLink.value}get');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': gc.apiKey.value
      },
      body: jsonEncode({
        'query': '''
select * from offers where id = $offerID
'''
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Offer.fromJson(data[0]);
    } else {
      return Future.error('Failed to load data');
    }
  }

  static Future<List<OfferViewModel>> fetchAllOfferVM() async {
    final url = Uri.parse('${gc.apiLink.value}get');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': gc.apiKey.value
      },
      body: jsonEncode({
        'query': '''
SELECT 
   id,food_name,offer_price,is_free,original_price,latitude,longitude,gallery,likes_count,views_count,status
FROM
    offers o
where status = "active"
ORDER BY expiry_date DESC

Limit 100
'''
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List.generate(data.length, (i) {
        return OfferViewModel.fromJson(data[i]);
      });
    } else {
      return Future.error('Failed to load data');
    }
  }

  /// Fetches orders from the database and returns a list of Order objects.
  static Future<List<OfferViewModel>> filterOffers(
      String status,
      double? maxPrice,
      double? minPrice,
      String? city,
      String? category,
      String? verifiedSeller,
      DateTime? startDate,
      DateTime? endDate) async {
    final url = Uri.parse('${gc.apiLink.value}get');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': gc.apiKey.value
      },
      body: jsonEncode({
        'query': '''
SELECT 
    id,
    food_name,
    offer_price,
    is_free,
    original_price,
    latitude,
    longitude,
    gallery,
    likes_count,
    views_count,
    status,
    city,
    category,
    verified_seller,
    expiry_date
FROM offers o
WHERE 1=1
    -- Status filter (optional)
    AND ( $status IS NULL OR status = $status )
    
    -- Maximum price filter (optional)
    AND ( $maxPrice IS NULL OR offer_price <= ? $maxPrice)
    
    -- Minimum price filter (optional)
    AND ( $minPrice IS NULL OR offer_price >= $minPrice )

    -- City filter (optional)
    AND ( $city IS NULL OR city = $city )
    
    -- Category filter (optional)
    AND ( $category IS NULL OR category = $category )
    
    -- Verified seller filter (optional)
    AND ( $verifiedSeller IS NULL OR verified_seller = $verifiedSeller )

    -- Expiry date range filter (optional)
    AND ( $startDate IS NULL OR expiry_date >= $startDate )
    AND ( $endDate IS NULL OR expiry_date <= $endDate )
    
ORDER BY expiry_date DESC
LIMIT 100;
''',
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List.generate(data.length, (i) {
        return OfferViewModel.fromJson(data[i]);
      });
    } else {
      return Future.error('Failed to load data');
    }
  }

  /// Saves a new order to the database.
  /// Returns the ressponse code from the server.'
  /// order should be an instance of Order class.
  static Future<http.Response> addnewOffer(Offer offer) async {
    final url = Uri.parse('${gc.apiLink.value}execute');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': gc.apiKey.value
      },
      body: jsonEncode({
        'query': '''


INSERT INTO offers (
  id, food_name, category, description, quantity, unit, expiry_date, posted_date, available_until,
  original_price, offer_price, discount_percentage, is_free, pickup_location_name, address, city, country,
  latitude, longitude, pickup_start_time, pickup_end_time, seller_id, seller_name, verified_seller,
  gallery, likes_count, views_count, status, created_at, updated_at
) VALUES (
  '${offer.id}',
  '${offer.foodName}',
  '${offer.category ?? ''}',
  '${offer.description ?? ''}',
  ${offer.quantity},
  '${offer.unit ?? ''}',
  ${offer.expiryDate != null ? "'${offer.expiryDate!.toIso8601String()}'" : 'NULL'},
  ${offer.postedDate != null ? "'${offer.postedDate!.toIso8601String()}'" : 'NULL'},
  ${offer.availableUntil != null ? "'${offer.availableUntil!.toIso8601String()}'" : 'NULL'},
  ${offer.originalPrice ?? 0},
  ${offer.offerPrice ?? 0},
  ${offer.discountPercentage ?? 0},
  ${offer.isFree == true ? 1 : 0},
  '${offer.pickupLocationName ?? ''}',
  '${offer.address ?? ''}',
  '${offer.city ?? ''}',
  '${offer.country ?? ''}',
  ${offer.latitude ?? 0},
  ${offer.longitude ?? 0},
  ${offer.pickupStartTime != null ? "'${offer.pickupStartTime!.toIso8601String()}'" : 'NULL'},
  ${offer.pickupEndTime != null ? "'${offer.pickupEndTime!.toIso8601String()}'" : 'NULL'},
  '${offer.sellerId ?? ''}',
  '${offer.sellerName ?? ''}',
  ${offer.verifiedSeller == true ? 1 : 0},
  '${offer.gallery ?? ''}',
  ${offer.likesCount},
  ${offer.viewsCount},
  '${offer.status}',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
);
''',
      }),
    );
    return response;
  }

  /// Edits the existing order in the database.
  /// Returns the response code from the server.
  static Future<int> editOffer(Offer offer) async {
    deleteOrder(offer.id as int);
    addnewOffer(offer);
    return 200;
  }

  /// Deletes an order from the database.
  /// Returns the response code from the server.
  static Future<int> deleteOrder(int offerID) async {
    final url = Uri.parse('${gc.apiLink.value}delete');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': gc.apiKey.value
      },
      body: jsonEncode({
        'query': '''
Delete from offers where id = $offerID;
''',
      }),
    );
    if (response.statusCode == 200) {
      return 200; // Assuming 200 is the success code
    } else {
      return response.statusCode;
    }
  }
}
