// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';

class FirestoreUtils {
  static const String USERS_COLLECTION = "Users";
  static const String EVENTS_COLLECTION = "Events";
  // post =
  static const String USERS = "users";
  static const String POST_FEEDS = "post";
  static const String POST_COMMENT = "post_comment";
  static const String POST_LIKE = "post_like";
  static const String FOLLOW = "follow";
  // community
  static const String COMMUNITY_FOLLOW = "community_follow";
  // events
  static const String EVENTS = "events";
  // events media
  static const String EVENTS_MEDIA = "events_media";
  // user all data
  static const String USER_FULL_DATA_COUNTS = "user_data_counts";
  // user all data details
  static const String USER_FULL_DATA = "user_data";
  //
  static const String COMMUNITIES = "communities";
  //
  static String LOGIN_USER_NAME =
      FirebaseAuth.instance.currentUser!.displayName.toString();
  static String LOGIN_USER_EMAIL =
      FirebaseAuth.instance.currentUser!.email.toString();
  static String LOGIN_USER_FIREBASE_ID =
      FirebaseAuth.instance.currentUser!.uid.toString();
}
