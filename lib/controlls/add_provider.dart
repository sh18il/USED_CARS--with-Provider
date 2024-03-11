import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:royalcars/model/luxurycar/cars_model.dart';

import '../model/lowcar/low_cars_model.dart';
import '../model/mediumcar/medium_cars_model.dart';
import 'dbfunctions_provider.dart';

enum DataBases { luxuryDb, mediumDb, lowDb }

class AddProvider extends ChangeNotifier {
  DataBases selectedDatabase = DataBases.luxuryDb;
  final nameContrl = TextEditingController();
  final modelContrl = TextEditingController();
  final kmContrl = TextEditingController();
  final dlNumberContrl = TextEditingController();

  final ownerContrl = TextEditingController();
  final priceContrl = TextEditingController();
  final futureContrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  File? selectImage;

  Future pickImgGallery(imageSource) async {
    final returnImg = await ImagePicker().pickImage(source: imageSource);

    if (returnImg == null) {
      return;
    }

    selectImage = File(returnImg.path);

    notifyListeners();
  }

  selectDataBase(value) {
    selectedDatabase = value;
    notifyListeners();
  }

  clear() {
    nameContrl.clear();
    modelContrl.clear();
    kmContrl.clear();
    dlNumberContrl.clear();
    ownerContrl.clear();
    priceContrl.clear();
    futureContrl.clear();
    selectImage = null;
    notifyListeners();
  }
   Future<void> onAddCarsButn(context) async {
    log('dddd');
    final addbuttonProvider = Provider.of<AddProvider>(context, listen: false);
    if (addbuttonProvider.selectedDatabase == DataBases.luxuryDb) {
      final name = addbuttonProvider.nameContrl.text;
      final model = addbuttonProvider.modelContrl.text;
      final km = addbuttonProvider.kmContrl.text;
      final dlnbr = addbuttonProvider.dlNumberContrl.text;
      final owner = addbuttonProvider.ownerContrl.text;
      final price = addbuttonProvider.priceContrl.text;
      final future = addbuttonProvider.futureContrl.text;

      if (name.isEmpty ||
          model.isEmpty ||
          km.isEmpty ||
          dlnbr.isEmpty ||
          owner.isEmpty ||
          price.isEmpty ||
          future.isEmpty) {
        return;
      }

      final cars = CarsModel(
          name: name,
          model: model,
          km: km,
          dlnumber: dlnbr,
          owner: owner,
          price: price,
          future: future,
          image: addbuttonProvider.selectImage!.path);

      Provider.of<DbFunctionsProvider>(context, listen: false)
          .addCars(DataBases.luxuryDb, cars);
    } else if (addbuttonProvider.selectedDatabase == DataBases.mediumDb) {
      final name = addbuttonProvider.nameContrl.text;
      final model = addbuttonProvider.modelContrl.text;
      final km = addbuttonProvider.kmContrl.text;
      final dlnbr = addbuttonProvider.dlNumberContrl.text;
      final owner = addbuttonProvider.ownerContrl.text;
      final price = addbuttonProvider.priceContrl.text;
      final future = addbuttonProvider.futureContrl.text;

      if (name.isEmpty ||
          model.isEmpty ||
          km.isEmpty ||
          dlnbr.isEmpty ||
          owner.isEmpty ||
          price.isEmpty ||
          future.isEmpty) {
        return;
      }

      final cars = MediumCarsModel(
          name: name,
          model: model,
          km: km,
          dlnumber: dlnbr,
          owner: owner,
          price: price,
          future: future,
          image: addbuttonProvider.selectImage!.path);

      Provider.of<DbFunctionsProvider>(context, listen: false)
          .addCars(DataBases.mediumDb, cars);
    } else if (addbuttonProvider.selectedDatabase == DataBases.lowDb) {
      final name = addbuttonProvider.nameContrl.text;
      final model = addbuttonProvider.modelContrl.text;
      final km = addbuttonProvider.kmContrl.text;
      final dlnbr = addbuttonProvider.dlNumberContrl.text;
      final owner = addbuttonProvider.ownerContrl.text;
      final price = addbuttonProvider.priceContrl.text;
      final future = addbuttonProvider.futureContrl.text;

      if (name.isEmpty ||
          model.isEmpty ||
          km.isEmpty ||
          dlnbr.isEmpty ||
          owner.isEmpty ||
          price.isEmpty ||
          future.isEmpty) {
        return;
      }

      final cars = LowCarsModel(
          name: name,
          model: model,
          km: km,
          dlnumber: dlnbr,
          owner: owner,
          price: price,
          future: future,
          image: addbuttonProvider.selectImage!.path);

      Provider.of<DbFunctionsProvider>(context, listen: false)
          .addCars(DataBases.lowDb, cars);
    }
  }
}
