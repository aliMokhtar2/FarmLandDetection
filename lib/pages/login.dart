import 'package:farm_land/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../compont/textfield.dart';
import 'forgetpass.dart';
import 'home.dart';

class MyFirstApp extends StatefulWidget {
  const MyFirstApp({super.key});

  @override
  State<MyFirstApp> createState() => _MyFirsAppState();
}

class _MyFirsAppState extends State<MyFirstApp> {
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
        title: Center(
          child: Text(
            'Login',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
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
                  height: 55,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome back ! Login with your account",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    hintText: "Enter your Email",
                    prefixIcon: const Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is too short';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  obscureText: pass,
                  keyboardType: TextInputType.visiblePassword,
                  controller: password,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    hintText: "Enter your password",
                    suffixIcon: IconButton(
                      icon: pass
                          ? const Icon(Icons.remove_red_eye_rounded)
                          : const Icon(Icons.remove_red_eye_outlined),
                      onPressed: () {
                        setState(() {
                          pass = !pass;
                        });
                      },
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is too short';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                MaterialButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        await auth.signInWithEmailAndPassword(
                          email: email.text.trim(),
                          password: password.text.trim(),
                        );
                        Fluttertoast.showToast(
                          msg: "Login Success",
                          toastLength: Toast.LENGTH_SHORT,
                          textColor: Colors.white,
                          backgroundColor: Colors.green,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const Home()),
                        );
                      } on FirebaseAuthException catch (error) {
                        Fluttertoast.showToast(
                          msg: "An error occurred: $error",
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                        print(error.toString());
                      } catch (error) {
                        Fluttertoast.showToast(
                          msg: "An error occurred: $error",
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                        print(error.toString());
                      }
                    }
                  },
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const SignUp();
                        }),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
