// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../screens/utils/utils.dart';

checkDialog(getRoomId, getReverseRoomId, elementId, getTimeStamp, lastMessage,
    firebaseId) {
  FirebaseFirestore.instance
      .collection("${strFirebaseMode}dialog")
      .where(
        "users",
        arrayContainsAny: [getRoomId, getReverseRoomId],
      )
      .get()
      .then(
        (value) => {
          if (value.docs.isEmpty)
            {
              // ADD THIS USER TO FIREBASE SERVER
              createDialog(getTimeStamp, getRoomId, getReverseRoomId,
                  firebaseId, lastMessage),
              //
            }
          else
            {
              for (var element in value.docs)
                {
                  // EDIT USER IF IT ALREADY EXIST
                  print('======> YES, DIALOG FOUND <======'),
                  print(element.id),
                  //
                  editDialog(element.id, lastMessage),
                }
            }
        },
      );
}

// /* *************************** CREATE DIALOG **************************** */
// /* ********************************************************************** */
createDialog(getChatTimeStamp, getRoomIdC, getReverseRoomIdC, getFirebaseIdC,
    lastMessageC) {
  //
  CollectionReference users = FirebaseFirestore.instance.collection(
    '${strFirebaseMode}dialog',
  );

  users
      .add({
        'sender_name':
            FirebaseAuth.instance.currentUser!.displayName.toString(),
        'sender_id': FirebaseAuth.instance.currentUser!.uid.toString(),
        'sender_email': FirebaseAuth.instance.currentUser!.email.toString(),
        'time_stamp': getChatTimeStamp.toString(),
        'last_message': lastMessageC.toString(),
        'members': [
          FirebaseAuth.instance.currentUser!.uid,
          getFirebaseIdC,
        ],
        'users': [
          getRoomIdC,
          getReverseRoomIdC,
        ],
      })
      .then(
        (value) => addDocumentIdWhenNewDialogCreated(value.id),
      )
      .catchError(
        (error) => print("Failed to add user: $error"),
      );
}

// /* **************** ADD DOCUMENT ID WHEN NEW DIALOG CREATE ************** */
// /* ********************************************************************** */
addDocumentIdWhenNewDialogCreated(value2) {
  FirebaseFirestore.instance
      .collection("${strFirebaseMode}dialog")
      .doc(value2)
      .set(
    {
      'documentId': value2.toString(),
    },
    SetOptions(merge: true),
  ).then(
    (value1) => print('ALL DONE AFTER CREAT NEW DIALOG'),
  );
}

// /* ************************** EDIT DIALOG ******************************* */
// /* ********************************************************************** */
editDialog(id, lastMessage) {
  //
  FirebaseFirestore.instance.collection("${strFirebaseMode}dialog").doc(id).set(
    {
      'time_stamp': DateTime.now().millisecondsSinceEpoch,
      'last_message': lastMessage.toString(),
    },
    SetOptions(merge: true),
  ).then(
    (value1) => print('EDIT DIALOG SUCCESSFULLY'),
  );
}
