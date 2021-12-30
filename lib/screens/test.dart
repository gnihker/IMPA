import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  var currentUser = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetch1() async {
    String URL = "http://10.0.2.2:5000/detail";
    var parseURL = Uri.parse("http://10.0.2.2:5000/detail");
    final response = await http.get(parseURL);
    var detailResponse = json.decode(response.body);
    print(detailResponse);

    //create an object from the response
    final res = Detail.fromJson(detailResponse);
    print(res);
    print(currentUser?.uid);
    Model tmp = Model(detail: res, detailRoute: URL, label: "test");
    print(tmp.detail.imgType);
  }

  Future<void> _fetchUsersModels() async {
    firestoreInstance
        .collection("users")
        .doc(currentUser?.uid)
        .collection("models")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
      });
    });
  }

  Future<void> _addNewModel() async {
    firestoreInstance
        .collection("users")
        .doc(currentUser?.uid)
        .collection("models")
        .add({
      'label': 'add to firebase test',
      'detail': {
        'description': 'test',
        'imgType': 'file',
        'key': 'img',
        'method': 'POST',
        'route': 'test route'
      },
      'detailRoute': 'test detail route',
    });
  }

  Future<void> _testDetail1(url) async {
    var parseURL = Uri.parse(url);
    final response = await http.get(parseURL);
    var detailResponse = json.decode(response.body);
    print(detailResponse);
    print(detailResponse.runtimeType);
    firestoreInstance
        .collection("users")
        .doc(currentUser?.uid)
        .collection("models")
        .add({
      'label': 'get and add detail test',
      'detail': detailResponse,
      'detailRoute': url,
    });
  }

  Future<void> _testUpdate1(url) async {
    // var _parseURL = Uri.parse(url);
    // final response = await http.get(_parseURL);
    // var _detailResponse = json.decode(response.body);
    // firestoreInstance
    //     .collection("users")
    //     .doc(currentUser?.uid)
    //     .collection("models")
    //     .where("name", isEqualTo: "john")
    //     .getDocuments()
    //     .then((res) {
    //   res.documents.forEach((result) {
    //     Firestore.instance
    //         .collection("path")
    //         .document("docPath")
    //         .collection("subCollection")
    //         .document(result.documentID)
    //         .updateData({"name": "martin"});
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Test Page',
            style: TextStyle(color: Colors.white, letterSpacing: 0.8),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  child: Text('Add New Model Test!'),
                  onPressed: () {
                    _addNewModel();
                  }),
              ElevatedButton(
                child: Text('Fetch User\'s Models Test!'),
                onPressed: () {
                  _fetchUsersModels();
                },
              ),
              ElevatedButton(
                child: Text('Get Detail and Add Test!'),
                onPressed: () {
                  _testDetail1("http://10.0.2.2:5000/detail");
                },
              ),
              ElevatedButton(
                child: Text('Update Model Information!'),
                onPressed: () {
                  _testUpdate1("http://10.0.2.2:5000/test1");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
