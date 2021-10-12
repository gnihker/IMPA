import 'package:flutter/material.dart';

class AddNewModelScreen extends StatefulWidget {
  const AddNewModelScreen({Key? key}) : super(key: key);

  @override
  State<AddNewModelScreen> createState() => _AddNewModelScreenState();
}

class _AddNewModelScreenState extends State<AddNewModelScreen> {
  String dropdownValue = 'GET';

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
            'ADD NEW MODEL',
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
                  const TextField(
                    maxLength: 32,
                    style: TextStyle(
                      fontSize: 16.0,
                      height: 1,
                    ),
                    decoration: InputDecoration(
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
                        value: dropdownValue,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 20,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
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
                  const SizedBox(
                    child: TextField(
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1,
                      ),
                      decoration: InputDecoration(
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
                  const TextField(
                    maxLength: 256,
                    maxLines: 15,
                    style: TextStyle(
                      fontSize: 16.0,
                      height: 1,
                    ),
                    decoration: InputDecoration(
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
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.pop(context);
                      //   },
                      //   child: const Text(
                      //     'SAVE & USE',
                      //     style: TextStyle(fontSize: 16, color: Colors.white),
                      //   ),
                      //   style: ButtonStyle(
                      //       backgroundColor: MaterialStateProperty.all(
                      //           const Color.fromRGBO(187, 240, 75, 1))),
                      // ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialog(context),
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

Widget _buildPopupDialog(BuildContext context) {
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
              Navigator.of(context).popUntil(ModalRoute.withName('/mymodels'));
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
