import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_land/pages/real_time_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../servises/firebase_servise.dart';
import 'package:http/http.dart' as http;

class RealTimeModel {
  String name;
  String dateTime;
  String photoUrl;
  RealTimeModel({
    required this.name,
    required this.dateTime,
    required this.photoUrl,
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
                    name: (snapshot.data!.children.toList()[i].value
                            as Map)['name']
                        .toString(),
                    dateTime: (snapshot.data!.children.toList()[i].value
                            as Map)['dateTime']
                        .toString(),
                    photoUrl: (snapshot.data!.children.toList()[i].value
                        as Map)['photo_url']));
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
              backgroundColor: Colors.green.shade300,
              appBar: AppBar(
                backgroundColor: Colors.green.shade900,
                title: const Text(
                  "History Of Image",
                  style: TextStyle(color: Colors.white, fontSize: 20),
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
                  "History Of Image",
                  style: TextStyle(color: Colors.white, fontSize: 30),
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
                  //IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
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
                "History Of Image",
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
                //IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
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
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CachedNetworkImage(
              imageUrl: realTimeModel.photoUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(height: 20), // Add space between image and text
          Container(
            padding: EdgeInsets.all(10), // Add padding to create a box
            decoration: BoxDecoration(
              color: Colors.white, // Set background color of the box
              borderRadius: BorderRadius.circular(10), // Optional: Add border radius to the box
            ),
            child: Text(
              realTimeModel.name,
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 10), // Add space between the two text boxes
          Container(
            padding: EdgeInsets.all(10), // Add padding to create a box
            decoration: BoxDecoration(
              color: Colors.white, // Set background color of the box
              borderRadius: BorderRadius.circular(10), // Optional: Add border radius to the box
            ),
            child: Text(
              realTimeModel.dateTime,
              style: TextStyle(fontSize: 18),
            ),
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
