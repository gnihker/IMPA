import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application/screens/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;

  // our form key
  final _formKey = GlobalKey<FormState>();

  // editing Controller
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      style: const TextStyle(
        fontSize: 16.0,
        height: 0.7,
      ),
      autocorrect: false,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
      ),
    );

    final passwordField = TextFormField(
      controller: passwordEditingController,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      style: const TextStyle(
        fontSize: 16.0,
        height: 0.7,
      ),
      autocorrect: false,
      obscureText: true,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'must be 6-20 characters',
        hintStyle: TextStyle(fontSize: 14),
        border: OutlineInputBorder(),
      ),
    );

    final confirmpasswordField = TextFormField(
      controller: confirmPasswordEditingController,
      validator: (value) {
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return "Password don't match";
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      style: const TextStyle(
        fontSize: 16.0,
        height: 0.7,
      ),
      autocorrect: false,
      obscureText: true,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(fontSize: 14),
        border: OutlineInputBorder(),
      ),
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.white,
          ),
          backgroundColor: const Color.fromRGBO(63, 24, 149, 1),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.35,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      children: const [
                        Text(
                          'REGISTER',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    //email input
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'EMAIL',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 6),
                        emailField,
                      ],
                    ),
                    const SizedBox(height: 16),
                    //password input
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PASSWORD',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 6),
                        passwordField,
                      ],
                    ),
                    const SizedBox(height: 16),
                    //confirm password input
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CONFIRM PASSWORD',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 6),
                        confirmpasswordField,
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3.2,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              // showDialog(
                              //   barrierDismissible: false,
                              //   context: context,
                              //   builder: (BuildContext context) =>
                              //       _buildRegPopupDialog(context),
                              // );
                              signUp(emailEditingController.text,
                                  passwordEditingController.text);
                            },
                            child: const Text(
                              'REGISTER',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
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
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }
}

// Widget _buildRegPopupDialog(BuildContext context) {
//   return AlertDialog(
//     title: const Text(
//       'Registered!',
//       textAlign: TextAlign.center,
//     ),
//     actions: <Widget>[
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               Navigator.popUntil(context, ModalRoute.withName('/login'));
//             },
//             child: const Text(
//               'Close',
//               style: TextStyle(color: Colors.white),
//             ),
//             style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(
//                     const Color.fromRGBO(255, 214, 0, 1))),
//           ),
//         ],
//       ),
//     ],
//   );
// }

