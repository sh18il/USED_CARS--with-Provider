import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controlls/bottom_nav_provider.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavProvide>(context);
    return Scaffold(
      body: provider.screens[provider.currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 400),
        animationCurve: Curves.linear,
        backgroundColor: Colors.transparent,
        color: Colors.black,
        onTap: (newIndex) {
          provider.indexValue(newIndex);
        }, 
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const Icon(
            Icons.home,
            color: Colors.white,
          ),
          const Icon(
            Icons.add,
            color: Colors.white,
          ),
          const Icon(
            Icons.bar_chart,
            color: Colors.white,
          ),
          // ignore: prefer_const_constructors
          Icon(Icons.settings, color: Colors.white),
        ],
      ),
    );
  }
}
