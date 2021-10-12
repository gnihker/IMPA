import 'package:flutter/material.dart';

import 'package:flutter_application/models/model.dart';

class EditModelScreen extends StatefulWidget {
  const EditModelScreen({Key? key, required this.thismod}) : super(key: key);

  final Model thismod;

  @override
  State<EditModelScreen> createState() => _EditModelScreenState();
}

class _EditModelScreenState extends State<EditModelScreen> {
  String _dropdownValue = 'GET';

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
            'EDIT MODEL',
            style: TextStyle(color: Colors.white, letterSpacing: 0.8),
          ),
          backgroundColor: const Color.fromRGBO(63, 24, 149, 1),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(top: 40),
              width: MediaQuery.of(context).size.width / 1.35,
              child: Column(
                children: [
                  //model label
                  TextFormField(
                    maxLength: 32,
                    initialValue: widget.thismod.label,
                    style: const TextStyle(
                      fontSize: 16.0,
                      height: 1,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Model label',
                      counterText: "",
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'max 32 characters',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    child: InputDecorator(
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      child: DropdownButton(
                        value: _dropdownValue,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 20,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            _dropdownValue = newValue!;
                          });
                        },
                        items: <String>['GET', 'POST', 'PATCH']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    child: TextFormField(
                      initialValue: widget.thismod.route,
                      style: const TextStyle(
                        fontSize: 16.0,
                        height: 1,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Endpoint route',
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'example; https://test.io/api/10',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 15,
                  ),
                  //model description
                  TextFormField(
                    initialValue: widget.thismod.description,
                    maxLength: 256,
                    maxLines: 15,
                    style: const TextStyle(
                      fontSize: 16.0,
                      height: 1,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Model Description',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  // save button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildSavePopupDialog(context),
                            );
                          },
                          child: const Text(
                            'SAVE',
                            style: TextStyle(fontSize: 16, color: Colors.white),
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
