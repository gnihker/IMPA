import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _changePassword(String password) async {
    //ตอนนี้ฟังก์ชันนี้ยังไม่ได้เช็คว่า current password ที่ใส่ไปถูกมั้ย
    var currentUser = FirebaseAuth.instance.currentUser;

    if (_formKey.currentState!.validate()) {
      await currentUser?.updatePassword(password).then((_) {
        Fluttertoast.showToast(msg: "Password changed successfully!");
        Navigator.pushAndRemoveUntil(
            (context),
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      }).catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final oldPasswordField = TextFormField(
      controller: oldPasswordController,
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

    final newPasswordField = TextFormField(
      controller: newPasswordController,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("New password is required");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) {
        newPasswordController.text = value!;
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
      controller: confirmPasswordController,
      validator: (value) {
        if (confirmPasswordController.text != newPasswordController.text) {
          return "Password don't match";
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordController.text = value!;
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
          centerTitle: true,
          title: const Text(
            'Change password',
            style: TextStyle(
              color: Colors.white,
            ),
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
                    //new password1
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'NEW PASSWORD',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 6),
                        newPasswordField,
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
                    const SizedBox(height: 36),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          _changePassword(newPasswordController.text);
                        },
                        child: const Text(
                          'Change password',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(255, 214, 0, 1))),
                      ),
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
}

Widget _buildChangePopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text(
      'Password changed successfully!',
      textAlign: TextAlign.center,
    ),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).popUntil(ModalRoute.withName('/home'));
            },
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(255, 214, 0, 1))),
          ),
        ],
      ),
    ],
  );
}
