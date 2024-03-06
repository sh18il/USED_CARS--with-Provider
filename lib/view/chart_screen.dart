import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:royalcars/controlls/add_provider.dart';
import 'package:royalcars/controlls/dbfunctions_provider.dart';
import 'package:royalcars/model/lowcar/low_cars_model.dart';
import 'package:royalcars/model/luxurycar/cars_model.dart';
import 'package:royalcars/model/mediumcar/medium_cars_model.dart';
import 'package:royalcars/service/function.dart';

class ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log('chart');
    final dbProvider = Provider.of<DbFunctionsProvider>(context, listen: false);
    dbProvider.getAllCarsP(DataBases.LowDb);
    dbProvider.getAllCarsP(DataBases.LuxuryDb);
    dbProvider.getAllCarsP(DataBases.MediumDb);

    final List<CarsModel> luxuryCar = dbProvider.carsListNotifier;
    final List<LowCarsModel> lowCar = dbProvider.carsLowListNotifier;
    final List<MediumCarsModel> mediuM = dbProvider.carsMediumListNotifier;

    double luxuryCarTotal = 0;
    double lowCarTotal = 0;
    double mediumCarTotal = 0;

    for (var element in luxuryCar) {
      luxuryCarTotal += int.parse(element.price);
    }
    for (var element in lowCar) {
      lowCarTotal += int.parse(element.price);
    }
    for (var element in mediuM) {
      mediumCarTotal += int.parse(element.price);
    }

    final Map<String, double> dataMap = {
      'Low': lowCarTotal,
      'Medium': mediumCarTotal,
      'Luxury': luxuryCarTotal,
    };

    final List<Color> colorList = [
      const Color.fromARGB(255, 135, 155, 145),
      const Color.fromARGB(255, 8, 11, 15),
      const Color.fromARGB(255, 101, 51, 51),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(child: Text("CAR BUDJET ANALYSIS")),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: PieChart(
          dataMap: dataMap,
          chartType: ChartType.ring,
          ringStrokeWidth: 22,
          legendOptions: const LegendOptions(
            showLegendsInRow: false,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          chartRadius: MediaQuery.of(context).size.width / 1.6,
          colorList: colorList,
          initialAngleInDegree: 0,
          chartValuesOptions: const ChartValuesOptions(
            showChartValueBackground: true,
            showChartValues: true,
            showChartValuesInPercentage: false,
            showChartValuesOutside: false,
          ),
        ),
      ),
    );
  }
}
