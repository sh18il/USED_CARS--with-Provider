import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditScreenProvider extends ChangeNotifier {
  TextEditingController nameContrl = TextEditingController();
  TextEditingController modelContrl = TextEditingController();
  TextEditingController kmContrl = TextEditingController();
  TextEditingController dlNumberContrl = TextEditingController();
  TextEditingController ownerContrl = TextEditingController();
  TextEditingController priceContrl = TextEditingController();
  TextEditingController futureContrl = TextEditingController();

  File? selectImage;

  Future pickImage(ImageSource source) async {
    final returnImage = await ImagePicker().pickImage(source: source);

    if (returnImage == null) {
      return;
    }
    selectImage = File(returnImage.path);

    notifyListeners();
  }
  
}
