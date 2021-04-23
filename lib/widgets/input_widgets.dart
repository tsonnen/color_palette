import 'package:flutter/material.dart';

class LabeledInput extends StatefulWidget {
  final String label;
  final Widget widget;

  LabeledInput({required this.label, required this.widget});

  LabeledInput.Switch(
      {required this.label,
      required Function(bool) onChanged,
      required bool value})
      : widget = Switch(
          value: value,
          onChanged: onChanged,
        );

  @override
  State<LabeledInput> createState() => LabeledInputState();
}

class LabeledInputState extends State<LabeledInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text(widget.label), widget.widget],
    );
  }
}
