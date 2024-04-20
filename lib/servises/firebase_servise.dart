import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class FirebaseDataService {
  final _dataStreamController = StreamController<DataSnapshot>();

  FirebaseDataService() {
    final databaseReference = FirebaseDatabase.instance.ref('Images');
    databaseReference.onValue.listen((event) {
      _dataStreamController.add(event.snapshot);
    });
  }

  Stream<DataSnapshot> get dataStream => _dataStreamController.stream;

  void dispose() {
    _dataStreamController.close();
  }
}
