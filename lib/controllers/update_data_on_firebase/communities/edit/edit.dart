import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../../screens/utils/utils.dart';

//**************************** EDIT COMMUNITY DETAILS *************************/
//*****************************************************************************/
Future editCommunityDetails(
    context, documentId, communityName, communityAbout) async {
  FirebaseFirestore.instance
      .collection("$strFirebaseMode${FirestoreUtils.COMMUNITIES}")
      .doc(documentId.toString())
      .set(
    {
      'communityName': communityName.toString(),
      'communityAbout': communityAbout.toString(),

      'communityType': 'community'
      //
    },
    SetOptions(merge: true),
  );
  return 'rajputana rifle';
}
