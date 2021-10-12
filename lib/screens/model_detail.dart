import 'package:flutter/material.dart';
import 'package:flutter_application/screens/edit_model.dart';
import 'package:flutter_application/screens/output_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../models/model.dart';

class ModelDetailScreen extends StatefulWidget {
  const ModelDetailScreen({Key? key, required this.thismod}) : super(key: key);

  final Model thismod;

  @override
  State<ModelDetailScreen> createState() => _ModelDetailScreenState();
}

class _ModelDetailScreenState extends State<ModelDetailScreen> {
  final ImagePicker _picker = ImagePicker();
  //XFile? image;

  void _GalleryPicker() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    //print(selectedImage!.path);
    if (selectedImage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OutputScreen(image: selectedImage),
        ),
      );
    }
  }

  void _CameraPicker() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.camera);
    //print(selectedImage!.path);
    if (selectedImage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OutputScreen(image: selectedImage),
        ),
      );
    }
  }

  //function called bottom-modal for image picking
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Photo Library'),
                      onTap: () {
                        _GalleryPicker();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _CameraPicker();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
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
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) =>
                        _buildDeletePopupDialog(context),
                  );
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
                      widget.thismod.label,
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
                            widget.thismod.description!,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Endpoint Method: ' + widget.thismod.method,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Endpoint Route: \n' + widget.thismod.route,
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
