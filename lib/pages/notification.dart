import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_land/pages/home.dart';
import 'package:farm_land/pages/real_time_widget.dart';
import 'package:farm_land/pages/setting.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../servises/firebase_servise.dart';
import 'package:http/http.dart' as http;

class RealTimeModel {
  String name;
  String dateTime;
  String photoUrl;
  String Time;
  RealTimeModel({
    required this.name,
    required this.dateTime,
    required this.photoUrl,
    required this.Time,
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<String> imagesLink = [];

  static List<RealTimeModel> realTimeList = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataSnapshot>(
      stream: FirebaseDataService().dataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DataSnapshot? data = snapshot.data;
          if (data?.value != null) {
            realTimeList = [];
            for (int i = 0; i < snapshot.data!.children.length; i++) {
              if ((snapshot.data!.children.toList()[i].value as Map)['name']
                      .toString() !=
                  'null') {
                realTimeList.add(RealTimeModel(
                  name:
                      (snapshot.data!.children.toList()[i].value as Map)['name']
                          .toString(),
                  dateTime: (snapshot.data!.children.toList()[i].value
                          as Map)['dateTime']
                      .toString(),
                  photoUrl: (snapshot.data!.children.toList()[i].value
                      as Map)['photo_url'],
                  Time:
                      (snapshot.data!.children.toList()[i].value as Map)['Time']
                          .toString(),
                ));
              }
              var photoUrl = snapshot.data!.children.toList()[i].key;
              String img = snapshot.data!
                  .child("$photoUrl")
                  .child('photo_url')
                  .value
                  .toString();
              imagesLink.add(img);
            }
            //realTimeList.reversed;
            realTimeList = realTimeList.reversed.toList();
            Set<String> uniqueImages = Set.from(imagesLink);

            return Scaffold(
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Dashbord',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Text('Home'),
                        leading: Icon(Icons.home),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Home()), // Replace HomeScreen with the actual screen widget for the home page
                          );
                        },
                      ),
                      ListTile(
                        title: Text('Notification'),
                        leading: Icon(Icons.notifications_active),
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
                        leading: Icon(Icons.account_circle),
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
              backgroundColor: Colors.green.shade300,
              appBar: AppBar(
                backgroundColor: Colors.green.shade900,
                title: const Text(
                  "Notification",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                // actions: [
                //   SizedBox(
                //     width: 100,
                //     child: Padding(
                //       padding: const EdgeInsets.all(30),
                //       child: TextFormField(
                //         style:
                //             const TextStyle(color: Colors.white, fontSize: 10),
                //         decoration: InputDecoration(
                //             enabledBorder: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(25),
                //                 borderSide: const BorderSide(
                //                   color: Colors.black,
                //                   width: 2,
                //                 )),
                //             focusedBorder: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(25),
                //                 borderSide:
                //                     const BorderSide(color: Colors.black))),
                //       ),
                //     ),
                //   ),
                //   IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                // ],
              ),
              body: RealTImeWidget(
                  uniqueImages: uniqueImages, realTimeList: realTimeList),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.green.shade300,
              appBar: AppBar(
                backgroundColor: Colors.green.shade900,
                title: const Text(
                  "Notification",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                // actions: [
                //   SizedBox(
                //     width: 100,
                //     child: Padding(
                //       padding: const EdgeInsets.all(10),
                //       child: TextFormField(
                //         style:
                //             const TextStyle(color: Colors.white, fontSize: 10),
                //         decoration: InputDecoration(
                //             enabledBorder: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(25),
                //                 borderSide: const BorderSide(
                //                   color: Colors.black,
                //                   width: 2,
                //                 )),
                //             focusedBorder: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(25),
                //                 borderSide:
                //                     const BorderSide(color: Colors.black))),
                //       ),
                //     ),
                //   ),
                //   //IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                // ],
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
              // actions: [
              //   SizedBox(
              //     width: 100,
              //     child: Padding(
              //       padding: const EdgeInsets.all(10),
              //       child: TextFormField(
              //         style: const TextStyle(color: Colors.white, fontSize: 10),
              //         decoration: InputDecoration(
              //             enabledBorder: OutlineInputBorder(
              //                 borderRadius: BorderRadius.circular(25),
              //                 borderSide: const BorderSide(
              //                   color: Colors.black,
              //                   width: 2,
              //                 )),
              //             focusedBorder: OutlineInputBorder(
              //                 borderRadius: BorderRadius.circular(25),
              //                 borderSide:
              //                     const BorderSide(color: Colors.black))),
              //       ),
              //     ),
              //   ),
              //   //IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              // ],
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

class ImageDisplayPage extends StatelessWidget {
  final String imageUrl;
  final RealTimeModel realTimeModel;

  const ImageDisplayPage({
    Key? key,
    required this.imageUrl,
    required this.realTimeModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: const Text(
          "Image Content",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: realTimeModel.photoUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            _buildDetailBox(
                realTimeModel.name, realTimeModel.dateTime, realTimeModel.Time),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailBox(String name, String date, String time) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 56, 135, 62),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name of animal : ",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow, // Change to your desired color
                ),
              ),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 13),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date : ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow, // Change to your desired color
                    ),
                  ),
                  SizedBox(height: 13),
                  Text(
                    "Time : ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow, // Change to your desired color
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class ImageDisplayPage extends StatelessWidget {
//   final String imageUrl;
//   final RealTimeModel realTimeModel;

//   const ImageDisplayPage(
//       {Key? key, required this.imageUrl, required this.realTimeModel})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green.shade300,
//       appBar: AppBar(
//         backgroundColor: Colors.green.shade900,
//         title: const Text(
//           "Image Content",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: CachedNetworkImage(
//               imageUrl: realTimeModel.photoUrl,
//               placeholder: (context, url) => CircularProgressIndicator(),
//               errorWidget: (context, url, error) => Icon(Icons.error),
//             ),
//           ),
//           Text(realTimeModel.name),
//           Text(realTimeModel.dateTime),
//         ],
//       ),
//     );
//   }
// }

sendMessage(title, message) async {
  var headersList = {
    'Accept': '*/*',
    //'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
    'Content-Type': 'application/json',
    'Authorization':
        'key=AAAA3lbIi5M:APA91bGArpTg016E3HlzZhHJ_lfO72rycCxNN6hEArOe00ZjXREiod2T-y42gWSyQWz0Bo0NfbC3KXJP61qqkSAPHWrYbFVg3Z6T_iSxgTnxAxwp_wmf380PNs3U0yfhCN92ir73lHDd'
  };
  var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

  var body = {
    "to":
        "dOkN0CdPSS-WYPu-XsoBCg:APA91bGlSsJvnMtqVL58c_8NAX2wcFs5VRQFWBPxgS5-OiGwxMfVDY8yftUPQ5h8WI3O9F9olrc6O1ho8krrVtiEFclUMgzuqhQ40BFN0l91gnB7gv-PLoEfLo3b2sURM3u2x20-CGiQ",
    "notification": {
      "title": title,
      "body": message,
      "priority": "high",
      "mutable_content": true,
      "sound": "Tri-tone"
    }
  };

  var req = http.Request('POST', url);
  req.headers.addAll(headersList);
  req.body = json.encode(body);

  var res = await req.send();
  final resBody = await res.stream.bytesToString();

  if (res.statusCode >= 200 && res.statusCode < 300) {
    print(resBody);
  } else {
    print(res.reasonPhrase);
  }
}
