import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExpandedTextField extends StatelessWidget {
  final bool enabled;
  final TextEditingController? controller;
  final String label;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  ExpandedTextField(
      {Key? key,
      required this.label,
      this.enabled = true,
      this.controller,
      this.keyboardType,
      this.inputFormatters})
      : super(key: key);

  ExpandedTextField.numeric(
      {Key? key, this.controller, this.enabled = true, required this.label})
      : inputFormatters = <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        keyboardType = TextInputType.number;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      key: key,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: TextField(
          enabled: enabled,
          controller: controller,
          decoration:
              InputDecoration(labelText: label, border: OutlineInputBorder()),
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
        ),
      ),
    );
  }
}
