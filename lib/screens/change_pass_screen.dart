import 'package:flutter/material.dart';

class ChangePassScreen extends StatelessWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

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
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  //old password
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'OLD PASSWORD',
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
                  //new password1
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'NEW PASSWORD',
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
                  const SizedBox(height: 36),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) =>
                              _buildChangePopupDialog(context),
                        );
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
