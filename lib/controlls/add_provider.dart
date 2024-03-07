import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
}
