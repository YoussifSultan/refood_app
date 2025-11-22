import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:refood_app/core/routing/user.dart';

class GlobalController extends GetxController {
  // RxString apiLink = "https://restapi-production-e4e5.up.railway.app/".obs;
  User? currentUser;
  RxString apiLink = "https://restapi-development.up.railway.app/".obs;
  bool developmentMode = false;
  RxString apiKey = dotenv.env["API_KEY"]!.obs;
}

final GlobalController gc = Get.put(GlobalController());
