import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class KeyboardActionsWidget extends StatelessWidget {
  final Widget child;
  final FocusNode focusNode;
  final VoidCallback onTapAction;
  const KeyboardActionsWidget(
      {Key? key,
      required this.child,
      required this.focusNode,
      required this.onTapAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      disableScroll: true,
      config: KeyboardActionsConfig(
          keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
          nextFocus: false,
          actions: [
            KeyboardActionsItem(
              focusNode: focusNode,
              onTapAction: onTapAction,
            )
          ]),
      child: child,
    );
  }
}
