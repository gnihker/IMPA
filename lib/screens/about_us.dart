import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

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
            'About Us',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromRGBO(63, 24, 149, 1),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/assets/images/bghome.png"),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('About Us',
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Flexible(
                  child: Text(
                      "This application, Image Processing Assistant (IMPA), is a part of Computer Engineering project called 'Mobile application for visualizing analytical result from Image Processing'."),
                ),
                SizedBox(height: 16),
                Text('By Sadapa Chuengtanacharoenlert'),
                Text('and Project Advisor, Assoc. Prof. Punpiti Piamsa-nga'),
                SizedBox(height: 24),
                Text('Contact Us',
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text('For more info, please contact sadapa.c@ku.th'),
                Text('Thank you.')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
