import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../screens/utils/utils.dart';

//***************** UNFOLLOW THIS COMMUNITY  ********************************/
//*****************************************************************************/
unfollowThisCommunity(
  communityId,
  getCommunityDocumentId,
) {
  if (kDebugMode) {
    print('===================');
    print('community unfollow');
    print(communityId.toString());
    print('===================');
  }

  FirebaseFirestore.instance
      .collection(
        '$strFirebaseMode${'community_followers'}/${communityId.toString()}/followers',
      )
      .where(
        'follower_id',
        isEqualTo: FirebaseAuth.instance.currentUser!.uid,
      )
      .get()
      .then((value) {
    if (kDebugMode) {
      print(value.docs);
    }

    if (value.docs.isEmpty) {
      if (kDebugMode) {
        print('======> NO USER FOUND 1 <========');
      }
    } else {
      if (kDebugMode) {
        print('======> Yes, USER FOUND 1 <========');
      }
      for (var element in value.docs) {
        if (kDebugMode) {
          print(element.id);
          print(element.data());
          //
        }

        FirebaseFirestore.instance
            .collection(
              '$strFirebaseMode${'community_followers'}/${communityId.toString()}/followers',
            )
            .doc(element.id)
            .delete()
            .then((_) {
          if (kDebugMode) {
            //
            // get community full details
            getCommunityFullDetails(
              communityId,
            );
          }
        });

        //
      }
    }
  });
  //
  //
}

//
getCommunityFullDetails(getCommunityId) async {
  //
  await FirebaseFirestore.instance
      .collection(
        '$strFirebaseMode${'communities'}',
      )
      .where(
        'communityId',
        isEqualTo: getCommunityId.toString(),
      )
      .get()
      .then((value) {
    if (kDebugMode) {
      print(value.docs);
    }

    if (value.docs.isEmpty) {
      if (kDebugMode) {
        print('======> NO USER FOUND 2 <========');
      }
    } else {
      if (kDebugMode) {
        print('======> Yes, USER FOUND 2 <========');
      }
      for (var element in value.docs) {
        if (kDebugMode) {
          print(element.id);
          print(element.data());
          //

          int strMinus;
          strMinus = int.parse(element['followersCount'].toString()) - 1;
          //
          FirebaseFirestore.instance
              .collection(
                '$strFirebaseMode${'communities'}',
              )
              .doc(element.id)
              .set(
            {
              'followersCount': strMinus,
            },
            SetOptions(merge: true),
          ).then(
            (value1) {
              // dismiss popup
              if (kDebugMode) {
                print('=================================================');
                print('COMMUNITY FOLLOWERS COUNT SUCCESSFULLY UPDATE (-)');
                print('=================================================');
              }
              //
              removeMeFromUserFollowsList(element['communityId'].toString());
            },
          );
        }
        //
      }
    }
  });
}

// remove me from "user follows list"
removeMeFromUserFollowsList(communityId) async {
  //
  if (kDebugMode) {
    print(communityId);
  }
  //
  await FirebaseFirestore.instance
      .collection(
        '$strFirebaseMode${'user_follows_list'}/communities/${FirebaseAuth.instance.currentUser!.uid}',
      )
      .where(
        'content_id',
        isEqualTo: communityId.toString(),
      )
      .get()
      .then((value) {
    if (kDebugMode) {
      print(value.docs);
    }

    if (value.docs.isEmpty) {
      if (kDebugMode) {
        print('======> NO USER FOUND to remove all <========');
      }
    } else {
      if (kDebugMode) {
        print('======> Yes, USER FOUND to remove all <========');
      }
      for (var element in value.docs) {
        if (kDebugMode) {
          print(element.id);
          print(element.data());
          //

          //
          FirebaseFirestore.instance
              .collection(
                '$strFirebaseMode${'user_follows_list'}/communities/${FirebaseAuth.instance.currentUser!.uid}',
              )
              .doc(element.id)
              .delete()
              .then((_) {
            if (kDebugMode) {
              //
              if (kDebugMode) {
                print('=====================================================');
                print('SUCCESSFULLY UNFOLLOW THIS COMMUNITY AFTER EVERYTHING');
                print('=====================================================');
              }
            }
          });
          //
          //
        }
        //
      }
    }
  });
} 
  // FirebaseFirestore.instance
  //     .collection(
  //       '$strFirebaseMode${'user_follows_list'}/communities/${FirebaseAuth.instance.currentUser!.uid}',
  //     )
  //     .doc(communityDocumentId)
  //     .set(
  //   {
  //     'followersCount': strMinus,
  //   },
  //   SetOptions(merge: true),
  // ).then(
  //   (value1) {
  //     // dismiss popup
  //     if (kDebugMode) {
  //       print('=================================================');
  //       print('COMMUNITY FOLLOWERS COUNT SUCCESSFULLY UPDATE (-)');
  //       print('=================================================');
  //     }
  //     /*addMeInAllFollowsList(
  //                 getCommunityId2, getCommunityDocumentIdForEdit);*/
  //   },
  // );
 
