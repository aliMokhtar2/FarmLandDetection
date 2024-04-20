import 'package:flutter/material.dart';

class forgetpass extends StatefulWidget {
  const forgetpass({super.key});

  @override
  State<forgetpass> createState() => _forgetpassState();
}

class _forgetpassState extends State<forgetpass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: Text(
          "Forget password",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
