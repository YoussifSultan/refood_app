import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refood_app/core/config/globalvariables.dart';
import 'package:refood_app/core/constants/sharedpreferences.dart';
import 'package:refood_app/core/routing/app_routes.dart';
import 'package:refood_app/core/routing/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 3)); // ⏱️ Splash delay

    final isLoggedIn = prefs.getBool(SharedPrefsKeys.isLoggedIn) ?? false;
    if (!isLoggedIn) {
      Get.offAndToNamed(AppRoutes.loginPage);
      return;
    }
    final email = prefs.getString(SharedPrefsKeys.userEmail) ?? '';
    int id = prefs.getInt(SharedPrefsKeys.userId) ?? 0;
    final name = prefs.getString(SharedPrefsKeys.username) ?? '';
    gc.currentUser = User(id: id, username: name, email: email);

    Get.offAndToNamed(AppRoutes.viewOffers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // Background Image
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splash_bg.png"), // Your image
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Semi-transparent overlay (optional for better contrast)
        Container(
          color: Colors.black.withOpacity(0.4),
        ),
        Center(
          child: Container(
            width: 300,
            alignment: Alignment.topCenter,
            height: 150,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage("assets/images/company_logo.png"), // Your image
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
