import 'package:cloud_firestore/cloud_firestore.dart';

import '../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../screens/utils/utils.dart';

activateDeactivatePost(documentId, status) {
  FirebaseFirestore.instance
      .collection(
        '$strFirebaseMode${FirestoreUtils.POST_FEEDS}',
      )
      .doc(documentId.toString())
      .update(
    {
      'postActive': status.toString(),
    },
  ).then((value) => {
            //
            // Navigator.pop(context), Navigator.pop(context),
          });
}
