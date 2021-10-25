import 'package:flutter/material.dart';
import 'package:frankfurter/models/currency.dart';
import 'package:frankfurter/modules/home/home_controller.dart';
import 'package:frankfurter/shared/app_colors.dart';
import 'package:frankfurter/shared/widgets/keyboard_actions_widget.dart';
import 'package:frankfurter/shared/widgets/label_widget.dart';
import 'package:frankfurter/shared/widgets/numeric_text_form_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  void initState() {
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => controller.init(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('FrankFurter App'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: size.width * 0.8,
          child: Form(
            key: controller.formKey,
            child: ListView(
              children: [
                amount(),
                fromCurrency(),
                toCurrency(),
                submit(),
                rateResult(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget amount() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LabelWidget(label: 'Amount'),
          KeyboardActionsWidget(
            focusNode: controller.amountFocusNode,
            child: NumericTextFormField(
              controller: controller.amountController
                ..text = controller.amount(context),
              focusNode: controller.amountFocusNode,
              validator: (value) => controller.amountValidator(value),
              onChanged: (String value) =>
                  controller.amountChanged(context, value),
            ),
          )
        ],
      ),
    );
  }

  Widget fromCurrency() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LabelWidget(label: 'From'),
          DropdownButtonFormField<Currency>(
            value: controller.fromCurrency(context),
            isExpanded: true,
            dropdownColor: AppColors.background,
            validator: (value) => controller.currencyValidator(value),
            items: controller.currencies(context).map((value) {
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
                controller.fromCurrencyChanged(context, value),
          ),
        ],
      ),
    );
  }

  Widget toCurrency() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LabelWidget(label: 'To'),
          DropdownButtonFormField<Currency>(
            value: controller.toCurrency(context),
            isExpanded: true,
            dropdownColor: AppColors.background,
            validator: (value) => controller.currencyValidator(value),
            items: controller.currencies(context).map((value) {
              return DropdownMenuItem<Currency>(
                value: value,
                child: Text(
                  '${value.code} - ${value.name}',
                  style: TextStyle(color: AppColors.textForm),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: (value) => controller.toCurrencyChanged(context, value),
          ),
        ],
      ),
    );
  }

  Padding submit() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          child: const Text(
            'Get Rate',
            style: TextStyle(fontSize: 22),
          ),
          onPressed: () => controller.getRate(context),
        ),
      ),
    );
  }

  Container rateResult() {
    return Container(
      alignment: Alignment.topRight,
      padding: const EdgeInsets.only(top: 16),
      child: RichText(
        text: TextSpan(
          text: controller.rate(context),
          style: const TextStyle(fontSize: 32),
          children: [
            TextSpan(
              text: controller.rateCurrencyCode(context),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: Colors.green[600],
              ),
            )
          ],
        ),
      ),
    );
  }
}
