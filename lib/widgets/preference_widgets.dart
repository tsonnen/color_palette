import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:color_palette/services/preference_manager.dart';

class PreferenceNumericField extends StatefulWidget {
  final String prefKey;
  final bool enabled;
  final String label;
  final String? defaultVal;

  final TextEditingController controller;

  PreferenceNumericField(this.label, this.prefKey,
      {this.enabled = true, this.defaultVal, controller})
      : controller = controller ?? TextEditingController();

  @override
  State<PreferenceNumericField> createState() => PreferenceNumericFieldState();
}

class PreferenceNumericFieldState extends State<PreferenceNumericField> {
  @override
  void initState() {
    widget.controller.text =
        PreferenceManager.get(widget.prefKey)?.toString() ?? widget.defaultVal!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: TextField(
          enabled: widget.enabled,
          controller: widget.controller,
          decoration: InputDecoration(
              labelText: widget.label, border: OutlineInputBorder()),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          onSubmitted: (val) {
            setState(() {
              PreferenceManager.setString(widget.prefKey, val);
            });
          },
          onEditingComplete: () {
            setState(() {
              PreferenceManager.setString(
                  widget.prefKey, widget.controller.text);
            });
          },
          onChanged: (val) {
            setState(() {
              PreferenceManager.setString(widget.prefKey, val);
            });
          },
        ),
      ),
    );
  }
}
