import 'package:farm_land/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../compont/textfield.dart';
import 'forgetpass.dart';
import 'home.dart';

class MyFirsApp extends StatefulWidget {
  const MyFirsApp({super.key});

  @override
  State<MyFirsApp> createState() => _MyFirsAppState();
}

class _MyFirsAppState extends State<MyFirsApp> {
  var email = TextEditingController();
  var password = TextEditingController();
  Icon ic = const Icon(Icons.remove_red_eye_rounded);
  bool pass = true;

  var formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    //auth.signOut();
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: const Text(
          'My Farm',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 95,
                ),
                textfeild(
                    "email",
                    " enter email",
                    IconButton(onPressed: () {}, icon: const Icon(Icons.email)),
                    TextInputType.emailAddress,
                    email,
                    "Email is too short"),
                const SizedBox(
                  height: 25,
                ),
                textfeild(
                    "password",
                    " enter password",
                    IconButton(
                      icon: ic,
                      onPressed: () {
                        setState(() {
                          pass = !pass;
                          if (pass == true) {
                            ic = const Icon(Icons.remove_red_eye_rounded);
                          } else {
                            ic = const Icon(Icons.remove_red_eye_outlined);
                          }
                        });
                      },
                    ),
                    TextInputType.visiblePassword,
                    password,
                    "Password is too short"),
                const SizedBox(
                  height: 25,
                ),
                MaterialButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        //MyAppMethods.loadingPage(context: context);
                        await auth
                            .signInWithEmailAndPassword(
                          email: email.text.trim(),
                          password: password.text.trim(),
                        )
                            .then((value) async {
                          Fluttertoast.showToast(
                              msg: "Login Success!",
                              toastLength: Toast.LENGTH_SHORT,
                              textColor: Colors.white,
                              backgroundColor: Colors.green);
                          print('heeloooo');
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const Home()),
                            //(route) => false,
                          );
                        });
                        //Navigator.pop(context);
                      } on FirebaseAuthException catch (error) {
                        Fluttertoast.showToast(
                          msg: "An error occured $error",
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                        print(error.toString());
                      } catch (error) {
                        Fluttertoast.showToast(
                          msg: "An error occured $error",
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                        print(error.toString());
                      }
                    }
                  },
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Text(
                    'login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const forgetpass();
                    }));
                  },
                  child: const Text(
                    "Forget the password ?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const SignUp();
                    }));
                  },
                  child: const Text(
                    "Sign Up !",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
