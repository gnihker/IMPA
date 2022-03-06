import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'model_library_detail.dart';
import 'my_model_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentUser = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;
  var _recentlyUsedId;
  var _recentlyUsedLabel;
  bool _isLoading = true;
  var _tmp;

  @override
  void initState() {
    _getRecentlyUsed();
    super.initState();
  }

  Future<void> _logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popAndPushNamed(context, '/login');
  }

  Future<void> _getRecentlyUsed() async {
    _recentlyUsedId = await firestoreInstance
        .collection("users")
        .doc(currentUser?.uid)
        .get()
        .then((value) {
      return value.data()!['recentlyUsedId'];
    });

    _recentlyUsedLabel = await firestoreInstance
        .collection("users")
        .doc(currentUser?.uid)
        .get()
        .then((value) {
      return value.data()!['recentlyUsedLabel'];
    });

    setState(() {
      _isLoading = false;
      _recentlyUsedId;
      _recentlyUsedLabel;
    });
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
                  child: Text(
                    'Change password',
                    style: TextStyle(
                      color: Color.fromRGBO(105, 55, 212, 1),
                      fontSize: 14,
                    ),
                  ),
                  value: 1,
                ),
                const PopupMenuItem(
                  child: Text(
                    'About us',
                    style: TextStyle(
                      color: Color.fromRGBO(105, 55, 212, 1),
                      fontSize: 14,
                    ),
                  ),
                  value: 2,
                ),
                const PopupMenuItem(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                  value: 3,
                ),
              ],
              onSelected: (result) {
                if (result == 0) {
                  Navigator.pushNamed(context, '/resulthist');
                } else if (result == 1) {
                  Navigator.pushNamed(context, '/changepass');
                } else if (result == 2) {
                  Navigator.pushNamed(context, '/aboutus');
                } else if (result == 3) {
                  _logOut();
                }
              },
            ),
          ],
          backgroundColor: const Color.fromRGBO(63, 24, 149, 1),
        ),
        body: Container(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 15,
                        ),
                        const Text(
                          'Welcome!',
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
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
                              _isLoading = true;
                              Navigator.pushNamed(context, '/mymodels')
                                  .then((value) => _getRecentlyUsed());
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
                              _isLoading = true;
                              Navigator.pushNamed(context, '/modellib')
                                  .then((value) => _getRecentlyUsed());
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
                        const Text('Your recently used model :',
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.3,
                          height: 45,
                          child: StreamBuilder(
                              stream: firestoreInstance
                                  .collection("model_lib")
                                  .where(FieldPath.documentId,
                                      isEqualTo: _recentlyUsedId)
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Text('');
                                } else {
                                  return ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      return ElevatedButton(
                                        style: ButtonStyle(
                                            alignment: Alignment.centerLeft,
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color.fromRGBO(
                                                        255, 197, 49, 1))),
                                        child: Text(
                                          snapshot.data!.docs[index]['label'],
                                          style: const TextStyle(
                                              fontSize: 16, letterSpacing: 0.5),
                                        ),
                                        onPressed: () {
                                          _isLoading = true;
                                          if (snapshot.data!.docs[index]
                                                  ['owner'] ==
                                              'impa') {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ModelLibraryDetailScreen(
                                                  thismod: snapshot
                                                      .data!.docs[index],
                                                  modId: snapshot.data!
                                                      .docs[index].reference.id,
                                                ),
                                              ),
                                            ).then(
                                                (value) => _getRecentlyUsed());
                                          } else {
                                            _isLoading = true;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ModelDetailScreen(
                                                  thismod: snapshot
                                                      .data!.docs[index],
                                                  modId: snapshot.data!
                                                      .docs[index].reference.id,
                                                ),
                                              ),
                                            ).then(
                                                (value) => _getRecentlyUsed());
                                          }
                                        },
                                      );
                                    },
                                  );
                                }
                              }),
                        ),
                      ]),
                ]),
        ),
      ),
    );
  }
}
