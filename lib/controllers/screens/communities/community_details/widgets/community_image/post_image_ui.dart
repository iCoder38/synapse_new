// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class PostImageUI extends StatefulWidget {
  const PostImageUI({super.key, this.getCommunityPostDataForPostImage});

  final getCommunityPostDataForPostImage;

  @override
  State<PostImageUI> createState() => _PostImageUIState();
}

class _PostImageUIState extends State<PostImageUI> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ui : image
        if (widget.getCommunityPostDataForPostImage['postImageLink']
                .toString() !=
            '') ...[
          imageUI(),
        ]
      ],
    );
  }

  Container imageUI() {
    return Container(
      margin: const EdgeInsets.only(
        top: 10.0,
        // bottom: 10.0,
      ),
      height: 260,
      // width: 100,
      width: MediaQuery.of(context).size.width,
      // change
      color: Colors.transparent,
      child: (widget.getCommunityPostDataForPostImage['postImageLink']
                  .toString() ==
              '')
          ? Image.asset(
              'assets/student4.jpeg',
              fit: BoxFit.cover,
              // fit: BoxFit.fitWidth,
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(
                12.0,
              ),
              child: CachedNetworkImage(
                imageUrl: widget
                    .getCommunityPostDataForPostImage['postImageLink']
                    .toString(),
                fit: BoxFit.cover,
                placeholder: (context, url) => const SizedBox(
                  height: 40,
                  width: 40,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
    );
  }

  Padding textContentUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        // height: 40,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: text_regular_comforta(
          //
          widget.getCommunityPostDataForPostImage['textContent'].toString(),
          Colors.black,
          14.0,
        ),
      ),
    );
  }

  //
  deletePostInFirebase() {
    //
    FirebaseFirestore.instance
        .collection('${strFirebaseMode}dialog')
        .doc('India')
        .collection('details')
        .doc('elementWithId'.toString())
        .set(
      {
        'time_stamp': DateTime.now().millisecondsSinceEpoch,
        'message': 'lastMessage',
        // 'sender_name': strLoginUserName.toString(),
        // 'receiver_name': createName.toString(),
      },
      SetOptions(merge: true),
    ).then(
      (value) {
        if (kDebugMode) {
          print('value 1.0');
        }
        //
        // setState(() {
        // strSetLoader = '1';
        // });
        //
      },
    );
  }
}
