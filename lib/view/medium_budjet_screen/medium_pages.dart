import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:royalcars/view/medium_budjet_screen/medium_edit.dart';
import 'package:royalcars/view/medium_budjet_screen/view_medium_screen.dart';
import '../../controlls/add_provider.dart';
import '../../controlls/dbfunctions_provider.dart';
import '../../controlls/search_lprovider.dart';
import '../../model/mediumcar/medium_cars_model.dart';

class Midiumcars extends StatelessWidget {
  const Midiumcars({Key? key}) : super(key: key);
   
  @override
  Widget build(BuildContext context) {
     final searchPro = Provider.of<SearchProvider>(context,listen: false);
    log('medium');
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
                    searchPro.searchM = value;
                    searchPro.searchListUpdateMedium(context);
                  },
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: 'Search here.. Medium cars',
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none),
                ),
              ),
        ),
        actions: [
         
            IconButton(
                onPressed: () {
                  searchPro.searchListUpdateMedium(context);
                },
                icon: const Icon(Icons.refresh))
        
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child:
                Consumer<DbFunctionsProvider>(builder: (context, provider, _) {
             
              final carLList = provider.carsMediumListNotifier;
              return searchPro.searchM.isNotEmpty
                  ? provider.searchedListMedium.isEmpty
                      ? ListView(
                          children: [
                            Lottie.asset(
                                'assets/Animation - 1707811402766.json'),
                          ],
                        )
                      : buildCArList(provider.searchedListMedium)
                  : buildCArList(carLList);
            }),
          ),
          Consumer<DbFunctionsProvider>(builder: (context, provide, _) {
            return Text(
              'Total Medium Cars Found: ${provide.searchedListMedium.length}',
            );
          }),
        ],
      ),
    );
  }

  Widget buildCArList(List<MediumCarsModel> carsList) {
    return carsList.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Lottie.asset('assets/Animation - 1707811402766.json'),
              )
            ],
          )
        : ListView.separated(
            itemCount: carsList.length,
            itemBuilder: (context, index) {
              MediumCarsModel car = carsList[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MediumViewScreen(
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
                                                        DataBases.mediumDb,
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
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MediumEditScreen(
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
                        const Gap(20),
                        Text(car.name),
                        const Gap(20),
                        Text(car.dlnumber),
                        const Gap(20),
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
