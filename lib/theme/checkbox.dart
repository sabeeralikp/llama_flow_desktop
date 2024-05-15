import 'package:flutter/material.dart';

class CheckBoxWithTitle extends StatelessWidget {
  final bool value;
  final Function(bool?)? onChanged;
  final String title;
  const CheckBoxWithTitle(
      {required this.value, this.onChanged, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Checkbox(value: value, onChanged: onChanged),
      Flexible(child: Text(title))
    ]);
  }
}
