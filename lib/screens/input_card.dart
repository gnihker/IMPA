import 'package:flutter/material.dart';

class InputCard extends StatelessWidget {
  const InputCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(children: [
      Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        width: MediaQuery.of(context).size.width,
        color: const Color.fromRGBO(63, 24, 149, 1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Input',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
      const Expanded(
        child: Text('test'),
      )
    ]));
  }
}
