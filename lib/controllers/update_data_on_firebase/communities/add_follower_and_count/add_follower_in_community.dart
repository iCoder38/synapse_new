import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../screens/utils/utils.dart';

//******************** ADD FOLLOWER DATA IN COMMUNITY *************************/
//*****************************************************************************/
followThisGroupInFirebase(
  getCommunityId,
  getCommunityDocumentId,
  getFollowerCount,
) {
  //
  CollectionReference users = FirebaseFirestore.instance.collection(
    '$strFirebaseMode${'community_follow'}/$getCommunityId/followers',
  );

  users
      .add(
        {
          'community_id': getCommunityId.toString(),
          'follower_id': FirebaseAuth.instance.currentUser!.uid,
          'follower_name': FirebaseAuth.instance.currentUser!.displayName,
          'follower_email': FirebaseAuth.instance.currentUser!.email,
          'timeStamp': DateTime.now().millisecondsSinceEpoch,
        },
      )
      .then(
        (value) =>
            //
            FirebaseFirestore.instance
                .collection(
                  '$strFirebaseMode${'community_follow'}/$getCommunityId/followers',
                )
                .doc(value.id)
                .set(
          {
            'documentId': value.id,
          },
          SetOptions(merge: true),
        ).then(
          (value1) {
            // dismiss popup
            addOneFollowerInThisCommunity(
              getCommunityDocumentId.toString(),
              getFollowerCount,
            );
          },
        ),
        //
      )
      .catchError(
        (error) => print("Failed to add user: $error"),
      );
}

//******************** ADD ONE FOLLOWE COUNT IN THIS COMMUNITY ****************/
//*****************************************************************************/

addOneFollowerInThisCommunity(getCommunityDocumentIdForEdit, getCountToEdit) {
  // calculate
  int strSum;
  strSum = int.parse(getCountToEdit.toString()) + 1;
  //
  FirebaseFirestore.instance
      .collection(
        '$strFirebaseMode${'communities'}',
      )
      .doc(getCommunityDocumentIdForEdit)
      .set(
    {
      'followersCount': strSum,
    },
    SetOptions(merge: true),
  ).then(
    (value1) {
      // dismiss popup
      // addOneFolloweInThisCommunity(getCommunityId.toString());
    },
  );
}
