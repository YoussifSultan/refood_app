import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refood_app/core/routing/app_routes.dart';
import 'package:refood_app/features/offers/data/offer_sql.dart';
import 'package:refood_app/features/offers/viewmodels/offer_vm.dart';
import 'package:refood_app/shared/scaffolds/primary_scaffold.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late Position userLocation;
  @override
  void initState() {
    super.initState();
  }

  Future<List<OfferViewModel>> initializeOffers() async {
    await getUserLocation().then((value) => userLocation = value);

    return await OfferSql.fetchAllOfferVM();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildTabButton('All', true),
                const SizedBox(width: 16),
                _buildTabButton('Popular', false),
                const SizedBox(width: 16),
                _buildTabButton('Sides', false),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Food list
          FutureBuilder(
              future: initializeOffers(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  return Text("No Offers");
                }
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final food = snapshot.data![index];
                      return FoodCard(
                        id: food.id,
                        name: food.name,
                        price: food.price.toString(),
                        likes: food.likes,
                        views: food.views,
                        isFree: food.isFree,
                        distance: calculateDistance(
                            userLocation.latitude,
                            userLocation.longitude,
                            food.latitude,
                            food.longitude),
                        imageUrl: food.gallery.first,
                      );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, bool selected) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: selected ? Colors.brown.shade100 : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: () {},
      child: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.brown : Colors.black87,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  /// Calculates the distance (in kilometers) between two coordinates
  /// using the Haversine formula.
  double calculateDistance(
      double userLat, double userLon, double locationLat, double locationLon) {
    const double earthRadius = 6371; // Radius of the Earth in km

    double dLat = _degreesToRadians(locationLat - userLat);
    double dLon = _degreesToRadians(locationLon - userLon);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(userLat)) *
            cos(_degreesToRadians(locationLat)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;
    return distance;
  }

  /// Helper function to convert degrees to radians
  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  Future<Position> getUserLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, request user to enable
      throw Exception('Location services are disabled.');
    }

    // Check and request permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      throw Exception(
          'Location permissions are permanently denied, cannot request.');
    }

    // Get current position
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}

class FoodCard extends StatelessWidget {
  final int id;
  final String name;
  final int likes;
  final int views;
  final String price;
  final double distance;
  final String imageUrl;
  final bool isFree;

  const FoodCard({
    required this.id,
    required this.name,
    required this.price,
    required this.distance,
    required this.imageUrl,
    required this.likes,
    required this.views,
    this.isFree = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to offer detail page with GetX
        Get.toNamed(AppRoutes.viewOfferDetails, arguments: id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with price / free badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Hero(
                    tag: id,
                    child: Image.network(
                      imageUrl,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Price Badge
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isFree ? Colors.green : Colors.brown,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Text(
                      isFree ? "Free" : price,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
            // Text Info
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  // Distance
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(distance.toString(),
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Likes and Views
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.thumb_up_alt_outlined,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text('$likes',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Row(
                        children: [
                          const Icon(Icons.remove_red_eye_outlined,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text('$views',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
