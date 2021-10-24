import 'package:flutter/material.dart';
import 'package:frankfurter/extensions/text_editing_controller_extensions.dart';
import 'package:frankfurter/models/currency.dart';
import 'package:frankfurter/providers/currencies_provider.dart';
import 'package:frankfurter/shared/app_colors.dart';
import 'package:frankfurter/shared/widgets/keyboard_actions_widget.dart';
import 'package:frankfurter/shared/widgets/label_widget.dart';
import 'package:frankfurter/shared/widgets/numeric_text_form_field.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _amountController = NumericTextEditingController();
  final _rateController = NumericTextEditingController();
  final FocusNode _amountFocusNode = FocusNode();

  @override
  void initState() {
    context.read<CurrenciesProvider>().fetchCurrencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FrankFurter App'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          from(),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ElevatedButton.icon(
                  onPressed: () =>
                      context.read<CurrenciesProvider>().tooggleCurrencies(),
                  icon: const Icon(Icons.price_change_rounded),
                  label: const Text('Invert')),
            ),
          ),
          to(),
        ],
      ),
    );
  }

  Widget from() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LabelWidget(label: 'From'),
          Row(
            children: [
              Expanded(
                child: KeyboardActionsWidget(
                  focusNode: _amountFocusNode,
                  child: NumericTextFormField(
                    controller: _amountController,
                    focusNode: _amountFocusNode,
                  ),
                  onTapAction: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<Currency>(
                  value: context.watch<CurrenciesProvider>().fromCurrency,
                  isExpanded: true,
                  dropdownColor: AppColors.background,
                  items: context
                      .watch<CurrenciesProvider>()
                      .currencies
                      .map((value) {
                    return DropdownMenuItem<Currency>(
                      value: value,
                      child: Text(
                        '${value.code} - ${value.name}',
                        style: TextStyle(color: AppColors.textForm),
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      context.read<CurrenciesProvider>().fromCurrency = value,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget to() {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LabelWidget(label: 'To'),
            Row(
              children: [
                Expanded(
                  child: NumericTextFormField(
                    controller: _rateController,
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<Currency>(
                    value: context.watch<CurrenciesProvider>().toCurrency,
                    isExpanded: true,
                    dropdownColor: AppColors.background,
                    items: context
                        .watch<CurrenciesProvider>()
                        .currencies
                        .map((value) {
                      return DropdownMenuItem<Currency>(
                        value: value,
                        child: Text(
                          '${value.code} - ${value.name}',
                          style: TextStyle(color: AppColors.textForm),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        context.read<CurrenciesProvider>().toCurrency = value,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
