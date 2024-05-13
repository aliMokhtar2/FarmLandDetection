import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DisplayInformation extends StatelessWidget {
  const DisplayInformation({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: Text(
          "Account Information",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: FutureBuilder(
        future: getCurrentUserData(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.data() == null) {
            return Center(child: Text('No data available', style: Theme.of(context).textTheme.subtitle1));
          }
          var userData = snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow("First Name :", userData['userFirstName']),
                _buildInfoRow("Last Name :", userData['userLastName']),
                _buildInfoRow("E-mail :", userData['userEmail']),
                 _buildInfoRow("Password :", userData['userPassword']),
                _buildInfoRow("Phone Number :", userData['userNumber']),
                _buildInfoRow("User ID :", userData['userId']),
                // Add more fields as needed
              ],
            ),
          );
        },
      ),
    );
  }
  Future<DocumentSnapshot> getCurrentUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();
      return userData;
    } else {
      throw Exception('User not logged in');
    }
  }
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
