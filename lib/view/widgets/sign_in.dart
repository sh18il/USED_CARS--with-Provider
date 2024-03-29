import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:royalcars/view/widgets/bottombar.dart';

import '../../controlls/login_provider.dart';
import '../../controlls/sign_provider.dart';
import 'register.dart';

class Singin extends StatelessWidget {
  final String username;
  final String passwoed;
  const Singin({super.key, required this.username, required this.passwoed});

  @override
  Widget build(BuildContext context) {
    log('login');
    final provider = Provider.of<LoginProvider>(context, listen: false);
    void chekLogin(context) async {
      final username2 = provider.usernameCntrLog.text;
      final password2 = provider.passwordCntrLog.text;
      if (username == username2 && passwoed == password2) {
        final sharedPref = await SharedPreferences.getInstance();
        await sharedPref.setBool(SAVE_KEY, true);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const BottomNav()));
      } else {
        showDialog(
          context: context,
          builder: (ctx1) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Username or password is incorrect'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx1).pop();
                  },
                  child: const Text('Close'),
                )
              ],
            );
          },
        );
      }
    }

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
            Column(
              children: [
                Form(
                  key: provider.sINGUPkeyLOG,
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
                            controller: provider.usernameCntrLog,
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
                                  return 'not valid';
                                }
                                return null;
                              },
                              controller: provider.passwordCntrLog,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    pro.passwordFunction();
                                  },
                                  icon: Icon(pro.isObscured
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                hintText: 'PASSWORD ',
                              ),
                            );
                          }),
                        ),
                      ),
                      const Gap(20),
                      ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black87),
                          ),
                          onPressed: () {
                            if (provider.sINGUPkeyLOG.currentState!
                                .validate()) {
                              chekLogin(context);
                            }
                          },
                          child: Container(
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Text('Login')))
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
