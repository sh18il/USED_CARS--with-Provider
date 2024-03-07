import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:royalcars/controlls/add_provider.dart';
import 'package:royalcars/model/luxurycar/cars_model.dart';
import 'package:royalcars/model/lowcar/low_cars_model.dart';
import 'package:royalcars/model/mediumcar/medium_cars_model.dart';
import '../controlls/dbfunctions_provider.dart';
import 'widgets/editpage.dart';

class AddScrees extends StatelessWidget {
  const AddScrees({super.key});

  @override
  Widget build(BuildContext context) {
    log('AddScreen');
    final addScreenProvider = Provider.of<AddProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black87,
        title: const Center(
          child: Text("ADD CARS",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w400,
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(20),
            Center(
              child: Consumer<AddProvider>(builder: (context, provider, _) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  width: 180,
                  height: 130,
                  child: Image(
                    image: addScreenProvider.selectImage != null
                        ? FileImage(addScreenProvider.selectImage!)
                        : const AssetImage("image/carr1.png") as ImageProvider,
                  ),
                );
              }),
            ),
            const Text('ADD CAR PHOTO'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 151, 110, 34)),
                    onPressed: () {
                      addScreenProvider.pickImgGallery(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY")),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 151, 110, 34)),
                    onPressed: () {
                      addScreenProvider.pickImgGallery(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("CAMERA")),
              ],
            ),
            const Gap(30),
            Form(
              key: addScreenProvider.formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AddFormFieldW(
                          width: 172,
                          keyboardType: TextInputType.text,
                          hintText: 'NAME',
                          controller: addScreenProvider.nameContrl,
                          gradient: const LinearGradient(
                            colors: [Colors.blue, Colors.red, Colors.green],
                          )),
                      AddFormFieldW(
                          width: 107,
                          keyboardType: TextInputType.number,
                          hintText: 'MODEL',
                          controller: addScreenProvider.modelContrl,
                          gradient: const LinearGradient(
                            colors: [Colors.yellow, Colors.red, Colors.blue],
                          )),
                    ],
                  ),
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AddFormFieldW(
                          width: 119,
                          keyboardType: TextInputType.number,
                          hintText: 'KM',
                          controller: addScreenProvider.kmContrl,
                          gradient: const LinearGradient(
                            colors: [Colors.green, Colors.red, Colors.black],
                          )),
                      AddFormFieldW(
                          width: 146,
                          keyboardType: TextInputType.multiline,
                          hintText: 'DL NUMBER',
                          controller: addScreenProvider.dlNumberContrl,
                          gradient: const LinearGradient(
                            colors: [Colors.green, Colors.red, Colors.black],
                          )),
                    ],
                  ),
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AddFormFieldW(
                        width: 107,
                        keyboardType: TextInputType.number,
                        hintText: 'OWNERSHIP',
                        controller: addScreenProvider.ownerContrl,
                        gradient: const LinearGradient(
                          colors: [Colors.green, Colors.red, Colors.black],
                        ),
                      ),
                      AddFormFieldW(
                          width: 174,
                          keyboardType: TextInputType.number,
                          hintText: 'PRICE',
                          controller: addScreenProvider.priceContrl,
                          gradient: const LinearGradient(
                            colors: [Colors.green, Colors.red, Colors.black],
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      Consumer<AddProvider>(builder: (context, provider, _) {
                        return DropdownButton<DataBases>(
                          value: provider.selectedDatabase,
                          items: const [
                            DropdownMenuItem(
                              value: DataBases.luxuryDb,
                              child: Text('Luxury'),
                            ),
                            DropdownMenuItem(
                              value: DataBases.mediumDb,
                              child: Text('MEDIUM'),
                            ),
                            DropdownMenuItem(
                              value: DataBases.lowDb,
                              child: Text('LOW'),
                            ),
                          ],
                          onChanged: (value) {
                            provider.selectDataBase(value);
                          },
                        );
                      }),
                    ],
                  ),
                  const Gap(30),
                  AddFormFieldW(
                      width: 223,
                      keyboardType: TextInputType.text,
                      hintText: 'FUETERS',
                      controller: addScreenProvider.futureContrl,
                      gradient: const LinearGradient(
                        colors: [Colors.green, Colors.red, Colors.black],
                      )),
                  const Gap(30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(237, 248, 66, 5),
                    ),
                    onPressed: () {
                      if (addScreenProvider.formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm '),
                              content: const Text('Sucsses submit'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    onAddCarsButn(context);
                                    Navigator.of(context).pop();
                                    addScreenProvider.clear();
                                  },
                                  child: const Text('Done'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text('SUBMIT'),
                  ),
                  const Gap(30),
                ],
              ),
            )
          ],
        ),
      ),
    );
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
