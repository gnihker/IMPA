import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application/screens/home.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //textfield for email
    final emailField = TextFormField(
      style: const TextStyle(
        fontSize: 16.0,
        height: 0.7,
      ),
      autocorrect: false,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Email',
        border: OutlineInputBorder(),
      ),
      controller: emailController,
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
        emailController.text = value!;
      },
    );

    final passwordField = TextFormField(
      style: const TextStyle(
        fontSize: 16.0,
        height: 0.7,
      ),
      autocorrect: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password (Min. 6 Character)");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Password',
        border: OutlineInputBorder(),
      ),
    );

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
              child: Form(
                key: _formKey,
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
                    emailField,
                    const SizedBox(height: 20),
                    //password input
                    passwordField,
                    const SizedBox(height: 30),
                    //login button
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3.2,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          //Navigator.pushReplacementNamed(context, '/home');
                          signIn(emailController.text, passwordController.text);
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
                          style: TextStyle(
                              color: Color.fromRGBO(189, 189, 189, 1)),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomeScreen())),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
