// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../my_settings/my_profile/my_profile.dart';
import '../../utils/utils.dart';

class CommunityFollowersScreen extends StatefulWidget {
  const CommunityFollowersScreen({
    Key? key,
    required this.getCommunityId,
    this.getAllFollowersId,
  }) : super(key: key);

  final String getCommunityId;
  final getAllFollowersId;

  @override
  State<CommunityFollowersScreen> createState() =>
      _CommunityFollowersScreenState();
}

class _CommunityFollowersScreenState extends State<CommunityFollowersScreen> {
  //
  @override
  void initState() {
    if (kDebugMode) {
      print('====== FOLLOWERS IDs =====');
      print(widget.getAllFollowersId);
      print(widget.getAllFollowersId.length);
      print('===========================');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: text_bold_comforta(
            'Followers',
            Colors.white,
            20.0,
          ),
        ),
        body: Column(
          children: [
            for (int i = 0; i < widget.getAllFollowersId.length; i++) ...[
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection(
                      '$strFirebaseMode${FirestoreUtils.USERS}',
                    )
                    .where('firebaseId', isEqualTo: widget.getAllFollowersId[i])
                    .snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error = ${snapshot.error}');
                  }

                  if (snapshot.hasData) {
                    final docs = snapshot.data!.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: docs.length,
                      itemBuilder: (_, i) {
                        final data = docs[i].data();
                        return ListTile(
                          leading: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                            ),
                          ),
                          title: text_bold_comforta(
                            data['name'],
                            Colors.black,
                            18.0,
                          ),
                          subtitle: text_bold_comforta(
                            data['email'],
                            Colors.black,
                            12.0,
                          ),
                          onTap: () {
                            //
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyProfileScreen(
                                  strFirebaseId: data['firebaseId'].toString(),
                                  strUsername: data['name'].toString(),
                                  strBio: data['bio'].toString(),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }

                  return const SizedBox(
                    height: 0,
                  );
                },
              ),
            ]
            /*for (int i = 0; i < widget.getAllFollowersId.length; i++) ...[
              //
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection(
                      '$strFirebaseMode${FirestoreUtils.USERS}',
                    )
                    .where(
                      'firebaseId',
                      isEqualTo: widget.getAllFollowersId[i].toString(),
                    )
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  var getSnapShopValue = snapshot.data!.docs;
                  if (kDebugMode) {
                    print(getSnapShopValue);
                    print(getSnapShopValue.length);
                  }
                  return text_bold_comforta(
                    'please wait...',
                    Colors.black,
                    14.0,
                  );
                  /*(getSnapShopValue.isEmpty)
                      ? text_bold_comforta(
                          'please wait...',
                          Colors.black,
                          14.0,
                        )
                      : ListTile(
                          title: text_bold_comforta(
                            //
                            getSnapShopValue[i]['name'].toString(),
                            Colors.black,
                            18.0,
                          ),
                          subtitle: text_regular_comforta(
                            //
                            getSnapShopValue[i]['email'].toString(),
                            Colors.black,
                            12.0,
                          ),
                        );*/
                },
              ),
              //
            ]*/
          ],
        )
        /*FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('${strFirebaseMode}communities/India/data')
              .where(
                'communityId',
                isEqualTo: widget.getCommunityId.toString(),
              )
              /*.where('followers', arrayContainsAny: [
            //
            FirebaseAuth.instance.currentUser!.uid.toString()
          ])*/
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              if (kDebugMode) {
                print('==================================');
                print('====> SHOW ALL FOLLOWERS <========');
              }

              var getSnapShopValue = snapshot.data!.docs.reversed.toList();
              if (kDebugMode) {
                print(getSnapShopValue[0]['followers']);
              }
              if (getSnapShopValue[0]['followers'].isEmpty) {
                return Center(
                  child: text_bold_comforta(
                    'no followers',
                    Colors.black,
                    14.0,
                  ),
                );
              } else {
                for (int i = 0; i < getSnapShopValue.length;) {
                  return ListTile(
                    title: text_bold_comforta(
                      'str',
                      Colors.black,
                      14.0,
                    ),
                  );
                }
              }
            } else if (snapshot.hasError) {
              // return Center(
              //   child: Text(
              //     'Error: ${snapshot.error}',
              //   ),

              // );
              if (kDebugMode) {
                print(snapshot.error);
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),*/
        );
  }
}
