import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../screens/utils/utils.dart';

//******************** ADD FOLLOWER DATA IN COMMUNITY *************************/
//*****************************************************************************/

addMeInAllFollowsList(
  getCommunityId,
  getCommunityDocumentId,
) {
  //
  CollectionReference users = FirebaseFirestore.instance.collection(
    '$strFirebaseMode${'user_follows_list'}/communities/${FirebaseAuth.instance.currentUser!.uid}',
  );

  users
      .add(
        {
          // follower details
          'follower_id': FirebaseAuth.instance.currentUser!.uid,
          'follower_name': FirebaseAuth.instance.currentUser!.displayName,
          'follower_email': FirebaseAuth.instance.currentUser!.email,
          // content
          'content_id': getCommunityId.toString(),
          'content_document_id': getCommunityDocumentId.toString(),
          // date and time
          'timeStamp': DateTime.now().millisecondsSinceEpoch,
          //
          'content_visibile': 'yes',
        },
      )
      .then(
        (value) =>
            //
            FirebaseFirestore.instance
                .collection(
                  '$strFirebaseMode${'user_follows_list'}/communities/${FirebaseAuth.instance.currentUser!.uid}',
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
            /*addOneFollowerInThisCommunity(
              getCommunityDocumentId.toString(),
              getFollowerCount,
            );*/
          },
        ),
        //
      )
      .catchError(
        (error) => print("Failed to add user: $error"),
      );
}
