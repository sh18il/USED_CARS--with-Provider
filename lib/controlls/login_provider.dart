import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool isObscured = true;
  final sINGUPkeyLOG = GlobalKey<FormState>();
  final usernameCntrLog = TextEditingController();
  final passwordCntrLog = TextEditingController();

  passwordFunction() {
    isObscured = !isObscured;
    notifyListeners();
  }

  clearLogin() {
    usernameCntrLog.clear();
    passwordCntrLog.clear();

    notifyListeners();
  }
}
