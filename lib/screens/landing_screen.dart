import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/user_model.dart';
import 'package:flutter_application/screens/home.dart';
import 'package:flutter_application/screens/login_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool _loggedin = false;
  bool _checking = true;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    // FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(user!.uid)
    //     .get()
    //     .then((value) => this.loggedInUser = UserModel.fromMap(value.data()));
    _checkIfIsLogged();
  }

  Future<void> _checkIfIsLogged() async {
    setState(() {
      _checking = false;
    });
    if (user != null) {
      _loggedin = true;
      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) => loggedInUser = UserModel.fromMap(value.data()));
      setState(() {
        _loggedin = true;
      });
    } else {
      _loggedin = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _checking
        ? const Center(
            child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ))
        : _loggedin
            ? const HomeScreen()
            : const LoginScreen();
    //Scaffold(
    //body: SafeArea(
    //child: Center(

    // child: Column(
    //   children: [
    //     const Text('Login'),
    //     ElevatedButton(
    //         onPressed: () {
    //           Navigator.pushReplacementNamed(context, '/login');
    //         },
    //         child: const Text('log in'))
    //   ],
    // ),
    //),
    //));
  }
}
