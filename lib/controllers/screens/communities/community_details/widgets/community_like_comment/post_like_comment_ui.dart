// ignore_for_file: prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:uuid/uuid.dart';

import '../../../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../../../home_page/widget/feeds_comment_list/post_comment_list.dart';
import '../../../../utils/utils.dart';
import '../community_description/post_description.dart';

class PostLikeCommentsUI extends StatefulWidget {
  const PostLikeCommentsUI({
    super.key,
    this.getCommunityPostDataForLikeComment,
    required this.indexNumber,
    // this.getCommunityFullDataForLikeAndComment,
  });

  final int indexNumber;
  // final getCommunityFullDataForLikeAndComment;
  final getCommunityPostDataForLikeComment;

  @override
  State<PostLikeCommentsUI> createState() => _PostLikeCommentsUIState();
}

class _PostLikeCommentsUIState extends State<PostLikeCommentsUI> {
  //
  final formKey = GlobalKey<FormState>();
  TextEditingController contWriteComment = TextEditingController();
  //
  var postIdForComment;
  var totalCommentsCount;
  var getPostDocumentId;
  var sum = 0;
  var status = 0;
  //
  @override
  void initState() {
    // printInDebugMode('========== GET DATA FOR  COMMENT ==============');
    // printInDebugMode(widget.getCommunityPostDataForLikeComment);
    // printInDebugMode(
    // widget.getCommunityPostDataForLikeComment[widget.indexNumber]);
    // printInDebugMode(
    // widget.getCommunityPostDataForLikeComment[widget.indexNumber]
    // ['postCommentCount']);
    // printInDebugMode(widget.getCommunityPostDataForLikeComment);
    // printInDebugMode('======================================');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.getCommunityPostDataForLikeComment[widget.indexNumber]
                ['postType'] ==
            'text') ...[
          // ui : post description
          Padding(
            padding: const EdgeInsets.only(
              top: 14.0,
              left: 14.0,
              bottom: 14.0,
              right: 14.0,
            ),
            child: PostDescriptionUI(
              getCommunityPostDataForDescription:
                  widget.getCommunityPostDataForLikeComment[widget.indexNumber],
            ),
          ),
        ],

        Container(
          // height: 40,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  //
                  print('==> CLICKED : LIKES <==');
                  final snackBar = SnackBar(
                    content: const Text('Developer is working on it.'),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ),
                  );
                  //
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //
                },
                icon: const Icon(
                  Icons.favorite_border,
                ),
              ),
              IconButton(
                onPressed: () {
                  //
                  print('==> CLICKED : View All Comments');
                  print(widget
                      .getCommunityPostDataForLikeComment[widget.indexNumber]
                          ['communityId'][0]
                      .toString());
                  totalCommentsCount = widget
                      .getCommunityPostDataForLikeComment[widget.indexNumber]
                          ['postCommentCount']
                      .toString();
                  //
                  postIdForComment = widget
                      .getCommunityPostDataForLikeComment[widget.indexNumber]
                          ['postId']
                      .toString();
                  print(postIdForComment.toString());
                  //
                  // show comment list bottom sheet
                  showModalBottomSheetUI(context);
                },
                icon: const Icon(
                  Icons.comment_bank_outlined,
                ),
              )
            ],
          ),
        ),
        if (widget.getCommunityPostDataForLikeComment[widget.indexNumber]
                ['postType'] !=
            'text') ...[
          // ui : post description
          Padding(
            padding: const EdgeInsets.only(
              top: 14.0,
              left: 14.0,
              bottom: 14.0,
              right: 14.0,
            ),
            child: PostDescriptionUI(
              getCommunityPostDataForDescription:
                  widget.getCommunityPostDataForLikeComment[widget.indexNumber],
            ),
          ),
        ],

        //
        GestureDetector(
          onTap: () {
            //
            print('==> CLICKED : View All Comments');
            print(widget.getCommunityPostDataForLikeComment[widget.indexNumber]
                    ['communityId'][0]
                .toString());
            totalCommentsCount = widget
                .getCommunityPostDataForLikeComment[widget.indexNumber]
                    ['postCommentCount']
                .toString();
            //
            postIdForComment = widget
                .getCommunityPostDataForLikeComment[widget.indexNumber]
                    ['postId']
                .toString();
            print(postIdForComment.toString());
            //
            // show comment list bottom sheet
            showModalBottomSheetUI(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              // top: 8.0,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child:
                  (widget.getCommunityPostDataForLikeComment[widget.indexNumber]
                                  ['postCommentCount']
                              .toString() ==
                          '0')
                      ? text_bold_comforta(
                          //
                          'Write a comment',
                          Colors.grey,
                          16.0,
                        )
                      : text_bold_comforta(
                          //
                          'View all ${(widget.getCommunityPostDataForLikeComment[widget.indexNumber]['postCommentCount'].toString())} comments',
                          Colors.grey,
                          16.0,
                        ),
            ),
          ),
        ),
        //
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            left: 12.0,
          ),
          child: Row(
            children: [
              text_bold_comforta(
                //
                funcConvertTimeStampToDateAndTime(
                  widget.getCommunityPostDataForLikeComment[widget.indexNumber]
                      ['timeStamp'],
                ),
                // readTimestamp(int.parse(widget
                //     .getCommunityPostDataForLikeComment[widget.indexNumber]
                //         ['timeStamp']
                //     .toString())),

                Colors.black,
                12.0,
              ),
            ],
          ),
        ), //
      ],
    );
  }

  Future<dynamic> showModalBottomSheetUI(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return AnimatedPadding(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: FractionallySizedBox(
              heightFactor: 0.8,
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 0, bottom: 80),
                    // height: MediaQuery.of(context).size.height - 60,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(
                                '$strFirebaseMode${FirestoreUtils.POST_COMMENT}')
                            .orderBy('timeStamp', descending: false)
                            .where('postId', arrayContainsAny: [
                              //
                              postIdForComment.toString(),
                            ])
                            .limit(40)
                            .snapshots(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            if (kDebugMode) {
                              print('==================================');
                              print('==========> COMMENT LIST <========');
                              print('==================================');
                            }

                            var getSnapShopValue =
                                snapshot.data!.docs.reversed.toList();
                            if (kDebugMode) {
                              print(getSnapShopValue.length);
                            }
                            // comment list
                            return PostCommentListUI(
                              getCommentData: getSnapShopValue,
                            );
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
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: contWriteComment,
                                  decoration: const InputDecoration(
                                    // labelText: "Search",
                                    hintText: "write a comment...",
                                    // prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          25.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // autofocus: true,
                                ),
                              ),
                              //
                              IconButton.filled(
                                onPressed: () {
                                  //

                                  addPostCommentInFirebase(
                                    'text',
                                    contWriteComment.text.toString(),
                                  );
                                  //
                                  contWriteComment.text = '';
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);

                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                },
                                icon: const Icon(
                                  Icons.send,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  // add comment on firebase
  addPostCommentInFirebase(postType, message) {
    //
    CollectionReference users = FirebaseFirestore.instance.collection(
      // '${strFirebaseMode}post/India/data',
      '$strFirebaseMode${FirestoreUtils.POST_COMMENT}',
    );

    users
        .add(
          {
            'commentId': const Uuid().toString(),
            'postId': [
              widget.getCommunityPostDataForLikeComment[widget.indexNumber]
                  ['postId']
            ],
            'commentAdminId': [
              FirebaseAuth.instance.currentUser!.uid,
            ],
            //
            'postUserName': FirebaseAuth.instance.currentUser!.displayName,
            'postUserFirebaseId': FirebaseAuth.instance.currentUser!.uid,
            'postUserEmail': FirebaseAuth.instance.currentUser!.email,
            //
            'commentMessage': message.toString(),
            //
            'timeStamp': DateTime.now().millisecondsSinceEpoch,
            //
            'postType': postType.toString(),
            'postActive': 'yes',
            //
          },
        )
        .then(
          (value) => addCommentFirestoreId(value.id),
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  //
  //
  addCommentFirestoreId(elementId) {
    //
    contWriteComment.text = '';
    FirebaseFirestore.instance
        .collection("$strFirebaseMode${FirestoreUtils.POST_COMMENT}")
        // .doc('India')
        //.collection('data')
        .doc(elementId)
        .set(
      {
        'documentId': elementId,
      },
      SetOptions(merge: true),
    ).then(
      (value1) {
        // dismiss keyboard
        getTotalNumberOfCommentsInThisPostToUpdate();
      },
    );
  }

  //
  getTotalNumberOfCommentsInThisPostToUpdate() {
    FirebaseFirestore.instance
        // .collection(
        //     "$strFirebaseMode${FirestoreUtils.POST_FEEDS}/${widget.getCommunityPostDataForLikeComment[widget.indexNumber]['communityId'][0].toString()}/data")
        .collection("$strFirebaseMode${FirestoreUtils.POST_FEEDS}")
        .where(
          'postId',
          isEqualTo: postIdForComment.toString(),
        )
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.docs);
      }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('======> NO USER FOUND in this community');
        }
      } else {
        for (var element in value.docs) {
          if (kDebugMode) {
            // print('======> YES,  USER FOUND');
            print(element.id);
            // print(element.data());
            // print(value.docs);
            // arr.add(element.id);
          }
          //
          var sum = 0;
          sum = int.parse(element.data()['postCommentCount'].toString()) + 1;

          //
          FirebaseFirestore.instance
              .collection("$strFirebaseMode${FirestoreUtils.POST_FEEDS}")
              // .collection(
              //     "$strFirebaseMode${FirestoreUtils.POST_FEEDS}/${widget.getCommunityPostDataForLikeComment[widget.indexNumber]['communityId'][0].toString()}/data")
              .doc(element.id)
              .set(
            {
              'postCommentCount': sum.toString(),
            },
            SetOptions(merge: true),
          ).then(
            (value1) {
              //
            },
          );
          //
        }
      }
    });
    // );
  }
}
