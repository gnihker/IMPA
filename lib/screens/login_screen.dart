import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/images/bglogin.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            //including 2 inputs and log-in button
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: const AssetImage('lib/assets/images/logo.png'),
                    width: MediaQuery.of(context).size.width / 1.5,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Welcome!',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/reg');
                          },
                          child: const Text('Register',
                              style: TextStyle(fontSize: 14)))
                    ],
                  ),
                  const SizedBox(height: 10),
                  //email input
                  TextFormField(
                    style: const TextStyle(
                      fontSize: 16.0,
                      height: 0.7,
                    ),
                    autocorrect: false,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //password input
                  TextFormField(
                    style: const TextStyle(
                      fontSize: 16.0,
                      height: 0.7,
                    ),
                    autocorrect: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  //login button
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.2,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: const Text(
                        'LOG IN',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(255, 214, 0, 1))),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forget');
                      },
                      child: const Text(
                        'Forget password?',
                        style:
                            TextStyle(color: Color.fromRGBO(189, 189, 189, 1)),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
