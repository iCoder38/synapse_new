import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../common/alert/app_color/app_color.dart';
import '../../screens/utils/utils.dart';
import '../oneToOne/one_to_one_chat.dart';

class DialogScreen extends StatefulWidget {
  const DialogScreen({super.key});

  @override
  State<DialogScreen> createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: text_bold_comforta(
          'Dialogs',
          Colors.black,
          16.0,
        ),
        backgroundColor: dialog_page_navigation_color(),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('${strFirebaseMode}dialog')
            .orderBy('time_stamp', descending: true)
            .where('members', arrayContainsAny: [
          //
          FirebaseAuth.instance.currentUser!.uid,
        ]).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (kDebugMode) {
              print(snapshot.data!.docs.length);
            }
            var saveSnapshotValue = snapshot.data!.docs;
            if (kDebugMode) {
              print(saveSnapshotValue);
            }
            return (saveSnapshotValue.isEmpty)
                ? Center(
                    child: text_bold_comforta(
                      'no chat found',
                      Colors.black,
                      14.0,
                    ),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.grey,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title:
                            (saveSnapshotValue[index]['sender_id'].toString() ==
                                    FirebaseAuth.instance.currentUser!.uid
                                        .toString())
                                ? text_bold_comforta(
                                    //
                                    saveSnapshotValue[index]['second_name']
                                        .toString(),
                                    Colors.black,
                                    14.0,
                                  )
                                : text_bold_comforta(
                                    //
                                    saveSnapshotValue[index]['sender_name']
                                        .toString(),
                                    Colors.black,
                                    12.0,
                                  ),
                        subtitle: (saveSnapshotValue[index]['last_message']
                                    .toString()
                                    .length >
                                40)
                            ? text_regular_comforta(
                                (saveSnapshotValue[index]['last_message']
                                        .toString())
                                    .replaceRange(
                                        40,
                                        (saveSnapshotValue[index]
                                                    ['last_message']
                                                .toString())
                                            .length,
                                        '...'),
                                Colors.black,
                                12.0,
                              )
                            : text_regular_comforta(
                                (saveSnapshotValue[index]['last_message']
                                    .toString()),
                                Colors.black,
                                12.0,
                              ),
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(
                              25.0,
                            ),
                          ),
                        ),
                        trailing: text_bold_comforta(
                          funcConvertTimeStampToDateAndTimeForChat(
                            int.parse(
                              saveSnapshotValue[index]['time_stamp'].toString(),
                            ),
                          ),
                          Colors.black,
                          8.0,
                        ),
                        onTap: () {
                          //
                          /*if (kDebugMode) {
                            print(FirebaseAuth.instance.currentUser!.uid);
                            print(saveSnapshotValue[index]['sender_id']
                                .toString());
                            print(saveSnapshotValue[index].data());
                            print(saveSnapshotValue[index]['members']);
                          }*/
                          var userOne = saveSnapshotValue[index]['members'][0];
                          var userTwo = saveSnapshotValue[index]['members'][1];
                          /*if (kDebugMode) {
                            print('===================================');
                            print(userOne);
                            print(userTwo);
                            print('===================================');
                          }*/

                          if (userOne.toString() ==
                              FirebaseAuth.instance.currentUser!.uid
                                  .toString()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OneToOneChatScreen(
                                    getFirebaseId: userTwo.toString(),
                                    getName: (saveSnapshotValue[index]
                                                    ['sender_id']
                                                .toString() ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                                .toString())
                                        ? saveSnapshotValue[index]
                                                ['second_name']
                                            .toString()
                                        : saveSnapshotValue[index]
                                                ['sender_name']
                                            .toString()),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OneToOneChatScreen(
                                    getFirebaseId: userOne.toString(),
                                    getName: (saveSnapshotValue[index]
                                                    ['sender_id']
                                                .toString() ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                                .toString())
                                        ? saveSnapshotValue[index]
                                                ['second_name']
                                            .toString()
                                        : saveSnapshotValue[index]
                                                ['sender_name']
                                            .toString()),
                              ),
                            );
                          }
                          /**/
                        },
                      );
                    },
                  );
          } else if (snapshot.hasError) {
            if (kDebugMode) {
              print(snapshot.error);
            }
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
