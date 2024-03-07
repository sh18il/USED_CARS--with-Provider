import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../controlls/sign_provider.dart';
import 'sign_in.dart';

// ignore: constant_identifier_names
const SAVE_KEY = 'usrLogedin';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log('sign');
    final provider = Provider.of<SignAndLoginProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              alignment: const Alignment(-0.8, 0.6),
              child: const Text("ROYAL CARS ",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  )),
            ),
            const Gap(30),
            SizedBox(
              height: 350,
              child: Image.asset(
                "image/carr1.png",
                width: 524,
                height: 210,
              ),
            ),
            Form(
              key: provider.sINGUPkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 305,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'not valid';
                          }
                          return null;
                        },
                        controller: provider.usernameCntr,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          prefixIcon: const Icon(Icons.person_3),
                          hintText: 'USER NAME ',
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 305,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Consumer<SignAndLoginProvider>(
                            builder: (context, pro, _) {
                          return TextFormField(
                            obscureText: pro.isObscured,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                            controller: provider.passwordCntr,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  pro.passwordFunction();
                                },
                                icon: Icon(pro.isObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              hintText: 'Password',
                            ),
                          );
                        })),
                  ),
                  const Gap(20),
                  ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black87),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm USERNAME & PASSWORD"),
                              content: const Text("Are you sure ?"),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    if (provider.sINGUPkey.currentState!
                                        .validate()) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => Singin(
                                                username:
                                                    provider.usernameCntr.text,
                                                passwoed: provider
                                                    .passwordCntr.text)),
                                      );
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text('Sing up')))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
