import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../../screens/utils/utils.dart';

joinMyIdInThisEvent(eventDocumentId) {
  //
  if (kDebugMode) {
    print('=======================');
    print('add me in this event');
    print('=======================');
  }

  FirebaseFirestore.instance
      .collection(
        '$strFirebaseMode${FirestoreUtils.EVENTS}',
      )
      .doc(eventDocumentId.toString())
      .update(
    {
      "eventJoinedMembersId": FieldValue.arrayUnion(
        [
          FirebaseAuth.instance.currentUser!.uid,
        ],
      ),
    },
  ).then((value) => {
            //
          });
}
