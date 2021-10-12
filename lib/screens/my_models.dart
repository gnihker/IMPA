import 'package:flutter/material.dart';
import './model_detail.dart';

import '../models/dummy_models.dart';

class MyModelsScreen extends StatelessWidget {
  const MyModelsScreen({Key? key}) : super(key: key);

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
            'MY MODELS',
            style: TextStyle(color: Colors.white, letterSpacing: 0.8),
          ),
          backgroundColor: const Color.fromRGBO(63, 24, 149, 1),
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            color: Colors.black,
          ),
          itemCount: dummyModels.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                dummyModels[index].label,
                style: const TextStyle(fontSize: 16, letterSpacing: 0.5),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ModelDetailScreen(thismod: dummyModels[index]),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addnewmod');
          },
          child: const Icon(Icons.add),
          backgroundColor: const Color.fromRGBO(63, 24, 149, 1),
        ),
      ),
    );
  }
}
