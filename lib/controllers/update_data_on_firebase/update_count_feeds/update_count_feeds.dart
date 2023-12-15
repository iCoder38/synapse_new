//
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../screens/utils/utils.dart';

getDataFromCountsToDeleteFeedsCount() {
  //
  if (kDebugMode) {
    print('===================');
    print('GET DATA FROM COUNTS');
    print('===================');
  }

  FirebaseFirestore.instance
      .collection(
        '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA_COUNTS}/${FirebaseAuth.instance.currentUser!.uid}/data',
      )
      .get()
      .then((value) {
    if (kDebugMode) {
      print(value.docs);
    }

    if (value.docs.isEmpty) {
      if (kDebugMode) {
        print('======> NO USER FOUND <========');
      }
    } else {
      if (kDebugMode) {
        print('======> Yes, USER FOUND <========');
      }
      for (var element in value.docs) {
        if (kDebugMode) {
          print(element.id);
          print(element.data());
        }
        //
        // documentIdForFeedsCount = element.id;
        // totalFeeds = element.data()['feedCount'].toString();
        //
        var deleteOne = 0;
        //addOne += 1;
        deleteOne = int.parse(element.data()['feedCount'].toString()) - 1;
        // totalFeeds = addOne.toString();
        // print(element.data()['followers']);
        // print(element.data());
        FirebaseFirestore.instance
            .collection(
              '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA_COUNTS}/${FirebaseAuth.instance.currentUser!.uid}/data',
            )
            .doc(element.id.toString())
            .update(
          {
            'feedCount': deleteOne.toString(),
          },
        ).then((value) => {
                  //
                  //  Navigator.pop(context), Navigator.pop(context),
                });

        //
      }
    }
  });
}
