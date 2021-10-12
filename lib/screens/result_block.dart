import 'package:flutter/material.dart';

import '/models/result.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({Key? key, required this.result}) : super(key: key);

  final Result result;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Card(
      elevation: 4,
      margin: const EdgeInsets.only(top: 2, bottom: 12, right: 24, left: 24),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Model label: ' + result.label,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Result: ' + result.result,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Date: ' + result.date,
                style: const TextStyle(fontSize: 12),
              ),
            ]),
            Image(
              image: NetworkImage(result.imgURL),
              height: 40,
              width: 40,
            )
          ],
        ),
      ),
    ));
  }
}
