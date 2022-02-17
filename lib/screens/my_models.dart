import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'my_model_detail.dart';

class MyModelsScreen extends StatefulWidget {
  const MyModelsScreen({Key? key}) : super(key: key);

  @override
  State<MyModelsScreen> createState() => _MyModelsScreenState();
}

class _MyModelsScreenState extends State<MyModelsScreen> {
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
        body: _buildModelList(context),
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

Widget _buildModelList(BuildContext context) {
  var currentUser = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  return Container(
    child: StreamBuilder(
        stream: firestoreInstance
            .collection("model_lib")
            .where('owner', isEqualTo: currentUser?.uid)
            .orderBy('timestamp', descending: false)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            //return const Center(
            //  child: CircularProgressIndicator(),
            //);
            return const Center(
                child: Text(
              'You have no model',
              style: TextStyle(color: Colors.grey),
            ));
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
                      builder: (context) => ModelDetailScreen(
                        thismod: snapshot.data!.docs[index],
                        modId: snapshot.data!.docs[index].reference.id,
                      ),
                    ),
                  );
                },
              );
            },
          );
        }),
  );
}
