//
// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../screens/utils/utils.dart';

//***************** ADD POST IN NOTIFICATION LIST  ****************************/
//*****************************************************************************/
addLikedDataInNotification(
  postId,
  postDocumentId,
  postAdminId,
  getType,
) {
  //
  if (kDebugMode) {
    print('login use');
  }
  //
  if (getType == '1') {
    FirebaseFirestore.instance
        .collection(
          '$strFirebaseMode${'notifications'}/$postAdminId/data',
        )
        .where('notification_post_id', isEqualTo: postId)
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.docs);
      }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('======> NO USER FOUND <========');
        }
        //
        CollectionReference users = FirebaseFirestore.instance.collection(
          '$strFirebaseMode${'notifications'}/$postAdminId/data',
        );

        users
            .add(
              {
                'notification_post_id': postId.toString(),
                'notification_post_document_id': postDocumentId.toString(),
                'notification_post_admin_id': postAdminId.toString(),
                'type': 'post',
                //
                'timeStamp': DateTime.now().millisecondsSinceEpoch,
                //
                'post_content': [
                  //
                ],
                // entity
                'notification_like_entity_id':
                    FirebaseAuth.instance.currentUser!.uid,
                'notification_like_entity_name':
                    FirebaseAuth.instance.currentUser!.displayName,
                // message
                'notification_message': 'liked',
              },
            )
            .then((value) =>
                //
                print(
                  'LIKED POST SUCCESSFULLY ADD IN NOTIFICATION LIST',
                ))
            .catchError(
              (error) => print("Failed to add user: $error"),
            );
        //
      } else {
        if (kDebugMode) {
          print('======> Yes, USER FOUND <========');
        }
        for (var element in value.docs) {
          if (kDebugMode) {
            print(element.id);
            //
          }
          //
          FirebaseFirestore.instance
              .collection(
                '$strFirebaseMode${'notifications'}/$postAdminId/data',
              )
              .doc(element.id)
              .set(
            {
              'timeStamp': DateTime.now().millisecondsSinceEpoch,
            },
            SetOptions(merge: true),
          ).then(
            (value) {
              if (kDebugMode) {
                print('successfully liked again this post');
              }
              //
            },
          );
        }
      }
    });
  }
}
