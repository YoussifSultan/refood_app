import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:refood_app/core/constants/ui_constants.dart';

class SecondaryScaffold extends StatelessWidget {
  const SecondaryScaffold(
      {super.key, required this.body, required this.title, this.onRefresh});
  final Widget body;
  final String title;
  final Function? onRefresh;
  @override
  Widget build(BuildContext context) {
    // Debugging line to check current route name
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.light,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        titleSpacing: 8,
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: AppColors.black,
            ),
            onPressed: () => onRefresh == null ? () {} : onRefresh!(),
          ),
        ],
      ),
      body: body,
    );
  }
}
