import 'package:flutter/material.dart';

void tryPopContext(context) {
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  }
}
