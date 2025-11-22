import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refood_app/core/routing/app_routes.dart';
import 'package:refood_app/core/routing/bottom_navbar.dart';
import 'package:refood_app/features/offers/presentation/dashboard.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  Get.put(NavController());
  runApp(const Refood_App());
}

class Refood_App extends StatelessWidget {
  const Refood_App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // ✅ Change here
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F5EE),
        fontFamily: 'Poppins',
      ),
      initialRoute: AppRoutes.viewOffers,
      getPages: AppRoutes.pages,
    );
  }
}
