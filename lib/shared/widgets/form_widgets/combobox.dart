import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:refood_app/core/constants/ui_constants.dart';

class CustomComboboxitem {
  final int id;
  final String title;
  final Map<String, dynamic>? extraData;
  CustomComboboxitem({
    required this.title,
    required this.id,
    this.extraData,
  });
}

class CustomCombobox extends StatefulWidget {
  final String label;
  final String helperText;
  final String suffixText;
  final String? text;
  final Function? validator;
  final String? errorText;
  final bool readOnly;
  final IconData? icon;
  final List<CustomComboboxitem> dataList;
  final Function onSelected;
  final TextInputAction? customTextInputAction;

  const CustomCombobox({
    super.key,
    required this.dataList,
    required this.label,
    required this.helperText,
    this.text = "",
    this.validator,
    this.errorText,
    this.icon,
    this.suffixText = "",
    required this.onSelected,
    this.customTextInputAction = TextInputAction.next,
    this.readOnly = false,
  });

  @override
  State<CustomCombobox> createState() => _CustomComboboxState();
}

class _CustomComboboxState extends State<CustomCombobox> {
  late final TextEditingController _myController;
  @override
  void initState() {
    _myController = TextEditingController(text: widget.text);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  InputBorder _customBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color, width: 1.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          AppSpacing.v4,
          TypeAheadField<CustomComboboxitem>(
            controller: _myController,
            suggestionsCallback: (pattern) {
              return widget.dataList
                  .where((item) =>
                      item.title.toLowerCase().contains(pattern.toLowerCase()))
                  .toList();
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion.title),
                subtitle: Text('ID: ${suggestion.id}'),
              );
            },
            onSelected: (suggestion) {
              setState(() {
                _myController.text = suggestion.title;
              });
              widget.onSelected(suggestion);
            },
            builder: (context, controller, focusNode) {
              return TextFormField(
                controller: controller,
                focusNode: focusNode,
                readOnly: widget.readOnly,
                textInputAction: widget.customTextInputAction,
                decoration: InputDecoration(
                  hintText: widget.helperText,
                  suffixText: widget.suffixText,
                  errorText: widget.errorText,
                  enabledBorder: _customBorder(AppColors.light),
                  focusedBorder: _customBorder(AppColors.primary),
                  errorBorder: _customBorder(Colors.red),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  suffixIcon: Icon(widget.icon ?? Icons.arrow_drop_down,
                      size: 18, color: Colors.grey.shade400),
                ),
                validator: (value) {
                  if (widget.validator != null) {
                    return widget.validator!(value);
                  }
                  return null;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
