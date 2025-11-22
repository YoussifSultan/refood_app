import 'package:flutter/material.dart';
import 'package:refood_app/core/routing/bottom_navbar.dart';

class PrimaryScaffold extends StatelessWidget {
  const PrimaryScaffold({super.key, required this.body, this.onRefresh});
  final Widget body;
  final Function? onRefresh;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Refood App',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
              radius: 18,
            ),
          )
        ],
      ),
      body: body,
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
