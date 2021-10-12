import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/dummy_models.dart';
import 'model_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popAndPushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'HOME',
            style: TextStyle(color: Colors.white, letterSpacing: 0.8),
          ),
          actions: <Widget>[
            PopupMenuButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  child: Text('Result history',
                      style: TextStyle(
                        color: Color.fromRGBO(105, 55, 212, 1),
                        fontSize: 14,
                      )),
                  value: 0,
                ),
                const PopupMenuItem(
                  child: Text('Change password',
                      style: TextStyle(
                        color: Color.fromRGBO(105, 55, 212, 1),
                        fontSize: 14,
                      )),
                  value: 1,
                ),
                const PopupMenuItem(
                  child: Text('Logout',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      )),
                  value: 2,
                ),
              ],
              onSelected: (result) {
                if (result == 0) {
                  Navigator.pushNamed(context, '/resulthist');
                } else if (result == 1) {
                  Navigator.pushNamed(context, '/changepass');
                } else if (result == 2) {
                  //Navigator.popAndPushNamed(context, '/login');
                  _logOut();
                }
              },
            ),
          ],
          backgroundColor: const Color.fromRGBO(63, 24, 149, 1),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/images/bghome.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
              const Text(
                'Welcome!',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              //first button: my model
              const Text(
                'Add and use your model here',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/mymodels');
                  },
                  child: const Text(
                    'MY MODELS',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ButtonStyle(
                      alignment: Alignment.centerLeft,
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(105, 55, 212, 1))),
                ),
              ),
              //second button: model lib
              const SizedBox(height: 24),
              const Text(
                'Our available model',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/modellib');
                  },
                  child: const Text(
                    'MODEL LIBRARY',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ButtonStyle(
                      alignment: Alignment.centerLeft,
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(105, 55, 212, 1))),
                ),
              ),
              //third button: recently use
              const SizedBox(height: 24),
              const Text('Your recently used model',
                  style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ModelDetailScreen(thismod: dummyModels[0]),
                      ),
                    );
                  },
                  child: const Text(
                    'Leaf classification',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ButtonStyle(
                      alignment: Alignment.centerLeft,
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(255, 214, 0, 1))),
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
