import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../screens/utils/utils.dart';

//***************** DELETE POST FROM FIREBASE  ********************************/
//*****************************************************************************/
firebaseDeleteThisPostFromDB(getDocumentId) {
  //
  FirebaseFirestore.instance
      .collection(
        '$strFirebaseMode${FirestoreUtils.POST_FEEDS}',
      )
      .doc(getDocumentId)
      .delete()
      .then((_) {
    if (kDebugMode) {
      print(
        '''==> POST DELETED SUCCESSFULLY <==''',
      );
    }
  });
}
