import 'package:flutter/material.dart';
import 'package:royalcars/controlls/add_provider.dart';
import 'package:royalcars/service/function.dart';

import '../model/lowcar/low_cars_model.dart';
import '../model/luxurycar/cars_model.dart';
import '../model/mediumcar/medium_cars_model.dart';

class DbFunctionsProvider extends ChangeNotifier {
  final DbFunctions dbFunctionsService = DbFunctions();
  List<CarsModel> searchedListLuxury = [];
  List<MediumCarsModel> searchedListMedium = [];
  List<LowCarsModel> searchedListLow = [];
  //..................................................................
  List<CarsModel> carsListNotifier = [];
  List<LowCarsModel> carsLowListNotifier = [];
  List<MediumCarsModel> carsMediumListNotifier = [];

  Future<void> addCars(DataBases type, value) async {
    dbFunctionsService.addCar(type, value);
    getAllCarsP(type);
  }

  void getAllCarsP(DataBases type) async {
    carsListNotifier = await dbFunctionsService.getAllCars(DataBases.luxuryDb);
    carsLowListNotifier = await dbFunctionsService.getAllCars(DataBases.lowDb);
    carsMediumListNotifier =
        await dbFunctionsService.getAllCars(DataBases.mediumDb);
    notifyListeners();
  }

  void deleteCars(type, index) {
    dbFunctionsService.deleteCar(type, index);
    getAllCarsP(type);
  }

  void editCarsP(type, index, value) {
    dbFunctionsService.editCar(type, index, value);
    getAllCarsP(type);
  }

  void filteredSearchLx(List<CarsModel> value) async {
    searchedListLuxury = value;
    notifyListeners();
  }

  void filteredSearchM(List<MediumCarsModel> value) async {
    searchedListMedium = value;
    notifyListeners();
  }

  void filteredSearchL(List<LowCarsModel> value) async {
    searchedListLow = value;
    notifyListeners();
  }
}
