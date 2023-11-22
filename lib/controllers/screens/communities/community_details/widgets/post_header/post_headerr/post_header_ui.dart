// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/utils.dart';

class PostHeaderUI extends StatefulWidget {
  const PostHeaderUI({
    super.key,
    this.getCommunityPostDataForPostHeader,
    this.getPostData,
    required this.indexNumber,
    //required this.setVisibility
  });

  final int indexNumber;
  final getPostData;
  final getCommunityPostDataForPostHeader;

  @override
  State<PostHeaderUI> createState() => _PostHeaderUIState();
}

class _PostHeaderUIState extends State<PostHeaderUI> {
  var visibility = false;
  @override
  void initState() {
    if (kDebugMode) {
      print('************');
      print('************');
      print(widget.getPostData.length);
      // print(widget.getCommunityPostDataForPostHeader);
      print('************');
      print('************');
    }
    //
    if (widget.getCommunityPostDataForPostHeader['adminId'].toString() ==
        FirebaseAuth.instance.currentUser!.uid) {
      //
      visibility = true;
    } else {
      //
      visibility = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 40,
        width: 40,
        child: CachedNetworkImage(
          imageUrl: dummy_image_url,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
          ),
        ),
      ),
      /*StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(
                '$strFirebaseMode${FirestoreUtils.USERS_COLLECTION}',
              )
              .where(
                'firebaseId',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid,
              )
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Container(
                height: 40,
                width: 40,
                color: Colors.redAccent,
              );
            }
            var userDocument = snapshot.data;
            return Text('data');
            /*Container(
              height: 60,
              width: 60,
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
                child: Image.network(
                  userDocument!.docs[0]['image'].toString(),
                  fit: BoxFit.cover,
                ),
              ),
            );*/
          }),*/
      title: text_bold_roboto(
        //
        widget.getPostData[widget.indexNumber]['postEntityName'].toString(),
        Colors.black,
        16.0,
      ),
      subtitle: text_regular_roboto(
        //
        widget.getCommunityPostDataForPostHeader['communityName'].toString(),
        Colors.grey,
        12.0,
      ),
      trailing: IconButton.filled(
        onPressed: () {
          //
          if (kDebugMode) {
            print(widget.getPostData[widget.indexNumber].data());
          }
          //
        },
        icon: const Icon(
          Icons.settings,
        ),
      ),
    );
  }

  //
  //
  void openPostSettingsOptions(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: text_bold_roboto(
          'Settings',
          Colors.black,
          14.0,
        ),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          if (visibility == true) ...[
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: text_bold_comforta(
                'Delete',
                Colors.red,
                16.0,
              ),
            ),
          ] else ...[
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: text_bold_comforta(
                'Report',
                Colors.red,
                16.0,
              ),
            ),
          ],
          /*CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: text_regular_comforta(
              'Dismiss',
              Colors.redAccent,
              14.0,
            ),
          ),*/
        ],
      ),
    );
  }
  //
}
