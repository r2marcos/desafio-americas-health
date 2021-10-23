import 'package:flutter/material.dart';

class NumericTextEditingController extends TextEditingController {
  NumericTextEditingController({String? text}) {
    this.text = text ?? '0,00';
  }

  @override
  set text(String newText) {
    value = value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
        composing: TextRange.empty);
  }
}
