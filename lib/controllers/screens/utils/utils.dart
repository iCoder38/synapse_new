// ignore_for_file: non_constant_identifier_names, unused_local_variable, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

/* ========================FIREBASE MODE ======================== */ //
// TEST
// test mode
var strFirebaseMode = 'mode/test/';
// test : user
var user = 'test_members/';
//
var kGoogle_API_KEY = 'AIzaSyAULQHYzpkutmeYPo9nU3BIGTlFlw9ZuH8';
// bucket
const String FIREBASE_STORAGE_BUCKET_NAME = 'Test_Dev-Synapse-Bucket';
//
// LIVE
// live : user
// var user = 'members';
//
// const String FIREBASE_STORAGE_BUCKET_NAME = 'Dev-Synapse-Bucket';
const String FIREBASE_STORAGE_COMMUNITY_URL =
    '$FIREBASE_STORAGE_BUCKET_NAME/public/communities/';
//
const String FIREBASE_STORAGE_ALL_PROFILE_PICTURES =
    '$FIREBASE_STORAGE_BUCKET_NAME/public/profile_picture/';
//
const String FIREBASE_STORAGE_EVENT_URL =
    '$FIREBASE_STORAGE_BUCKET_NAME/public/events/';
const String FIREBASE_STORAGE_EVENT_MEDIA_URL =
    '$FIREBASE_STORAGE_BUCKET_NAME/public/events_media';
/* ================================================================ */
var dummy_image_url =
    'https://images.unsplash.com/photo-1520820446914-04cb9819a6cc?auto=format&fit=crop&q=80&w=2936&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
/* ======================== TEXT ======================== */ //
var str_alert_please_wait = 'Please wait...';
var strActivateYourFeedMessage =
    'This feed will be activated again and visible to everyone.';
var strDeactivateYourFeedMessage =
    'This post will be deactivated and hide it from everywhere. If you want to activate it again so activate it from your profile';
//
/* ======================== COLOR ================ */ //
var select_color = Colors.redAccent;
/* ======================== ALERT MESSAGE ================ */ //
//
var str_error_email_already_exist =
    'The account already exists for that email.';
var str_error_weak_password = 'The password provided is too weak.';
//
var str_password_length_eight = 'Password must be 8 character or more';
//
var str_invalid_login_details =
    'Invalid Credentials. Please check and try again.';
//
/* =================== RETURN ERRORS MESSAGES ============ */ //
func_handle_error(error_type) {
  //
  var error_message = '';
  if (error_type == '1') {
    error_message = str_error_weak_password;
  } else if (error_type == '2') {
    error_message = str_error_email_already_exist;
  } else if (error_type == '3') {
    error_message = str_invalid_login_details;
  } else if (error_type == 'password_length_eight') {
    error_message = str_password_length_eight;
  }

  return error_message;
}

/* ================================================================ */
/* ========== CONVERT TIMESTAMP TO DATE AND TIME =============== */

funcConvertTimeStampToDateAndTimeForChat(getTimeStamp) {
  var dt = DateTime.fromMillisecondsSinceEpoch(getTimeStamp);
  // var d12HourFormat = DateFormat('dd/MM/yyyy, hh:mm').format(dt);
  var d12HourFormatTime = DateFormat('hh:mm a').format(dt);
  return d12HourFormatTime;
}

funcConvertTimeStampToDateAndTime(DateTime d) {
  Duration diff = DateTime.now().difference(d);
  if (diff.inDays > 365) {
    return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  }
  if (diff.inDays > 30) {
    return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  }
  if (diff.inDays > 7) {
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  }
  if (diff.inDays > 0) return DateFormat.E().add_jm().format(d);
  if (diff.inHours > 0) return "Today ${DateFormat('jm').format(d)}";
  if (diff.inMinutes > 0) {
    return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
  }
  return "just now";
}

//
String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var format = DateFormat('HH:mm a');
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    time = format.format(date);
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    if (diff.inDays == 1) {
      time = '${diff.inDays} DAY AGO';
    } else {
      time = '${diff.inDays} DAYS AGO';
    }
  } else {
    if (diff.inDays == 7) {
      time = '${(diff.inDays / 7).floor()} WEEK AGO';
    } else {
      time = '${(diff.inDays / 7).floor()} WEEKS AGO';
    }
  }

  return time;
}
//
/* ====================== TEXT STYLE =================== */ //

// comforta regular
Text text_regular_comforta(str, color, size) {
  return Text(
    str.toString(),
    style: GoogleFonts.comfortaa(
      color: color,
      fontSize: size,
    ),
  );
}

// comforta bold
Text text_bold_comforta(str, color, size) {
  return Text(
    str.toString(),
    style: GoogleFonts.comfortaa(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w700,
    ),
  );
}

// roboto regular
Text text_regular_roboto(str, color, size) {
  return Text(
    str.toString(),
    style: GoogleFonts.roboto(
      color: color,
      fontSize: size,
    ),
  );
}

// roboto bold
Text text_bold_roboto(str, color, size) {
  return Text(
    str.toString(),
    style: GoogleFonts.roboto(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w700,
    ),
  );
  //
}
