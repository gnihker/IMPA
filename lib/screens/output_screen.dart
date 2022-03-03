import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class OutputScreen extends StatelessWidget {
  const OutputScreen({Key? key, required this.image, required this.ans})
      : super(key: key);

  final XFile? image;
  final dynamic ans;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* AppBar section */
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        centerTitle: true,
        title: const Text(
          'RESULT',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 0.8,
          ),
        ),
        backgroundColor: const Color.fromRGBO(63, 24, 149, 1),
      ),
      /* End of AppBar Section */
      /* Body Section */
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Container of input
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                //light grey border
                border: Border.all(
                  color: const Color.fromRGBO(196, 196, 196, 1),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(1, 2)),
                ],
              ),
              height: MediaQuery.of(context).size.height / 2,
              //width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 24, left: 24, right: 24),
              child: Column(
                children: [
                  //using container to make the 'input' box header
                  Container(
                    height: 32,
                    //align the word 'input' using padding
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    //width = parent container witdth
                    width: MediaQuery.of(context).size.width,
                    //bg color
                    color: const Color.fromRGBO(63, 24, 149, 1),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Input',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  //Expanded widget makes its child fills the available space along the flex widget's main axis which is Column in this case (Y axis)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      height: 10,
                      child: Image.file(
                        File(image!.path),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Container of the output
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color.fromRGBO(196, 196, 196, 1),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(1, 2)),
                ],
              ),
              height: MediaQuery.of(context).size.height / 2,
              margin: const EdgeInsets.all(24),
              child: Column(
                children: [
                  //header
                  Container(
                    height: 32,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    width: MediaQuery.of(context).size.width,
                    color: const Color.fromRGBO(63, 24, 149, 1),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Output',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ElevatedButton(
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: ans.toString()));
                            },
                            child: const Text('Copy All'),
                            style: ButtonStyle(
                                alignment: Alignment.centerLeft,
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(255, 197, 49, 1))),
                          ),
                        )
                      ],
                    ),
                  ),
                  //output zone
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: SelectableText(
                                ans.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    /* End of Body Section */
  }
}
