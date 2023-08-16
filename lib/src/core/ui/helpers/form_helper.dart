import 'package:flutter/material.dart';

void unFocus(BuildContext context) => FocusScope.of(context).unfocus();

extension UnFocusExtension on BuildContext {
  void unFocus() => FocusScope.of(this).unfocus();
}
