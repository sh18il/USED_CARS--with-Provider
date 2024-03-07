import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:royalcars/model/luxurycar/cars_model.dart';

import 'package:royalcars/view/luxuryscreen/view_luxuy_screen.dart';

import '../../controlls/add_provider.dart';
import '../../controlls/dbfunctions_provider.dart';
import '../../controlls/search_lprovider.dart';
import '../editscreen_luxury.dart';

class LuxurycarsScreen extends StatelessWidget {
  const LuxurycarsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchPro = Provider.of<SearchProvider>(context, listen: false);
    Provider.of<DbFunctionsProvider>(context, listen: false)
        .getAllCarsP(DataBases.luxuryDb);
    log('Luxury');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: SizedBox(
          width: double.infinity,
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.only(left: 10),
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                searchPro.searchLx = value;
                searchPro.searchListUpdateLuxury(context);
              },
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: 'Search here.. Luxury cars',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none),
            ),
          ),
        ),
        actions: [
          Consumer<SearchProvider>(builder: (context, provider, _) {
            return IconButton(
                onPressed: () {
                  provider.searchListUpdateLuxury(context);
                },
                icon: const Icon(Icons.refresh));
          }),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child:
                Consumer<DbFunctionsProvider>(builder: (context, provider, _) {
              return searchPro.searchLx.isNotEmpty
                  ? provider.searchedListLuxury.isEmpty
                      ? ListView(
                          children: [
                            Lottie.asset(
                                'assets/Animation - 1707811402766.json'),
                          ],
                        )
                      : buildCArList(provider.searchedListLuxury)
                  : buildCArList(provider.carsListNotifier);
            }),
          ),
          Consumer<DbFunctionsProvider>(builder: (context, provide, _) {
            return Text(
              'Total Luxury Cars Found: ${provide.searchedListLuxury.length}',
            );
          }),
        ],
      ),
    );
  }

  Widget buildCArList(List<CarsModel> carsList) {
    return carsList.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Lottie.asset('assets/Animation - 1707811402766.json'),
              ),
              // Text('No cars available'),
            ],
          )
        : ListView.separated(
            itemCount: carsList.length,
            itemBuilder: (context, index) {
              CarsModel car = carsList[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewLuxuryScreen(
                            name: car.name,
                            model: car.model,
                            km: car.km,
                            index: index,
                            dlnbr: car.dlnumber,
                            owner: car.owner,
                            price: car.price,
                            future: car.future,
                            imagepath: car.image)));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        // Text(total.toString()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(30)),
                                color: Color.fromARGB(255, 224, 149, 144),
                              ),
                              width: 30,
                              child: const Column(
                                children: [
                                  Text('R'),
                                  Text('o'),
                                  Text('Y'),
                                  Text('A'),
                                  Text('L'),
                                ],
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color.fromARGB(255, 213, 201, 201),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: car.image != null
                                      ? FileImage(File(car.image!))
                                      : const AssetImage("image/carr1.png")
                                          as ImageProvider,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Confirm Deletion'),
                                          content: const Text(
                                              'Are you sure you want to delete this car?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Provider.of<DbFunctionsProvider>(
                                                        context,
                                                        listen: false)
                                                    .deleteCars(
                                                        DataBases.luxuryDb,
                                                        index);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Delete'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => EditLuxury(
                                                    name: car.name,
                                                    model: car.model,
                                                    km: car.km,
                                                    index: index,
                                                    dlnbr: car.dlnumber,
                                                    owner: car.owner,
                                                    price: car.price,
                                                    future: car.future,
                                                    imagepath: car.image ?? "",
                                                  )));
                                    },
                                    icon: const Icon(Icons.edit_document)),
                              ],
                            )
                          ],
                        ),
                        Text(car.name),
                        const Gap(20),
                        Text(car.dlnumber),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  color: Colors.white,
                ),
              );
            },
          );
  }
}
