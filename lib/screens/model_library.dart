import 'package:flutter/material.dart';
import './model_detail.dart';

import '../models/dummy_models.dart';

class ModelLibraryScreen extends StatelessWidget {
  const ModelLibraryScreen({Key? key}) : super(key: key);

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
            'MODEL LIBRARY',
            style: TextStyle(
              color: Colors.white,
            ),
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
              title: Text(dummyModels[index].label),
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
      ),
    );
  }
}
