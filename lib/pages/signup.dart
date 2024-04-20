import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../compont/textfield.dart';
import 'home.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var email = TextEditingController();
  var number = TextEditingController();
  var password = TextEditingController();
  Icon ic = const Icon(Icons.remove_red_eye_rounded);
  bool pass = true;
  var formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  Future<void> addDataToFirestore() async {
    User? user = auth.currentUser;
    await FirebaseFirestore.instance.collection("Users").doc(user!.uid).set({
      'userId': user.uid,
      'userFirstName': firstName.text,
      'userLastName': lastName.text,
      'userEmail': email.text,
      'userNumber': number.text,
      'userPassword': password.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: const Text(
          "Sign Up ",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: Form(
        key: formKey,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 45,
                  ),
                  textfeild(
                      "First Name",
                      "Enter First Name",
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.account_circle)),
                      TextInputType.text,
                      firstName,
                      "First Name is too small!"),
                  const SizedBox(
                    height: 25,
                  ),
                  textfeild(
                      "Last Name",
                      "enter Last Name",
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.account_circle)),
                      TextInputType.text,
                      lastName,
                      "Last Name is too small!"),
                  const SizedBox(
                    height: 25,
                  ),
                  textfeild(
                    "Email",
                    "enter email  ",
                    IconButton(onPressed: () {}, icon: const Icon(Icons.email)),
                    TextInputType.emailAddress,
                    email,
                    "Email is too small!",
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  textfeild(
                    "Number",
                    " enter number",
                    IconButton(onPressed: () {}, icon: const Icon(Icons.phone)),
                    TextInputType.number,
                    number,
                    "Phone number is too small!",
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  textfeild(
                      "Password",
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
                      "Password is too small!"),
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 80),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          await auth.createUserWithEmailAndPassword(
                            email: email.text.trim(),
                            password: password.text.trim(),
                          );

                          await addDataToFirestore().then((value) async {
                            Fluttertoast.showToast(
                              msg: "An account has been created",
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                            );
                            await Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => const Home()),
                              (route) => false,
                            );
                          });
                        } on FirebaseAuthException catch (error) {
                          print(error.toString());
                          Fluttertoast.showToast(
                            msg: "An error occured $error",
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
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
                      'Creat',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
