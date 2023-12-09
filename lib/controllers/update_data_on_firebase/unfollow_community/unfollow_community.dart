import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../screens/utils/utils.dart';

unfollowThisCommunity(communityId) {
  //

  //
  if (kDebugMode) {
    print('===================');
    print('community unfollow');
    print('===================');
  }

  FirebaseFirestore.instance
      .collection(
        '$strFirebaseMode${FirestoreUtils.FOLLOW}/${FirebaseAuth.instance.currentUser!.uid}/data',
      )
      .where('communityIds', arrayContainsAny: [
        //
        communityId.toString()
      ])
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
              //

              FirebaseFirestore.instance
                  .collection(
                    '$strFirebaseMode${FirestoreUtils.FOLLOW}/${FirebaseAuth.instance.currentUser!.uid}/data',
                  )
                  .doc(element.id)
                  .delete()
                  .then((_) {
                if (kDebugMode) {
                  removeMyFirebaseIdFromCommunityFollowers(communityId);
                }
              });
            }
            //
          }
        }
      });
}

removeMyFirebaseIdFromCommunityFollowers(communityId) {
  //

  //
  if (kDebugMode) {
    print('===================');
    print('remove my id from community followers list');
    print('===================');
  }

  FirebaseFirestore.instance
      .collection(
        '$strFirebaseMode${FirestoreUtils.COMMUNITIES}/India/data',
      )
      .where('communityId', isEqualTo: communityId.toString())
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
          //
        }
        //
        var collection = FirebaseFirestore.instance.collection(
          '$strFirebaseMode${FirestoreUtils.COMMUNITIES}/India/data',
        );
        collection.doc(element.id.toString()).update({
          'followers': FieldValue.arrayRemove([
            //
            FirebaseAuth.instance.currentUser!.uid.toString()
          ]),
        });
      }
    }
  });
}

// removeMyFirebaseIdFromCommunityFollowers(eventDocumentId) {
//   //

// }
