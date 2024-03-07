import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_provider.dart';
import 'dbfunctions_provider.dart';

class SearchProvider extends ChangeNotifier {
  String searchLx = "";
  String searchM = "";
  String searchLow = "";

  void searchListUpdateLuxury(context) {
    final dbprovider = Provider.of<DbFunctionsProvider>(context, listen: false);

    final filterdList = dbprovider.carsListNotifier
        .where(
          (cars) => cars.name.toLowerCase().contains(searchLx.toLowerCase()),
        )
        .toList();
    dbprovider.filteredSearchLx(filterdList);
  }

  //.........................................................
  void searchListUpdateMedium(context) {
    final dbprovider = Provider.of<DbFunctionsProvider>(context, listen: false);

    dbprovider.getAllCarsP(DataBases.mediumDb);
    final filterdListM = dbprovider.carsMediumListNotifier
        .where((mediumCarsModel) =>
            mediumCarsModel.name.toLowerCase().contains(searchM.toLowerCase()))
        .toList();
    dbprovider.filteredSearchM(filterdListM);
  }

//.........................................................................
  void searchListUpdateLow(context) {
    final dbprovider = Provider.of<DbFunctionsProvider>(context, listen: false);

    final filterdListL = dbprovider.carsLowListNotifier
        .where(
            (car) => car.name.toLowerCase().contains(searchLow.toLowerCase()))
        .toList();
    dbprovider.filteredSearchL(filterdListL);
  }
}
