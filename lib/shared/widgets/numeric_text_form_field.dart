import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:frankfurter/extensions/text_editing_controller_extensions.dart';
import 'package:frankfurter/shared/app_colors.dart';

class NumericTextFormField extends StatelessWidget {
  final NumericTextEditingController controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final bool? readOnly;

  const NumericTextFormField(
      {Key? key,
      required this.controller,
      this.focusNode,
      this.onFieldSubmitted,
      this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      textAlign: TextAlign.end,
      keyboardType: TextInputType.number,
      readOnly: readOnly ?? false,
      inputFormatters: [
        CurrencyTextInputFormatter(locale: 'pt_BR', name: '', decimalDigits: 2)
      ],
      onFieldSubmitted: onFieldSubmitted,
      onChanged: (value) {
        if (value.isEmpty) controller.text = '0,00';
      },
      style: TextStyle(color: AppColors.textForm),
      onTap: () {
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length));
      },
    );
  }
}
