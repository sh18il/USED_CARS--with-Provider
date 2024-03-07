import 'package:flutter/material.dart';

class SignAndLoginProvider extends ChangeNotifier {
  bool isObscured = true;
  final usernameCntr = TextEditingController();
  final passwordCntr = TextEditingController();
  final sINGUPkey = GlobalKey<FormState>();

  passwordFunction() {
    isObscured = !isObscured;
    notifyListeners();
  }

  clearSign() {
    usernameCntr.clear();
    passwordCntr.clear();

    notifyListeners();
  }
}
