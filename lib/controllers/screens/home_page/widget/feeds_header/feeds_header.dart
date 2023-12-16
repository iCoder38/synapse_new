// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:core';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
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
      .doc('4FqrwaXYDUxZz5JKdtqn')
      .snapshots();
  //
  @override
  void initState() {
    // print(widget.getDataForFeedsHeader['timeStamp']);
    // print(widget.getDataForFeedsHeader['profiledisplayImage']);
    // print('object');
    // print(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
                  strUsername:
                      widget.getDataForFeedsHeader['postEntityName'].toString(),
                  strBio: '',
                ),
              ),
            );
          },
          // 4FqrwaXYDUxZz5JKdtqn
          child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection(
                  '$strFirebaseMode${FirestoreUtils.USERS}/data/${FirebaseAuth.instance.currentUser!.uid}',
                )
                .get(),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) {
                return const Text("Loading");
              } else if (snapshot.hasError) {
                return const Text('Something went wrong');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              // dynamic data = snapshot.data;

              final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
                  snapshot.data!.docs;
              //
              return (docs[0]['profiledisplayImage'] == '')
                  ? Container(
                      height: 40,
                      width: 40,
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
                        imageUrl: docs[0]['profiledisplayImage'].toString(),
                        placeholder: (context, url) => const SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    );
            },
          ),
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
                  widget.getDataForFeedsHeader['communityId'][0].toString(),
                  widget.getDataForFeedsHeader['communityDetails']
                          ['communityDocumentId']
                      .toString(),
                );
                //
              },
              child: text_bold_comforta(
                  'Unfollow community'.toString(), Colors.redAccent, 14.0),
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
 
 