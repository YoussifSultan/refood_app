import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:refood_app/features/offers/data/offer_sql.dart';
import 'package:refood_app/features/offers/models/offer.dart';

class OfferDetailPage extends StatefulWidget {
  const OfferDetailPage({
    super.key,
  });

  @override
  State<OfferDetailPage> createState() => _OfferDetailPageState();
}

class _OfferDetailPageState extends State<OfferDetailPage> {
  int selectedID = 0;
  Future<Offer> getOfferDetails() async {
    return await OfferSql.fetchOfferDetails(selectedID);
  }

  Offer selectedOffer = Offer(id: "0", foodName: "dd");
  @override
  void initState() {
    super.initState();
    selectedID = Get.arguments;
  }

  // helper to get gallery list

  int quantity = 1;
  bool liked = false;
  int galleryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: getOfferDetails(),
            builder: (context, snapshot) {
              return Column(
                children: [
                  // Top image + back + cart
                  Stack(
                    children: [
                      // Image carousel mimic (single large image)
                      Container(
                        height: 260,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                          child: gallery.isNotEmpty
                              ? Image.network(
                                  gallery[galleryIndex],
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) => Center(
                                      child: Icon(Icons.fastfood, size: 72)),
                                )
                              : Center(child: Icon(Icons.fastfood, size: 72)),
                        ),
                      ),

                      Positioned(
                        left: 12,
                        top: 12,
                        child: CircleAvatar(
                          backgroundColor: Colors.white70,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.black87),
                            onPressed: () => Navigator.of(context).maybePop(),
                          ),
                        ),
                      ),

                      Positioned(
                        right: 12,
                        top: 12,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white70,
                              child: IconButton(
                                icon: Icon(Icons.shopping_cart_outlined,
                                    color: Colors.black87),
                                onPressed: () {},
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text('3',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10)),
                              ),
                            )
                          ],
                        ),
                      ),

                      // heart like
                      Positioned(
                        right: 20,
                        bottom: 12,
                        child: GestureDetector(
                          onTap: () => setState(() => liked = !liked),
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.white,
                            child: Icon(
                                liked ? Icons.favorite : Icons.favorite_border,
                                color: liked ? Colors.red : Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Details card
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(offer.foodName,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: Colors.amber, size: 18),
                                        SizedBox(width: 6),
                                        Text('4.8',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600)),
                                        SizedBox(width: 6),
                                        Text('(59 ratings)',
                                            style:
                                                TextStyle(color: Colors.grey)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // price and quantity control
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('N${offer.offerPrice?.toInt() ?? 0}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 8),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: Colors.orange.shade50,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          iconSize: 18,
                                          padding: EdgeInsets.zero,
                                          onPressed: () => setState(() =>
                                              quantity =
                                                  (quantity - 1).clamp(1, 99)),
                                          icon: Icon(
                                              Icons.remove_circle_outline,
                                              color: Colors.orange),
                                        ),
                                        SizedBox(width: 6),
                                        Text('$quantity',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(width: 6),
                                        IconButton(
                                          iconSize: 18,
                                          padding: EdgeInsets.zero,
                                          onPressed: () => setState(() =>
                                              quantity =
                                                  (quantity + 1).clamp(1, 99)),
                                          icon: Icon(Icons.add_circle_outline,
                                              color: Colors.orange),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: 12),
                          Text('Description',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text(offer.description ?? '',
                              style: TextStyle(color: Colors.grey[800])),

                          SizedBox(height: 16),
                          Text('Recommended sides',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          SizedBox(
                            height: 100,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                _sideItem(
                                    'Fried plantain',
                                    'file:///mnt/data/f4ac7a8a-cd96-4bcd-abe9-ccecbbe36797.png',
                                    'N300'),
                                _sideItem('Coleslaw',
                                    'https://via.placeholder.com/120', 'N800'),
                                _sideItem('Fried Chicken',
                                    'https://via.placeholder.com/120', 'N900'),
                              ],
                            ),
                          ),

                          SizedBox(height: 16),

                          // Ratings & Review row (mimic)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Ratings & Reviews',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text('SEE ALL',
                                  style: TextStyle(color: Colors.orange)),
                            ],
                          ),

                          SizedBox(height: 16),

                          // Map + location
                          Text('Pickup Location',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Container(
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey.shade200,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: offer.latitude != null &&
                                      offer.longitude != null
                                  ? GoogleMap(
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                            offer.latitude!, offer.longitude!),
                                        zoom: 13,
                                      ),
                                      markers: {
                                        Marker(
                                          markerId: MarkerId('pickup'),
                                          position: LatLng(offer.latitude!,
                                              offer.longitude!),
                                          infoWindow: InfoWindow(
                                              title: offer.pickupLocationName ??
                                                  offer.city),
                                        )
                                      },
                                      onMapCreated: (controller) =>
                                          _mapController = controller,
                                    )
                                  : Center(
                                      child: Text('Location not available')),
                            ),
                          ),

                          SizedBox(height: 24),
                          SizedBox(height: 60),
                        ],
                      ),
                    ),
                  ),

                  // Bottom summary bar
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, -2))
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Total: N${(offer.offerPrice ?? 0 * quantity).toInt()}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              Text('Quantity: $quantity',
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 12)),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.shopping_cart_outlined),
                          label: Text('Add to Cart'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }

  Widget _sideItem(String title, String imageUrl, String price) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Container(
        width: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) =>
                      Center(child: Icon(Icons.fastfood)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: Text(title, style: TextStyle(fontSize: 12))),
                  Text(price,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*
Notes:
- This single-file example uses google_maps_flutter. Add the package in your pubspec.yaml:
  google_maps_flutter: ^2.2.0

- To use GoogleMap widget you must add and configure API keys for Android and iOS.
  If you don't need a real map, replace the GoogleMap widget with an Image.network of a static map.

- The sample gallery contains the image path you uploaded: file:///mnt/data/f4ac7a8a-cd96-4bcd-abe9-ccecbbe36797.png
  The runner that integrates this code will transform the local path to a URL if necessary.

- This code aims to closely mimic the provided screenshot while exposing every Offer property via the Offer model.
*/

