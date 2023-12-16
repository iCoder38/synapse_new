// import 'package:flutter/foundation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synapse_new/controllers/common/app_bar/app_bar.dart';
import 'package:synapse_new/controllers/screens/utils/utils.dart';

import '../../chat/oneToOne/one_to_one_chat.dart';
import '../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  //
  bool selected = false;
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarScreen(navigationTitle: 'Notifications'),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('${strFirebaseMode}notifications')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('data')
            .orderBy('timeStamp', descending: true)
            /*.where('members', arrayContainsAny: [
          //
          FirebaseAuth.instance.currentUser!.uid,
        ])*/
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (kDebugMode) {
              print(snapshot.data!.docs.length);
            }
            var saveSnapshotValue = snapshot.data!.docs;
            if (kDebugMode) {
              print(saveSnapshotValue);
            }
            if (saveSnapshotValue.isEmpty) {
              return Center(
                child: text_bold_comforta(
                  'no data found',
                  Colors.black,
                  14.0,
                ),
              );
            } else {
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: snapshot.data!
                                .docs[index]['notification_like_entity_name']
                                .toString(),
                            style: GoogleFonts.comfortaa(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    ' ${snapshot.data!.docs[index]['notification_message']}',
                                style: GoogleFonts.comfortaa(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' your ${snapshot.data!.docs[index]['type']}',
                                style: GoogleFonts.comfortaa(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    // subtitle: text_bold_comforta(
                    //   readTimestamp(
                    //     int.parse(
                    //       // '1698288800',
                    //       snapshot.data!.docs[index]['timeStamp'].toString(),
                    //     ),
                    //   ),
                    //   Colors.black,
                    //   8.0,
                    // ),
                    leading: SizedBox(
                      height: 50,
                      width: 50,
                      child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        future: FirebaseFirestore.instance
                            .collection(
                              '$strFirebaseMode${FirestoreUtils.USERS}/data/${snapshot.data!.docs[index]['notification_post_admin_id'].toString()}',
                            )
                            .get(),
                        builder: (BuildContext context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Text("Loading");
                          } else if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          // dynamic data = snapshot.data;

                          final List<
                                  QueryDocumentSnapshot<Map<String, dynamic>>>
                              docs = snapshot.data!.docs;
                          //
                          return (docs[0]['profiledisplayImage'] == '')
                              ? Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        25.0,
                                      ),
                                      border: Border.all()),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    25.0,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: docs[0]['profiledisplayImage']
                                        .toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                );
                        },
                      ),
                    ),
                  );
                  /*(snapshot.data!.docs[index]['type'].toString() ==
                              'post')
                          ? ListTile(
                              
                              title: text_bold_comforta(
                                //
                                snapshot.data!.docs[index]
                                    ['notification_post_admin_id'],
                                Colors.black,
                                18.0,
                              ),
                            )
                          : ListTile(
                              title: text_bold_comforta(
                                //
                                snapshot.data!.docs[index]
                                    ['notification_post_admin_id'],
                                Colors.black,
                                18.0,
                              ),
                            );*/
                },
              );
            }
            /**/
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
