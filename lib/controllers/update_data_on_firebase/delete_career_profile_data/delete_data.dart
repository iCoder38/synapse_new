// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../screens/utils/utils.dart';

/* DELETE SKILL, EDUCATION and EXPERIENCE FROM FIREBASE ( SETTINGS ) */
deleteCareerProfileFromFirebase(
  firebaseId,
  documentId,
  key,
) {
  final collection = FirebaseFirestore.instance.collection(
    '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA}/$firebaseId/$key',
  );
  collection
      .doc(documentId)
      .delete()
      .then(
        (_) => print(
          'Deleted',
        ),
      )
      .catchError((error) => print('Delete failed: $error'));
  return 'Successfully Deleted';
}
