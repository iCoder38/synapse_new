import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../../screens/utils/utils.dart';

removeMeFromEventInFirebase(eventDocumentId) {
  //
  var collection = FirebaseFirestore.instance.collection(
    '$strFirebaseMode${FirestoreUtils.EVENTS}',
  );
  collection.doc(eventDocumentId.toString()).update({
    'eventJoinedMembersId': FieldValue.arrayRemove([
      //
      FirebaseAuth.instance.currentUser!.uid.toString()
    ]),
  });
}
