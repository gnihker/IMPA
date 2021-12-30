import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import 'edit_model.dart';
import 'output_screen.dart';

class ModelDetailScreen extends StatefulWidget {
  const ModelDetailScreen({Key? key, required this.thismod}) : super(key: key);

  final QueryDocumentSnapshot<Object?> thismod;

  @override
  State<ModelDetailScreen> createState() => _ModelDetailScreenState();
}

class _ModelDetailScreenState extends State<ModelDetailScreen> {
  var currentUser = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  File? selectedImage;
  String? msg;
  XFile? pickedImage;

  //POST function, sending img file to model route with input key
  void postuploadImage() async {
    //post function, parsing image file
    final request = http.MultipartRequest(
        "POST", Uri.parse(widget.thismod['detail']['route']));

    //use model's key to add image file
    request.files.add(await http.MultipartFile.fromPath(
        widget.thismod['detail']['key'], selectedImage!.path,
        filename: selectedImage!.path.split("/").last));

    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    var ans = json.decode(res.body);
    //print(ans);

    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              OutputScreen(image: pickedImage, ans: ans.toString()),
        ),
      );
    });
  }

  //open gallery
  void galleryPicker() async {
    final _pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = _pickedImage;
      selectedImage = File(pickedImage!.path);
    });
    if (selectedImage != null) {
      postuploadImage();
    }
  }

  //open camera
  void cameraPicker() async {
    final _pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      pickedImage = _pickedImage;
      selectedImage = File(pickedImage!.path);
    });
    if (selectedImage != null) {
      postuploadImage();
    }
  }

  //function called bottom-modal for image picking
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      galleryPicker();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    cameraPicker();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> _delete() async {
    firestoreInstance
        .collection("users")
        .doc(currentUser?.uid)
        .collection("models")
        .where("label", isEqualTo: widget.thismod['label'])
        .where("detailRoute", isEqualTo: widget.thismod['detailRoute'])
        .get()
        .then((res) {
      res.docs.forEach((result) {
        firestoreInstance
            .collection("users")
            .doc(currentUser?.uid)
            .collection("models")
            .doc(result.id)
            .delete();
      });
    });
  }

  Future<dynamic> _deleteModal(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(children: const [
            Text('Delete this model?'),
          ], mainAxisAlignment: MainAxisAlignment.center),
          actionsPadding: const EdgeInsets.only(bottom: 10),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _delete();
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName('/mymodels'));
                  },
                  child: const Text(
                    'YES',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(255, 214, 0, 1))),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'NO',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(196, 196, 196, 1))),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  //main widget
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.white,
          ),
          backgroundColor: const Color.fromRGBO(63, 24, 149, 1),
          //three-dot button in appBar
          actions: <Widget>[
            PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  child: Text('Edit',
                      style: TextStyle(
                        color: Color.fromRGBO(105, 55, 212, 1),
                        fontSize: 14,
                      )),
                  value: 0,
                ),
                const PopupMenuItem(
                  child: Text('Delete',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      )),
                  value: 1,
                ),
              ],
              onSelected: (result) {
                if (result == 0) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditModelScreen(thismod: widget.thismod),
                    ),
                  );
                } else if (result == 1) {
                  _deleteModal(context);
                  // showDialog(
                  //   barrierDismissible: false,
                  //   context: context,
                  //   builder: (BuildContext context) =>
                  //       _deleteModal(context),
                  // );
                }
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.thismod['label'],
                      style: const TextStyle(fontSize: 20, letterSpacing: 0.5),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromRGBO(196, 196, 196, 1))),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.thismod['detail']['description'],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Endpoint Method: ' + widget.thismod['detail']['method'],
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Endpoint Route: \n' + widget.thismod['detail']['route'],
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Key value: ' + widget.thismod['detail']['method'],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _showPicker(context);
                },
                child: const Text(
                  'USE THIS MODEL',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(105, 55, 212, 1))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//appbar 3dots panel
Widget _buildDeletePopupDialog(BuildContext context) {
  return AlertDialog(
    title: Row(children: const [
      Text('Delete this model?'),
    ], mainAxisAlignment: MainAxisAlignment.center),
    actionsPadding: const EdgeInsets.only(bottom: 10),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).popUntil(ModalRoute.withName('/mymodels'));
            },
            child: const Text(
              'YES',
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(255, 214, 0, 1))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'NO',
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(196, 196, 196, 1))),
          ),
        ],
      ),
    ],
  );
}
