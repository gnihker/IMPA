import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
                    children: const [
                      Text(
                        'EMAIL',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 6),
                      TextField(
                        style: TextStyle(
                          fontSize: 16.0,
                          height: 0.7,
                        ),
                        autocorrect: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  //password input
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'PASSWORD',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 6),
                      TextField(
                        style: TextStyle(
                          fontSize: 16.0,
                          height: 0.7,
                        ),
                        autocorrect: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'must be 6-20 characters',
                          hintStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  //confirm password input
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'CONFIRM PASSWORD',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 6),
                      TextField(
                        style: TextStyle(
                          fontSize: 16.0,
                          height: 0.7,
                        ),
                        autocorrect: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(),
                        ),
                      ),
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
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildRegPopupDialog(context),
                            );
                          },
                          child: const Text(
                            'REGISTER',
                            style: TextStyle(fontSize: 16, color: Colors.white),
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
    );
  }
}

Widget _buildRegPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text(
      'Registered!',
      textAlign: TextAlign.center,
    ),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/login'));
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
