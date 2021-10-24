import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:frankfurter/extensions/text_editing_controller_extensions.dart';
import 'package:frankfurter/shared/app_colors.dart';

class NumericTextFormField extends StatelessWidget {
  final NumericTextEditingController controller;
  final FocusNode? focusNode;
  final TextAlign? textAlign;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final bool? readOnly;

  const NumericTextFormField(
      {Key? key,
      required this.controller,
      this.focusNode,
      this.textAlign,
      this.validator,
      this.onChanged,
      this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      textAlign: textAlign ?? TextAlign.end,
      keyboardType: TextInputType.number,
      readOnly: readOnly ?? false,
      validator: validator,
      minLines: 1,
      maxLines: 2,
      inputFormatters: [
        CurrencyTextInputFormatter(locale: 'pt_BR', name: '', decimalDigits: 2)
      ],
      onChanged: (value) {
        if (value.isEmpty) controller.text = '0,00';
        onChanged?.call(value);
      },
      onTap: () {
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length));
      },
      style: TextStyle(
          color: AppColors.textForm,
          fontSize: 32,
          overflow: TextOverflow.visible),
    );
  }
}
