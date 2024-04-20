import 'package:farm_land/pages/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'notification.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: const Text(
          "My Farm",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        leading: IconButton(
            onPressed: () async {
              auth.signOut();
              await Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const MyFirsApp()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.keyboard_arrow_left_sharp)),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/img/img home.png",
              alignment: Alignment.center,
              width: 200,
              height: 200,
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                 MaterialButton(
                    color: Colors.white,
                    child: const Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    onPressed: () {}),
                MaterialButton(
                    color: Colors.white,
                    child: const Icon(
                      Icons.notifications,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const NotificationScreen();
                        }),
                      );
                    }),
                 MaterialButton(
                    color: Colors.white,
                    child: const Icon(
                      Icons.settings,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const setting();
                        }),
                      );
                    }),
                 MaterialButton(
                    color: Colors.white,
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.black,
                    ),
                    onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
