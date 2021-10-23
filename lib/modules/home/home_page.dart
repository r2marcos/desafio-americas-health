import 'package:flutter/material.dart';
import 'package:frankfurter/extensions/text_editing_controller_extensions.dart';
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
  final _amountController = NumericTextEditingController();
  final _rateController = NumericTextEditingController();
  final FocusNode _amountFocusNode = FocusNode();
  String? from;
  String? to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FrankFurter App'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
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
                      child: DropdownButtonFormField<String>(
                        value: from,
                        isExpanded: true,
                        itemHeight: null,
                        dropdownColor: AppColors.background,
                        items: currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: AppColors.textForm),
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            from = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.price_change_rounded),
                      label: const Text('Invert')),
                )),
                const LabelWidget(label: 'To'),
                Row(
                  children: [
                    Expanded(
                      child: NumericTextFormField(controller: _rateController),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<String>(
                        value: to,
                        isExpanded: true,
                        dropdownColor: Colors.grey[900],
                        items: currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: AppColors.textForm),
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            to = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<String> get currencies => [
        'BRL - Brazilian Real',
        'EUR - Euro',
        'GBP - British Pound',
        'USD - United States Dollar',
      ];
}
