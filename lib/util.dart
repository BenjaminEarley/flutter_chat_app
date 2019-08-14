import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';

@immutable
class Pair<A, B> extends Equatable {
  final A first;
  final B second;
  Pair(this.first, this.second) : super([first, second]);
}

bool isValidEmail(String email) =>
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

Future<void> saveDeviceToken(String uid) async {
  // Get the token for this device
  String fcmToken = await FirebaseMessaging().getToken();

  // Save it to Firestore
  if (fcmToken != null) {
    var tokens = Firestore.instance
        .collection('users')
        .document(uid)
        .collection('tokens')
        .document(fcmToken);

    await tokens.setData(
      {
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(),
        'platform': Platform.operatingSystem
      },
      merge: false,
    );
  }
}
