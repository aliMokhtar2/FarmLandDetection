import 'package:farm_land/pages/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'notification.dart';

class Home extends StatefulWidget {
  const Home({Key? key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/img/pexels-joaojesusdesign-2480070.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.green.shade300.withOpacity(0.5), // Adjust overlay opacity as needed
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                  ),
                ),
                Text(
                  'Your Farm',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Opacity(
        opacity: 0.9, // Adjust the opacity value as needed
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green.shade900,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dashbord',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              ListTile(
                title: Text('Home'),
                leading: Icon(Icons.home_outlined),
                onTap: () {
                  // Navigate to home screen
                },
              ),
              ListTile(
                title: Text('History Of Image'),
                leading: Icon(Icons.add_a_photo),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const NotificationScreen();
                    }),
                  );
                },
              ),
              ListTile(
                title: Text('Account'),
                leading: Icon(Icons.account_box),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const DisplayInformation();
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
