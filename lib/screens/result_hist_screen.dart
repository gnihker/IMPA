import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResultHistScreen extends StatefulWidget {
  const ResultHistScreen({Key? key}) : super(key: key);

  @override
  State<ResultHistScreen> createState() => _ResultHistScreenState();
}

class _ResultHistScreenState extends State<ResultHistScreen> {
  var currentUser = FirebaseAuth.instance.currentUser;
  var firestoreInstance = FirebaseFirestore.instance;

  Future<void> _delete() async {
    firestoreInstance
        .collection("users")
        .doc(currentUser?.uid)
        .collection("history")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    setState(() {
      firestoreInstance = FirebaseFirestore.instance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.white,
          ),
          centerTitle: true,
          title: const Text(
            'RESULT HISTORY',
            style: TextStyle(color: Colors.white, letterSpacing: 0.8),
          ),
          backgroundColor: const Color.fromRGBO(63, 24, 149, 1),
        ),
        body: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: ElevatedButton(
                      onPressed: () {
                        _delete();
                      },
                      child: const Text('Clear all'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(196, 196, 196, 1),
                      )),
                    ),
                  ),
                ],
              ),
              Flexible(
                child: StreamBuilder(
                    stream: firestoreInstance
                        .collection("users")
                        .doc(currentUser?.uid)
                        .collection("history")
                        .orderBy('Timestamp', descending: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 3,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                              children: <TextSpan>[
                                                const TextSpan(
                                                    text: 'Model label: ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                  text: snapshot.data!
                                                      .docs[index]['label'],
                                                ),
                                              ],
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                              children: <TextSpan>[
                                                const TextSpan(
                                                    text: 'Date: ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                  text: DateTime.parse(snapshot
                                                          .data!
                                                          .docs[index]
                                                              ['Timestamp']
                                                          .toDate()
                                                          .toString())
                                                      .toString(),
                                                ),
                                              ],
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                              children: <TextSpan>[
                                                const TextSpan(
                                                    text: 'Result: ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                  text: snapshot.data!
                                                      .docs[index]['result']
                                                      .toString(),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Image(
                                        width: 100,
                                        image: Image.memory(
                                                const Base64Decoder().convert(
                                                    snapshot.data!.docs[index]
                                                        ['imgBase64']))
                                            .image)
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
