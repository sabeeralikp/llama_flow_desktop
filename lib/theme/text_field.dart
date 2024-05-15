import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutlinedTextFormField extends StatefulWidget {
  final String labelText;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final TextEditingController _textEditingController;
  final TextInputType? keyboardType;
  final Function(String? value)? validator;
  final bool? autofocus;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  const OutlinedTextFormField(
      {required this.labelText,
      this.maxLength,
      this.minLines,
      this.maxLines,
      required TextEditingController controller,
      this.keyboardType,
      this.validator,
      this.autofocus,
      this.focusNode,
      this.nextFocusNode,
      super.key})
      : _textEditingController = controller;

  @override
  State<OutlinedTextFormField> createState() => _OutlinedTextFormFieldState();
}

class _OutlinedTextFormFieldState extends State<OutlinedTextFormField> {
  onOutlinedFieldSubmitted(term) {
    if (widget.focusNode != null) {
      widget.focusNode!.unfocus();
      if (widget.nextFocusNode != null) {
        FocusScope.of(context).requestFocus(widget.nextFocusNode!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLength: widget.maxLength,
        minLines: widget.minLines ?? 1,
        maxLines: widget.maxLines ?? 1,
        autofocus: widget.autofocus ?? false,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        controller: widget._textEditingController,
        validator: widget.validator as String? Function(String? value)?,
        onFieldSubmitted: onOutlinedFieldSubmitted,
        textInputAction: widget.minLines == null
            ? widget.nextFocusNode == null
                ? TextInputAction.done
                : TextInputAction.next
            : null,
        inputFormatters: widget.keyboardType == TextInputType.number
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
        decoration: InputDecoration(
            labelText: widget.labelText,
            contentPadding: widget.minLines == null
                ? const EdgeInsets.only(left: 12)
                : null,
            border: const OutlineInputBorder()));
  }
}

class OutlineDropDownFormField extends StatelessWidget {
  final String labelText;
  final dynamic value;
  final List<DropdownMenuItem> items;
  final ValueSetter onChanged;
  final String? Function(dynamic)? validator;
  const OutlineDropDownFormField(
      {required this.labelText,
      required this.items,
      required this.onChanged,
      this.value,
      this.validator,
      super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        value: value,
        decoration: InputDecoration(
            labelText: labelText,
            contentPadding: const EdgeInsets.only(left: 12),
            border: const OutlineInputBorder()),
        items: items,
        validator: validator,
        onChanged: onChanged);
  }
}

class OutlinedDatePicker extends StatelessWidget {
  final String labelText;
  final TextEditingController _expectedDateOfDeliveryController;
  final VoidCallback onTap;
  const OutlinedDatePicker(
      {required this.labelText,
      required TextEditingController controller,
      required this.onTap,
      super.key})
      : _expectedDateOfDeliveryController = controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: _expectedDateOfDeliveryController,
      onTap: onTap,
      decoration: InputDecoration(
          labelText: labelText,
          contentPadding: const EdgeInsets.only(left: 12),
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
              onPressed: onTap, icon: const Icon(Icons.date_range_rounded))),
    );
  }
}
