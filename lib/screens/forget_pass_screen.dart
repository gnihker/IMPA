import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  void _resetPassword() async {
    String email = emailController.text.toString();
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(msg: "The email has been sent!");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
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
                child: Column(children: [
                  const SizedBox(height: 30),
                  Row(
                    children: const [
                      Text(
                        'FORGET PASSWORD',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'We will email you a link to reset your password',
                    style: TextStyle(fontSize: 14),
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
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: emailController,
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
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        //showDialog(
                        //  barrierDismissible: false,
                        //  context: context,
                        //  builder: (BuildContext context) =>
                        //_buildSendPopupDialog(context),
                        //);
                        _resetPassword();
                      },
                      child: const Text(
                        'SEND EMAIL',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(255, 214, 0, 1))),
                    ),
                  ),
                ])),
          ),
        ),
      ),
    );
  }
}

// Widget _buildSendPopupDialog(BuildContext context) {
//   return AlertDialog(
//     title: const Text(
//       'Email sent!',
//       textAlign: TextAlign.center,
//     ),
//     actions: <Widget>[
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
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
//}
