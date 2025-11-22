import 'package:get/get.dart';
import 'package:refood_app/core/routing/main_menu.dart';
import 'package:refood_app/features/offers/presentation/add_offer.dart';
import 'package:refood_app/features/offers/presentation/dashboard.dart';
import 'package:refood_app/features/offers/presentation/offer_details.dart';

class AppRoutes {
  // Orders
  static const String addNewOffer = '/offers/add/';
  static const String viewOffers = '/offers/';
  static const String viewOfferDetails = '/offer/details';
  static const String mainmenu = '/mainmenu/';
  static const String loginPage = '/login/';

  static final pages = [
    GetPage(
        name: viewOffers,
        transition: Transition.fadeIn,
        page: () => const HomeScreen()),
    GetPage(
        name: addNewOffer,
        transition: Transition.fadeIn,
        page: () => const AddOfferPage()),
    GetPage(
        name: mainmenu,
        transition: Transition.fadeIn,
        page: () => const MainMenuPage()),
    GetPage(
        name: loginPage,
        transition: Transition.fadeIn,
        page: () => const HomeScreen()),
    GetPage(
        name: viewOfferDetails,
        transition: Transition.fadeIn,
        page: () => const OfferDetailPage()),
  ];
}
