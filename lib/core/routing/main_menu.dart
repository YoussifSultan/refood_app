import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refood_app/core/config/globalvariables.dart';
import 'package:refood_app/core/constants/ui_constants.dart';
import 'package:refood_app/core/routing/app_routes.dart';
import 'package:refood_app/shared/scaffolds/primary_scaffold.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': Icons.receipt,
        'title': 'Offers',
        'children': [
          {
            'icon': Icons.add_circle_outline,
            'title': 'Add new Offer',
            'onTap': () async {
              Get.toNamed(AppRoutes.addNewOffer);
            },
          },
          {
            'icon': Icons.view_agenda_outlined,
            'title': 'View Offers',
            'onTap': () async {
              Get.toNamed(AppRoutes.viewOffers);
            },
          },
        ],
      },
      {
        'icon': Icons.logout_outlined,
        'title': 'Log out',
        'onTap': () async {
          Get.toNamed(AppRoutes.addNewOffer);
        },
      },
    ];

    return PrimaryScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with profile
              ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo_arabic.png'),
                ),
                title: Text(gc.currentUser!.username,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(gc.currentUser!.email,
                    style: const TextStyle(color: Colors.grey)),
                trailing: const Icon(Icons.chevron_right),
              ),
              const Divider(),
              // Menu Items
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];

                  // If item has children → make expandable
                  if (item.containsKey('children')) {
                    return ExpansionTile(
                      leading: Icon(item['icon'], color: AppColors.black),
                      title: Text(item['title']),
                      children: (item['children'] as List<Map<String, dynamic>>)
                          .map((child) => ListTile(
                                leading:
                                    Icon(child['icon'], color: AppColors.black),
                                title: Text(child['title']),
                                onTap: child['onTap'],
                              ))
                          .toList(),
                    );
                  }

                  // Normal non-expandable item
                  return Visibility(
                    visible: item['visible'] ?? true,
                    child: ListTile(
                      leading: Icon(item['icon'], color: AppColors.black),
                      title: Text(item['title']),
                      onTap: () {
                        item['onTap'] != null
                            ? item['onTap']()
                            : Get.snackbar('Info', 'Processing');
                      },
                    ),
                  );
                },
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
