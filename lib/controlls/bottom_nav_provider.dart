import 'package:flutter/material.dart';
import 'package:royalcars/view/home_screen.dart';
import 'package:royalcars/view/settings.dart';

import '../view/add_screen.dart';
import '../view/chart_screen.dart';

class BottomNavProvide extends ChangeNotifier {
  int currentIndex = 0;
  final screens = [
    const HomeScreen(),
    const AddScrees(),
    ChartScreen(),
    Settings(),
    
  ];

  indexValue(newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}
