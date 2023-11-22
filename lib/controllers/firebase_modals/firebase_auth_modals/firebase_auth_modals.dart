// ALL FIB QUERIES
// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, camel_case_types

// 1 = EMAIL ALREADY EXIST
// 2 = WEAK PASSWORD

/* ====================================================== */ //
/* ====================== CREATE USER =================== */ //
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Fib_Auth {
  func_create_an_user_with_fib(get_email, get_password) async {
    //
    var return_response;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: get_email,
            password: get_password,
          )
          .then((value) => {
                //
                return_response = value,
                //
              });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
        //
        return_response = '1';
        //
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
        //
        return_response = '2';
        //
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
        // print(e);
        return_response = e;
      }
    }
    //
    return return_response;
    //
  }

/* ====================================================== */ //
/* ============= LOGIN VIA FIREBASE ===================== */ //
/* ====================================================== */ //

  // login via firebase
  signInUserFiB(get_email, get_password) async {
    //
    var return_response;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: get_email,
            password: get_password,
          )
          .then((value) => {
                //
                return_response = value,
                //
              });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
        //
        return_response = '3';
        //
      }
    } catch (e) {
      if (kDebugMode) {
        print('dishu');
        print(e);
        // print(e);
        return_response = e;
      }
    }
    //
    return return_response;
    //
  }
}

/* ====================================================== */ //
/* ====================================================== */ //