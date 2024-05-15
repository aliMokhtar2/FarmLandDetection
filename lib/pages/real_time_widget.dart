import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_land/pages/notification.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RealTImeWidget extends StatelessWidget {
  const RealTImeWidget({
    super.key,
    required this.uniqueImages,
    required this.realTimeList,
  });
  final Set<String> uniqueImages;
  final List<RealTimeModel> realTimeList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageDisplayPage(
                      imageUrl: uniqueImages.toList()[index],
                      realTimeModel: realTimeList[index],
                    ),
                  ),
                );
              },
              child: Center(
                child: SizedBox(
                  height:
                      250, // Adjust the height as needed to add space between boxes
                  child: Padding(
                    padding: const EdgeInsets.all(
                        17.0), // Add padding around the container
                    child: SingleChildScrollView(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 56, 135, 62),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: realTimeList[index].photoUrl,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                              ),
                              SizedBox(
                                  height:
                                      10), // Add space between image and text
                              Text(
                                realTimeList[index].name,
                                style: TextStyle(fontSize: 15, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            itemCount: realTimeList.length,
          ),
        ),
      ],
    );
  }
}
