// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:core';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:synapse_new/controllers/update_data_on_firebase/activate_deactivate_post/activate_deactivate_post.dart';
import 'package:synapse_new/controllers/update_data_on_firebase/delete_post/delete_post.dart';

// import '../../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../../../update_data_on_firebase/unfollow_community/unfollow_community.dart';
// import '../../../communities/community_details/community_details.dart';
import '../../../my_settings/my_profile/my_profile.dart';
import '../../../utils/utils.dart';

class FeedsHeaderUIScreen extends StatefulWidget {
  const FeedsHeaderUIScreen({
    super.key,
    this.getDataForFeedsHeader,
    required this.index,
  });

  final int index;
  final getDataForFeedsHeader;

  @override
  State<FeedsHeaderUIScreen> createState() => _FeedsHeaderUIScreenState();
}

class _FeedsHeaderUIScreenState extends State<FeedsHeaderUIScreen> {
  //
  final Stream<DocumentSnapshot> _usersStream = FirebaseFirestore.instance
      .collection('$strFirebaseMode${FirestoreUtils.USERS}')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  //
  @override
  void initState() {
    // print(widget.getDataForFeedsHeader['timeStamp']);
    // print(widget.getDataForFeedsHeader['profiledisplayImage']);
    print('object');
    print(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        top: 8.0,
      ),
      child: ListTile(
        leading: SizedBox(
          height: 50,
          width: 50,
          child: GestureDetector(
            onTap: () {
              //
              if (kDebugMode) {
                print('clicked on home page user profile image');
                print(widget.getDataForFeedsHeader['postEntityId'].toString());
              }
              //

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyProfileScreen(
                    strFirebaseId:
                        widget.getDataForFeedsHeader['postEntityId'].toString(),
                    strUsername: widget.getDataForFeedsHeader['postEntityName']
                        .toString(),
                    strBio: '',
                  ),
                ),
              );
            },
            child: StreamBuilder<DocumentSnapshot>(
                stream: _usersStream,
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading");
                  } else if (snapshot.hasError) {
                    return Text('Something went wrong');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  dynamic data = snapshot.data;
                  return new Text(data['status']);
                }),
            /*child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('$strFirebaseMode${FirestoreUtils.USERS}')
                  .where('firebaseId',
                      isEqualTo: widget.getDataForFeedsHeader['postEntityId']
                          .toString())
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var getSnapShopValue1 = snapshot.data!.docs;
                  if (kDebugMode) {
                    print('==============================');
                    print(widget.index);
                    // print(getSnapShopValue1.length);
                    // print(widget.getDataForFeedsHeader);
                    // print(getSnapShopValue1[widget.index]['profiledisplayImage']
                    //  .toString());
                    // print(
                    // getSnapShopValue[index]['postLikesCount'].toString());
                    // print('======== POST LIKE ==============');
                  }
                  return Text(
                      'ok'); /*ClipRRect(
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                    child: Image.network(
                      // dummy_image_url,
                      //
                      getSnapShopValue1[widget.index]['profiledisplayImage']
                          .toString(),
                      fit: BoxFit.cover,
                    ),
                  );*/
                } else if (snapshot.hasError) {
                  //
                  if (kDebugMode) {
                    print(snapshot.error);
                  }
                  //
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),*/
          ),
        ),
        title: text_bold_comforta(
          widget.getDataForFeedsHeader['postEntityName'].toString(),
          Colors.black,
          18.0,
        ),
        subtitle: text_bold_comforta(
          widget.getDataForFeedsHeader['communityDetails']['communityName']
              .toString(),
          Colors.grey,
          12.0,
        ),
        trailing: IconButton(
          onPressed: () {
            //
            if (kDebugMode) {
              print(widget.getDataForFeedsHeader['documentId'].toString());
              print(widget.getDataForFeedsHeader['postActive'].toString());
            }
            if (FirebaseAuth.instance.currentUser!.uid ==
                widget.getDataForFeedsHeader['postEntityId'].toString()) {
              //
              openHomePageDotsActionSheet(
                context,
                'yes',
                widget.getDataForFeedsHeader['documentId'].toString(),
                widget.getDataForFeedsHeader['postEntityName'].toString(),
                widget.getDataForFeedsHeader['postActive'].toString(),
                widget.getDataForFeedsHeader['communityDetails']
                        ['communityAdminId']
                    .toString(),
              );
            } else {
              //
              openHomePageDotsActionSheet(
                context,
                'no',
                widget.getDataForFeedsHeader['documentId'].toString(),
                widget.getDataForFeedsHeader['postEntityName'].toString(),
                'yes',
                widget.getDataForFeedsHeader['communityDetails']
                        ['communityAdminId']
                    .toString(),
              );
            }
          },
          icon: const Icon(
            Icons.more_horiz,
          ),
        ),
        /*text_bold_comforta(
          readTimestamp(
            int.parse(
              // '1698288800',
              widget.getDataForFeedsHeader['timeStamp'].toString(),
            ),
          ),
          Colors.black,
          8.0,
        ),*/
      ),
    );
  }

  //
  void openHomePageDotsActionSheet(
    BuildContext context,
    myProfile,
    passPostDocumentId,
    postAdminName,
    isYourPostActive,
    thisPostCommunityAdminId,
  ) async {
    if (myProfile == 'yes') {
      await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: text_bold_comforta(
            //
            FirebaseAuth.instance.currentUser!.displayName.toString(),
            Colors.black,
            18.0,
          ),
          // message: const Text(''),
          actions: <CupertinoActionSheetAction>[
            //
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                //
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyProfileScreen(
                      strFirebaseId: widget
                          .getDataForFeedsHeader['postEntityId']
                          .toString(),
                      strUsername: widget
                          .getDataForFeedsHeader['postEntityName']
                          .toString(),
                      strBio: '',
                    ),
                  ),
                );
                //
              },
              child: text_bold_comforta('View my profile', Colors.black, 14.0),
            ),
            //
            /*if (thisPostCommunityAdminId.toString() !=
                FirebaseAuth.instance.currentUser!.uid.toString()) ...[
              //
              CupertinoActionSheetAction(
                onPressed: () async {
                  Navigator.pop(context);
                  //
                  // from firebase method
                  unfollowThisCommunity(widget
                      .getDataForFeedsHeader['communityId'][0]
                      .toString());
                  //
                },
                child: text_bold_comforta(
                    'Unfollow this community', Colors.black, 14.0),
              ),
            ],*/
            //
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                //
                if (isYourPostActive == 'yes') {
                  activateDeactivateAlert(passPostDocumentId, isYourPostActive);
                } else {
                  if (kDebugMode) {
                    print(isYourPostActive);
                  }
                  activateDeactivateAlert(passPostDocumentId, isYourPostActive);
                }
              },
              child: isYourPostActive == 'no'
                  ? text_bold_comforta('Activate again', Colors.green, 14.0)
                  : text_bold_comforta(
                      'De-activate this post', Colors.red, 14.0),
            ),
            //
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                //
                deletePostConfirmAlert(passPostDocumentId);
              },
              child: text_bold_comforta('Delete', Colors.red, 14.0),
            ),

            //

            //
          ],
        ),
      );
    } else {
      // other's profile
      await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: text_bold_comforta(
            //
            postAdminName.toString(),
            Colors.black,
            18.0,
          ),
          // message: const Text(''),
          actions: <CupertinoActionSheetAction>[
            //

            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                //
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyProfileScreen(
                      strFirebaseId: widget
                          .getDataForFeedsHeader['postEntityId']
                          .toString(),
                      strUsername: widget
                          .getDataForFeedsHeader['postEntityName']
                          .toString(),
                      strBio: '',
                    ),
                  ),
                );
                //
              },
              child: text_bold_comforta('User profile', Colors.black, 14.0),
            ),
            //
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                //
                // from firebase method
                unfollowThisCommunity(
                    widget.getDataForFeedsHeader['communityId'][0].toString());
                //
              },
              child: text_bold_comforta(
                  'Unfollow this community', Colors.black, 14.0),
            ),
          ],
        ),
      );
    }
  }

  activateDeactivateAlert(documentId, checkedStatus) async {
    //
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: text_bold_comforta(
          //
          (checkedStatus == 'no')
              ? strActivateYourFeedMessage
              : strDeactivateYourFeedMessage,
          Colors.black,
          18.0,
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              // from firebase method
              (checkedStatus == 'no')
                  ? activateDeactivatePost(documentId, 'yes')
                  : activateDeactivatePost(documentId, 'no');
            },
            child: (checkedStatus == 'no')
                ? text_bold_comforta('Yes, activate', Colors.green, 14.0)
                : text_bold_comforta(
                    'Yes, de-activate', Colors.redAccent, 14.0),
          ),
        ],
      ),
    );
  }

  //
  deletePostConfirmAlert(documentId) async {
    //
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: text_bold_comforta(
          //
          'Are you sure you want to delete this post?',
          Colors.black,
          18.0,
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              // from firebase method
              firebaseDeleteThisPostFromDB(documentId);
            },
            child: text_bold_comforta('Yes, delete', Colors.redAccent, 14.0),
          ),
        ],
      ),
    );
  }
  // update feeds count after delete post
}
 
//
 
 