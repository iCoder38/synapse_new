// ignore_for_file: prefer_final_fields, unused_field, non_constant_identifier_names

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:synapse_new/controllers/bar_bottom/bottom_bar.dart';
import 'package:synapse_new/controllers/screens/home_page/home_page.dart';

import '../login/login.dart';
import '../utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  RemoteMessage? initialMessage;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  //
  FirebaseAuth firebase_auth = FirebaseAuth.instance;
  //
  late Timer _timer;
  int _start = 2;
  //
  String? notifTitle, notifBody;
  //
  //
  @override
  void initState() {
    if (kDebugMode) {
      print('I AM IN SPLASH SCREEN');
    }
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: text_bold_comforta(
          'Splash Screen $_start',
          Colors.black,
          14.0,
        ),
      ),
    );
  }

// get notification in foreground
  func_get_full_data_of_notification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('=====> GOT NOTIFICATION IN FOREGROUND <=====');
      }
      if (kDebugMode) {
        print('Message data: ${message.data}');
      }
      if (message.notification != null) {
        if (kDebugMode) {
          print(
              'Message also contained a notification: ${message.notification}');
        }
        setState(() {
          notifTitle = message.notification!.title;
          notifBody = message.notification!.body;
        });
      }
    });
  }

  func_click_on_notification() {
// FirebaseMessaging.configure

    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      if (kDebugMode) {
        print('=====> CLICK NOTIFICATIONs <=====');
        print(remoteMessage.data);
      }
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });

          FirebaseAuth.instance.authStateChanges().listen((User? user) {
            if (user == null) {
              if (kDebugMode) {
                print('User is currently signed out!');
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            } else {
              if (kDebugMode) {
                print('User is signed in!');
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  // builder: (context) => const HomeFeedScreen(),
                  builder: (context) => const BottomBarScreen(),
                ),
              );
            }
          });
        } else {
          setState(
            () {
              if (kDebugMode) {
                print(_start);
              }
              _start--;
            },
          );
        }
      },
    );
  }
}
