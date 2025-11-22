import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refood_app/core/routing/app_routes.dart';

class BottomNavbar extends StatelessWidget {
  BottomNavbar({super.key});

  final NavController navController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF795548),
        unselectedItemColor: Colors.grey,
        currentIndex: navController.selectedIndex.value,
        onTap: (value) {
          navController.changePage(value);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: 'Pickup'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}

class NavController extends GetxController {
  var selectedIndex = 0.obs;

  final List<String> pages = [
    AppRoutes.viewOffers,
    AppRoutes.addNewOffer,
    AppRoutes.viewOffers,
    AppRoutes.addNewOffer,
    AppRoutes.viewOffers,
  ];

  void changePage(int index) {
    selectedIndex.value = index;
    Get.offAndToNamed(pages[index]); // Replace navigation
  }
}
