import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:royalcars/model/luxurycar/cars_model.dart';

import 'package:royalcars/view/widgets/editpage.dart';

import '../controlls/add_provider.dart';
import '../controlls/dbfunctions_provider.dart';
import '../controlls/edit_screen_provider.dart';

// ignore: must_be_immutable
class EditLuxury extends StatefulWidget {
  String name;
  String model;
  String km;
  int index;
  String dlnbr;
  String owner;
  String price;
  String future;
  dynamic imagepath;
  EditLuxury({
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
  State<EditLuxury> createState() => _EditLuxuryState();
}

class _EditLuxuryState extends State<EditLuxury> {
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
    log('editScreen Lx');
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
    final namelx = prd.nameContrl.text;
    final modellx = prd.modelContrl.text;
    final kmlx = prd.kmContrl.text;
    final dlnbrlx = prd.dlNumberContrl.text;
    final ownerlx = prd.ownerContrl.text;
    final pricelx = prd.priceContrl.text;
    final futurelx = prd.futureContrl.text;
    final imagelx = prd.selectImage!.path;

    if (namelx.isEmpty ||
        modellx.isEmpty ||
        kmlx.isEmpty ||
        dlnbrlx.isEmpty ||
        ownerlx.isEmpty ||
        pricelx.isEmpty ||
        futurelx.isEmpty ||
        imagelx.isEmpty) {
      return;
    } else {
      final update = CarsModel(
          name: namelx,
          model: modellx,
          km: kmlx,
          dlnumber: dlnbrlx,
          owner: ownerlx,
          price: pricelx,
          future: futurelx,
          image: imagelx);
      Provider.of<DbFunctionsProvider>(context, listen: false)
          .editCarsP(DataBases.luxuryDb, widget.index, update);
    }
  }
}
