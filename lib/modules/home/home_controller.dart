import 'package:flutter/material.dart';
import 'package:frankfurter/extensions/string_extensions.dart';
import 'package:frankfurter/extensions/text_editing_controller_extensions.dart';
import 'package:frankfurter/models/currency.dart';
import 'package:frankfurter/providers/rate_provider.dart';
import 'package:frankfurter/utils/utils.dart';
import 'package:frankfurter/utils/widget_utils.dart';
import 'package:provider/provider.dart';

class HomeController {
  final formKey = GlobalKey<FormState>();
  final amountController = NumericTextEditingController();
  final FocusNode amountFocusNode = FocusNode();

  void init(BuildContext context) async {
    try {
      context.read<RateProvider>().fetchCurrencies();
    } catch (e) {
      showSnackbarWithException(context, e);
    }
  }

  String? amountValidator(String? value) =>
      (value?.isEmpty ?? true) || value?.trim() == '0,00'
          ? 'Inform amount'
          : null;

  String? currencyValidator(Currency? value) =>
      value == null ? 'Select currency' : null;

  String amount(BuildContext context) =>
      Utils.formatCurrency(context.watch<RateProvider>().amount);

  void amountChanged(BuildContext context, String value) =>
      context.read<RateProvider>().amount = value.parseDouble();

  List<Currency> currencies(BuildContext context) =>
      context.watch<RateProvider>().currencies;

  Currency? fromCurrency(BuildContext context) =>
      context.watch<RateProvider>().fromCurrency;

  void fromCurrencyChanged(BuildContext context, Currency? currency) =>
      context.read<RateProvider>().fromCurrency = currency;

  Currency? toCurrency(BuildContext context) =>
      context.watch<RateProvider>().toCurrency;

  void toCurrencyChanged(BuildContext context, Currency? currency) =>
      context.read<RateProvider>().toCurrency = currency;

  String rate(BuildContext context) =>
      Utils.formatCurrency(context.watch<RateProvider>().rate);

  String rateCurrencyCode(BuildContext context) =>
      ' ${context.watch<RateProvider>().toCurrency?.code ?? ''}';

  getRate(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final pd = WidgetUtils.buildProgressDialog(
      context,
      message: 'Consulting the wise internet...',
    );
    try {
      await pd.show();
      await context.read<RateProvider>().fetchRate();
    } catch (e) {
      showSnackbarWithException(context, e);
    } finally {
      pd.hide();
    }
  }

  void showSnackbarWithException(BuildContext context, Object e) {
    final snackBar = SnackBar(content: Text('Ops, something went wrong: $e'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
