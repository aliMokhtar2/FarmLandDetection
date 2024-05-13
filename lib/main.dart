//import 'package:farm_land/pages/login.dart';
//import 'dart:js';
import 'package:farm_land/pages/home.dart';
import 'package:farm_land/pages/login.dart';
import 'package:farm_land/pages/notification.dart';
import 'package:farm_land/pages/setting.dart';
import 'package:farm_land/pages/splashpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:farm_land/servises/notification.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  String token = await firebaseMessaging.getToken() ?? '';
  print('TOKEN ==> $token');
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    NotificationUtility.instate();
    NotificationUtility.messagingOpenedApp();
    super.initState();
    _fcm.getToken().then((token) {
      FirebaseFirestore.instance.collection('tokens').add({'token': token});
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Flu'),
      debugShowCheckedModeBanner: false,
      home: const MyFirstApp(),
    );
  }
}
