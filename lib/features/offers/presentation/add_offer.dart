import 'package:flutter/material.dart';
import 'package:refood_app/shared/scaffolds/primary_scaffold.dart';

class AddOfferPage extends StatefulWidget {
  const AddOfferPage({super.key});

  @override
  State<AddOfferPage> createState() => _AddOfferPageState();
}

class _AddOfferPageState extends State<AddOfferPage> {
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(body: Placeholder());
  }
}
