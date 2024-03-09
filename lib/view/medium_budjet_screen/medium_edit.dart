// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:royalcars/model/mediumcar/medium_cars_model.dart';

import '../../controlls/add_provider.dart';
import '../../controlls/dbfunctions_provider.dart';
import '../../controlls/edit_screen_provider.dart';

import '../widgets/editpage.dart';

class MediumEditScreen extends StatefulWidget {
  String name;
  String model;
  String km;
  int index;
  String dlnbr;
  String owner;
  String price;
  String future;
  dynamic imagepath;
  MediumEditScreen({
    super.key,
    required this.name,
    required this.model,
    required this.km,
    required this.index,
    required this.dlnbr,
    required this.owner,
    required this.price,
    required this.future,
    required this.imagepath,
  });

  @override
  State<MediumEditScreen> createState() => _MediumEditScreenState();
}

class _MediumEditScreenState extends State<MediumEditScreen> {
  @override
  void initState() {
    final editprovider =
        Provider.of<EditScreenProvider>(context, listen: false);
    editprovider.nameContrl = TextEditingController(text: widget.name);
    editprovider.modelContrl = TextEditingController(text: widget.model);
    editprovider.kmContrl = TextEditingController(text: widget.km);
    editprovider.dlNumberContrl = TextEditingController(text: widget.dlnbr);
    editprovider.ownerContrl = TextEditingController(text: widget.owner);
    editprovider.priceContrl = TextEditingController(text: widget.price);
    editprovider.futureContrl = TextEditingController(text: widget.future);
    editprovider.selectImage =
        widget.imagepath != '' ? File(widget.imagepath) : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('edit medium');
    final provider = Provider.of<EditScreenProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Center(
          child: Text("EDIT CARS",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w400,
              )),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(20),
              Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child:
                      Consumer<EditScreenProvider>(builder: (context, pro, _) {
                    return Image(
                      image: pro.selectImage != null
                          ? FileImage(pro.selectImage!)
                          : const AssetImage("image/carr1.png")
                              as ImageProvider,
                    );
                  }),
                ),
              ),
              const Gap(20),
              const Text('EDIT CAR PHOTO'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 161, 133, 168)),
                      onPressed: () {
                        provider.pickImage(ImageSource.gallery);
                      },
                      icon: const Icon(Icons.image),
                      label: const Text("GALLERY")),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 184, 151, 192)),
                      onPressed: () {
                        provider.pickImage(ImageSource.camera);
                      },
                      icon: const Icon(Icons.camera_alt),
                      label: const Text("CAMERA")),
                ],
              ),
              const Gap(30),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FormFieldBuild(
                          controller: provider.nameContrl, hintText: 'NAME'),
                      FormFieldBuild(
                          controller: provider.modelContrl, hintText: 'MODEL'),
                    ],
                  ),
                  const Gap(7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FormFieldBuild(
                          controller: provider.kmContrl, hintText: 'KM'),
                      FormFieldBuild(
                          controller: provider.dlNumberContrl,
                          hintText: 'DL NUMBER'),
                    ],
                  ),
                  const Gap(7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FormFieldBuild(
                          controller: provider.ownerContrl,
                          hintText: 'OWNERSHIP'),
                      FormFieldBuild(
                          controller: provider.priceContrl, hintText: 'PRICE'),
                    ],
                  ),
                  const Gap(7),
                  FormFieldBuild(
                      controller: provider.futureContrl, hintText: 'FUETERS'),
                ],
              ),
              const Gap(30),
              ElevatedButton(
                  onPressed: () {
                    updateAll();
                    Navigator.pop(context);
                  },
                  child: const Text('SUBMIT'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateAll() async {
    final prd = Provider.of<EditScreenProvider>(context, listen: false);
    final nameMd = prd.nameContrl.text;
    final modelMd = prd.modelContrl.text;
    final kmMd = prd.kmContrl.text;
    final dlnbrMd = prd.dlNumberContrl.text;
    final ownerMd = prd.ownerContrl.text;
    final priceMd = prd.priceContrl.text;
    final futureMd = prd.futureContrl.text;
    final imageMd = prd.selectImage!.path;

    if (nameMd.isEmpty ||
        modelMd.isEmpty ||
        kmMd.isEmpty ||
        dlnbrMd.isEmpty ||
        ownerMd.isEmpty ||
        priceMd.isEmpty ||
        futureMd.isEmpty ||
        imageMd.isEmpty) {
      return;
    } else {
      final update = MediumCarsModel(
          name: nameMd,
          model: modelMd,
          km: kmMd,
          dlnumber: dlnbrMd,
          owner: ownerMd,
          price: priceMd,
          future: futureMd,
          image: imageMd);
      Provider.of<DbFunctionsProvider>(context, listen: false)
          .editCarsP(DataBases.mediumDb, widget.index, update);
    }
  }
}
