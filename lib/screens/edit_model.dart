import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditModelScreen extends StatefulWidget {
  const EditModelScreen({Key? key, required this.thismod, required this.modId})
      : super(key: key);

  final QueryDocumentSnapshot<Object?> thismod;
  final String modId;

  @override
  State<EditModelScreen> createState() => _EditModelScreenState();
}

class _EditModelScreenState extends State<EditModelScreen> {
  var currentUser = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  late final _label = TextEditingController(text: widget.thismod['label']);
  late final _detailRoute =
      TextEditingController(text: widget.thismod['detailRoute']);
  final _modelKey = GlobalKey<FormState>();

  Future<void> _updateModelToFirebase() async {
    var _url = _detailRoute.text;
    var _parseURL = Uri.parse(_detailRoute.text);
    final response = await http.get(_parseURL);
    var _detailResponse = json.decode(response.body);
    firestoreInstance
        .collection("model_lib")
        .where(FieldPath.documentId, isEqualTo: widget.modId)
        .get()
        .then((res) {
      res.docs.forEach((result) {
        firestoreInstance.collection("model_lib").doc(result.id).update({
          "label": _label.text,
          "detailRoute": _url,
          "detail": _detailResponse
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _labelField = TextFormField(
      controller: _label,
      maxLength: 32,
      validator: (value) {
        if (value!.isEmpty) {
          return ("This field cannot be empty");
        }
        return null;
      },
      onSaved: (value) {
        _label.text = value!;
      },
      textInputAction: TextInputAction.next,
      style: const TextStyle(
        fontSize: 14.0,
        height: 1,
      ),
      autocorrect: false,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
        hintText: 'max 32 characters',
        counterText: "",
      ),
    );

    final _detailRouteField = TextFormField(
      controller: _detailRoute,
      validator: (value) {
        if (value!.isEmpty) {
          return ("This field cannot be empty");
        }
        return null;
      },
      onSaved: (value) {
        _detailRoute.text = value!;
      },
      textInputAction: TextInputAction.next,
      style: const TextStyle(
        fontSize: 14.0,
        height: 1,
      ),
      autocorrect: false,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
        hintText: 'example; http://test.io/api/detail',
      ),
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.white,
          ),
          centerTitle: true,
          title: const Text(
            'EDIT MODEL',
            style: TextStyle(color: Colors.white, letterSpacing: 0.8),
          ),
          backgroundColor: const Color.fromRGBO(63, 24, 149, 1),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width / 1.35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _modelKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Model label',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 2),
                            _labelField,
                            const SizedBox(height: 16)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Detail Endpoint Route',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 2),
                            _detailRouteField,
                          ],
                        ),
                        const SizedBox(height: 16),
                        // save button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_modelKey.currentState!.validate()) {
                                    _updateModelToFirebase();
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          _buildSavePopupDialog(context),
                                    );
                                  }
                                },
                                child: const Text(
                                  'SAVE',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromRGBO(255, 214, 0, 1))),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //example section
                  const SizedBox(height: 16),
                  const SizedBox(
                    child: Text('What\'is the Detail Endpoint Route?',
                        style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.grey[350],
                    child: const Text(
                        'It\'s the endpoint route that will help our application to understand your image processing model by using GET method and it needs to return the exact form of json',
                        style: TextStyle(fontSize: 14)),
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(
                      child: Text(
                    'The Detail Endpoint Route needs to return these details',
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  )),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.grey[350],
                    child: const Text(
                        "method = POST\n(our application only support models using POST method)\nroute = model image submission route\nkey = key using in the request body\nimgType = file or base64\ndescription = model description"),
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(
                    child: Text(
                      "- Example -",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.35,
                    padding: const EdgeInsets.all(12),
                    child: const Text(
                      "{ method: 'POST',\nroute: 'http://test.io/api/submit',\nkey: 'img',\nimgType: file\ndescription: 'this is a test model'}",
                    ),
                    color: Colors.grey[350],
                  ),
                  const SizedBox(
                    child: Text(
                      '**must returns in this exact json format**',
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildSavePopupDialog(BuildContext context) {
  return AlertDialog(
    title: Row(children: const [
      Text('Save successfully'),
    ], mainAxisAlignment: MainAxisAlignment.center),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              //Navigator.of(context).popUntil(ModalRoute.withName('/mymodels'));
              Navigator.of(context).pop(context);
              Navigator.of(context).pop(context);
            },
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(255, 214, 0, 1))),
          ),
        ],
      ),
    ],
  );
}
