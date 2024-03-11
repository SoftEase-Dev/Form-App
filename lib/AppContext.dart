import 'package:flutter/material.dart';

class AppContext {
  static late BuildContext appContext;

  static void init(BuildContext context) {
    appContext = context;
  }
}
