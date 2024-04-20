import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../servises/firebase_servise.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<String> imagesLink = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataSnapshot>(
      stream: FirebaseDataService().dataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DataSnapshot? data = snapshot.data;
          print("----------------------------------------");
          if (data?.value != null) {
            //print(snapshot.data!.children.length);
            for (int i = 0; i < snapshot.data!.children.length; i++) {
              var photoUrl = snapshot.data!.children.toList()[i].key;
              //print(snapshot.data!.children.toList()[i].key);
              String img = snapshot.data!
                  .child("$photoUrl")
                  .child('photo_url')
                  .value
                  .toString();

              print(img);
              imagesLink.add(img);
            }

            Set<String> uniqueImages = Set.from(imagesLink);
            print(uniqueImages);

            return Scaffold(
              backgroundColor: Colors.green.shade300,
              appBar: AppBar(
                backgroundColor: Colors.green.shade900,
                title: const Text(
                  "Notification",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                actions: [
                  SizedBox(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.black))),
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                ],
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => Center(
                        child: SizedBox(
                            height: 200,
                            width: 200,
                            child: CachedNetworkImage(
                              imageUrl: uniqueImages.toList()[index],
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                            )),
                      ),
                      itemCount: uniqueImages.length,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.green.shade300,
              appBar: AppBar(
                backgroundColor: Colors.green.shade900,
                title: const Text(
                  "Notification",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                actions: [
                  SizedBox(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.black))),
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                ],
              ),
              body: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            );
          }
        } else {
          return Scaffold(
            backgroundColor: Colors.green.shade300,
            appBar: AppBar(
              backgroundColor: Colors.green.shade900,
              title: const Text(
                "Notification",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              actions: [
                SizedBox(
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 2,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  const BorderSide(color: Colors.black))),
                    ),
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              ],
            ),
            body: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
