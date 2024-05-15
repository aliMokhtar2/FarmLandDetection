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
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MyFirstApp()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade300,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.6), // Shadow color and opacity
              spreadRadius: 1, // Spread radius
              blurRadius: 1, // Blur radius
              offset: Offset(1,1 ), // Offset of the shadow
            ),
          ],
        ),
        child: CircleAvatar(
          backgroundColor: Colors.green.shade300,
          radius: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/peasant.png',
                width: 290, // Set the width of the image
                height: 290, // Set the height of the image
              ),
              // SizedBox(
              //     height: 1), // Adjust the spacing between the image and text
              Text(
                'My Farm',
                style: TextStyle(
                  color: Color.fromARGB(255, 224, 37, 37),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  // fontStyle: FontStyle.normal,
                  fontFamily:
                      'Kalam', // Replace 'YourFont' with the desired font family
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
