import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/screens/model_library_detail.dart';

class ModelLibraryScreen extends StatefulWidget {
  const ModelLibraryScreen({Key? key}) : super(key: key);

  @override
  State<ModelLibraryScreen> createState() => _ModelLibraryScreenState();
}

class _ModelLibraryScreenState extends State<ModelLibraryScreen> {
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
            style: TextStyle(color: Colors.white, letterSpacing: 0.8),
          ),
          backgroundColor: const Color.fromRGBO(63, 24, 149, 1),
        ),
        body: _buildModelList(context),
      ),
    );
  }
}

Widget _buildModelList(BuildContext context) {
  final firestoreInstance = FirebaseFirestore.instance;

  return Container(
    child: StreamBuilder(
        stream: firestoreInstance
            .collection("model_lib")
            .where('owner', isEqualTo: 'impa')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black,
            ),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  snapshot.data!.docs[index]['label'],
                  style: const TextStyle(fontSize: 16, letterSpacing: 0.5),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ModelLibraryDetailScreen(
                          thismod: snapshot.data!.docs[index]),
                    ),
                  );
                },
              );
            },
          );
        }),
  );
}
