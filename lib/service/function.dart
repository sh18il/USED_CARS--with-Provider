
import 'package:hive/hive.dart';
import 'package:royalcars/model/luxurycar/cars_model.dart';
import 'package:royalcars/model/mediumcar/medium_cars_model.dart';
import 'package:royalcars/model/lowcar/low_cars_model.dart';

import '../controlls/add_provider.dart';


class DbFunctions {
  Future<void> addCar(DataBases type, value) async {
    final box = await boxForType(type);
    await box.add(value);

    getAllCars(type);
  }

  Future getAllCars(DataBases type) async {
    final box = await boxForType(type);
   
   return box.values.toList();
  }

  Future<void> deleteCar(DataBases type, int index) async {
    final box = await boxForType(type);
    await box.deleteAt(index);

    getAllCars(type);
  }

  Future<void> editCar(DataBases type, int index, dynamic value) async {
    final box = await boxForType(type);
    await box.putAt(index, value);

    getAllCars(type);
  }

  Future<Box<dynamic>> boxForType(DataBases type) async {
    switch (type) {
      case DataBases.LowDb:
        return await Hive.openBox<LowCarsModel>('low_cars_db');
      case DataBases.MediumDb:
        return await Hive.openBox<MediumCarsModel>('medium_cars_db');
      case DataBases.LuxuryDb:
        return await Hive.openBox<CarsModel>('luxury_cars_db');
    }
  }




}


