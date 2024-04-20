import 'dart:async';

import 'package:flutter/material.dart';

import 'login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MyFirsApp()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade300,
      child: CircleAvatar(
        backgroundColor: Colors.green.shade200,
        child: Image.asset('assets/img/img home.png'),
      ),
    );
  }
}
