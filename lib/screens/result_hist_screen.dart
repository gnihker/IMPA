import 'package:flutter/material.dart';
import '/models/dummy_result.dart';
import '/screens/result_block.dart';

class ResultHistScreen extends StatelessWidget {
  const ResultHistScreen({Key? key}) : super(key: key);

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
        body: ListView(
            padding: const EdgeInsets.only(top: 16),
            children:
                dummyResults.map((data) => ResultBox(result: data)).toList()),
      ),
    );
  }
}
