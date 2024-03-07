import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:royalcars/controlls/add_provider.dart';
import 'package:royalcars/model/luxurycar/cars_model.dart';
import 'package:royalcars/model/lowcar/low_cars_model.dart';
import 'package:royalcars/model/mediumcar/medium_cars_model.dart';
import 'package:royalcars/view/widgets/splash_screen.dart';

import 'controlls/bottom_nav_provider.dart';
import 'controlls/dbfunctions_provider.dart';
import 'controlls/edit_screen_provider.dart';
import 'controlls/login_provider.dart';
import 'controlls/search_lprovider.dart';
import 'controlls/settings_provider.dart';
import 'controlls/sign_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CarsModelAdapter().typeId)) {
    Hive.registerAdapter(CarsModelAdapter());
  }
  if (!Hive.isAdapterRegistered(MediumCarsModelAdapter().typeId)) {
    Hive.registerAdapter(MediumCarsModelAdapter());
  }
  if (!Hive.isAdapterRegistered(LowCarsModelAdapter().typeId)) {
    Hive.registerAdapter(LowCarsModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider (
      providers:[
        ChangeNotifierProvider(create: (context)=>AddProvider()),
        ChangeNotifierProvider(create: (context)=>DbFunctionsProvider()),
        ChangeNotifierProvider(create: (context)=>SearchProvider()),
        ChangeNotifierProvider(create: (context)=>EditScreenProvider()),
        ChangeNotifierProvider(create: (context)=>SettingsProvider()),
        ChangeNotifierProvider(create: (context)=>BottomNavProvide()),
        ChangeNotifierProvider(create: (context)=>SignAndLoginProvider()),
        ChangeNotifierProvider(create: (context)=>LoginProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.fallback(),
        home: const SplashScreen(),
      ),
    );
  }
}
