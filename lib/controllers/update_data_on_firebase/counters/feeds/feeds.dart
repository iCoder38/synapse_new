import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../../screens/utils/utils.dart';

//***************** ADD ONE IN FEEDS  *************************************/
//*****************************************************************************/

addOneInFeedsCount(context, documentId, count) {
  FirebaseFirestore.instance
      .collection(
        '$strFirebaseMode${FirestoreUtils.USERS}/data/${FirebaseAuth.instance.currentUser!.uid}',
      )
      .doc(documentId.toString())
      .update(
    {
      'countFeed': count.toString(),
    },
  ).then((value) => {
            //
            Navigator.pop(context), Navigator.pop(context),
          });
}
