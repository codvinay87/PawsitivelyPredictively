import 'dart:async';

import 'package:aimlproject/screens/root_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const RootApp()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromARGB(105, 236, 210, 251),
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            Lottie.asset("assets/animation/Animation - 1700549966662.json",
                height: 300, repeat: true, fit: BoxFit.cover),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Center(
                child: Text(
                  "Pawsitively Predictable",
                  style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
