import 'package:flutter/material.dart';
import 'package:refood_app/core/constants/categories_units.dart';
import 'package:refood_app/core/constants/ui_constants.dart';
import 'package:refood_app/shared/scaffolds/primary_scaffold.dart';
import 'package:refood_app/shared/widgets/form_widgets/combobox.dart';
import 'package:refood_app/shared/widgets/form_widgets/form_widgets.dart';

class OfferForm extends StatefulWidget {
  const OfferForm({super.key});

  @override
  State<OfferForm> createState() => _OfferFormState();
}

class _OfferFormState extends State<OfferForm> {
  final _formKey = GlobalKey<FormState>();
  // Form fields
  String foodName = "";
  String category = "";
  String description = "";
  int quantity = 1;
  String unit = "boxes";
  DateTime? expiryDate;
  DateTime? pickupStartTime;
  DateTime? pickupEndTime;
  double? originalPrice;
  double? offerPrice;
  bool isFree = false;
  String pickupLocation = "";
  String address = "";
  String city = "";
  String country = "";
  String gallery = ""; // comma separated
  String status = "active";

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppSpacing.v16,
                // Food Name
                CustomTextBox(
                  label: "Food Name",
                  validator: (value) =>
                      value == null || value.isEmpty ? "Required" : null,
                  onSaved: (val) => foodName = val ?? "",
                ),

                const SizedBox(height: 12),

                // Category
                CustomCombobox(
                  label: "Category",
                  helperText: "Select food category",
                  dataList: Enums.categoryOptions
                      .map((e) => CustomComboboxitem(title: e, id: e.hashCode))
                      .toList(),
                  onSelected: (val) => category = val,
                ),

                const SizedBox(height: 12),

                // Description
                CustomTextBox(
                  label: "Description",
                  isMultiline: true,
                  onSaved: (val) => description = val ?? "",
                ),

                const SizedBox(height: 12),

                // Quantity
                CustomTextBox(
                  label: "Quantity",
                  keyboardType: TextInputType.number,
                  onSaved: (val) => quantity = int.tryParse(val ?? "1") ?? 1,
                ),

                const SizedBox(height: 12),

                // Unit
                CustomCombobox(
                  label: "Unit",
                  helperText: "Select unit",
                  dataList: Enums.unitOptions
                      .map((e) => CustomComboboxitem(title: e, id: e.hashCode))
                      .toList(),
                  onSelected: (val) => unit = val,
                ),

                const SizedBox(height: 12),

                // Prices
                CustomTextBox(
                  label: "Original Price",
                  keyboardType: TextInputType.number,
                  onSaved: (val) => originalPrice = double.tryParse(val ?? "0"),
                ),

                const SizedBox(height: 12),

                CustomTextBox(
                  label: "Offer Price",
                  keyboardType: TextInputType.number,
                  onSaved: (val) => offerPrice = double.tryParse(val ?? "0"),
                ),

                const SizedBox(height: 12),

                // Is Free Checkbox
                Row(
                  children: [
                    Checkbox(
                        value: isFree,
                        onChanged: (val) {
                          setState(() {
                            isFree = val ?? false;
                          });
                        }),
                    const Text("Is Free"),
                  ],
                ),

                const SizedBox(height: 12),

                // Pickup Location
                CustomTextBox(
                  label: "Pickup Location Name",
                  onSaved: (val) => pickupLocation = val ?? "",
                ),

                const SizedBox(height: 12),

                // Address
                CustomTextBox(
                  label: "Address",
                  onSaved: (val) => address = val ?? "",
                ),

                const SizedBox(height: 12),

                // City
                CustomTextBox(
                  label: "City",
                  onSaved: (val) => city = val ?? "",
                ),

                const SizedBox(height: 12),

                // Country
                CustomTextBox(
                  label: "Country",
                  onSaved: (val) => country = val ?? "",
                ),

                const SizedBox(height: 12),

                // Status
                CustomCombobox(
                  label: "Status",
                  dataList: Enums.statusOptions
                      .map((e) => CustomComboboxitem(title: e, id: e.hashCode))
                      .toList(),
                  onSelected: (val) => status = val,
                  helperText: 'Select status',
                ),

                const SizedBox(height: 12),

                // Gallery
                CustomTextBox(
                  label: "Gallery Images (comma separated URLs)",
                  isMultiline: true,
                  onSaved: (val) => gallery = val ?? "",
                ),

                const SizedBox(height: 12),

                // Expiry Date
                DatepickerBox(
                  label: "Expiry Date",
                  initialDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  onSaved: (val) => expiryDate = val,
                ),

                const SizedBox(height: 12),

                // Pickup Window Start
                DatepickerBox(
                  label: "Pickup Start Time",
                  initialDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  onSaved: (val) => pickupStartTime = val,
                ),

                const SizedBox(height: 12),

                // Pickup Window End
                DatepickerBox(
                  label: "Pickup End Time",
                  initialDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  onSaved: (val) => pickupEndTime = val,
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Here you can send data to API or DB
                      print("Food Name: $foodName");
                      print("Category: $category");
                      print("Quantity: $quantity $unit");
                      print("Offer Price: $offerPrice, Free: $isFree");
                    }
                  },
                  child:
                      const Text("Add Offer", style: TextStyle(fontSize: 18)),
                )
              ],
            ),
          )),
    );
  }
}
