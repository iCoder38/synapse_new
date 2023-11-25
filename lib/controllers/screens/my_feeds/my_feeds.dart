// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import '../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../home_page/widget/feeds_comment_list/post_comment_list.dart';
import '../home_page/widget/feeds_header/feeds_header.dart';
import '../home_page/widget/feeds_text_image.dart';
import '../utils/utils.dart';

class MyFeedsScreen extends StatefulWidget {
  const MyFeedsScreen({
    Key? key,
    required this.getAdminFirebaseId,
  }) : super(key: key);

  final String getAdminFirebaseId;

  @override
  State<MyFeedsScreen> createState() => _MyFeedsScreenState();
}

class _MyFeedsScreenState extends State<MyFeedsScreen> {
  //
  var setAutoFocus = false;
  var postIdForComment;
  var totalCommentsCount;
  final formKey = GlobalKey<FormState>();
  TextEditingController contWriteComment = TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0),
        title: text_bold_comforta(
          'My Feeds',
          Colors.white,
          16.0,
        ),
        leading: IconButton(
          onPressed: () {
            //
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('$strFirebaseMode${FirestoreUtils.POST_FEEDS}')
            //
            .orderBy('timeStamp', descending: false)
            .where(
              'postAdminId',
              arrayContainsAny: [widget.getAdminFirebaseId.toString()],
            )
            .limit(10)
            .get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (kDebugMode) {
              print('======================');
              print('===> TOTAL POST  <===');
            }

            var getSnapShopValue = snapshot.data!.docs.reversed.toList();
            if (kDebugMode) {
              print(getSnapShopValue.length);
              print('==================================');
            }
            //
            // for (int index1 = 0; index1 < getSnapShopValue.length; index1++) {
            //   //
            //   checkMyIdForLike.add(
            //     getSnapShopValue[index1]['likes'],
            //   );
            // }

            //
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  for (int index = 0;
                      index < getSnapShopValue.length;
                      index++) ...[
                    Container(
                      // height: 240,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          // feeds header
                          FeedsHeaderUIScreen(
                            getDataForFeedsHeader: getSnapShopValue[index],
                          ),
                          //
                          if (getSnapShopValue[index]['postType'].toString() ==
                              'text') ...[
                            // Text
                            FeedsTextAndImageUIScreen(
                              strType: 'text',
                              getFeedsDataForTextAndImage:
                                  getSnapShopValue[index],
                            ),
                          ] else ...[
                            // Image
                            FeedsTextAndImageUIScreen(
                              strType: 'image',
                              getFeedsDataForTextAndImage:
                                  getSnapShopValue[index],
                            ),
                          ],
                        ],
                      ),
                    ),
                    // like comment and share
                    // userLiked
                    likeCommentUIandService(
                      context,
                      getSnapShopValue,
                      index,
                      true,
                    ),
                    //
                    Container(
                      height: 6,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey[500],
                    ),
                  ],
                  //
                  const SizedBox(
                    height: 86.0,
                  ),
                ],
              ),
            );
            //
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.pink,
            ),
          );
        },
      ),
    );
  }

  // /***********************************************************/
// /****/ UI : LIKE AND COMMENT /*****/
// /***********************************************************/
  Column likeCommentUIandService(
    BuildContext context,
    getSnapShopValue,
    int index,
    bool liked,
  ) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 6.0,
          ),
          height: 44,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Row(
            children: [
              //
              const SizedBox(
                width: 8.0,
              ),
              // Text(getSnapShopValue[index]['documentId'].toString()),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(
                        '$strFirebaseMode${FirestoreUtils.POST_LIKE}/${getSnapShopValue[index]['postId'].toString()}/${FirebaseAuth.instance.currentUser!.uid}')
                    // ${getSnapShopValue[index]['documentId'].toString()}
                    .where('postId', arrayContainsAny: [
                  //
                  // FirebaseAuth.instance.currentUser!.uid,
                  getSnapShopValue[index]['postId'].toString(),
                ])
                    // .limit(40)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var getSnapShopValue1 =
                        snapshot.data!.docs.reversed.toList();
                    if (kDebugMode) {
                      // print(getSnapShopValue1.length);
                      // print(getSnapShopValue[index]['documentId'].toString());
                      // print(
                      // getSnapShopValue[index]['postLikesCount'].toString());
                      // print('======== POST LIKE ==============');
                    }
                    return (getSnapShopValue1.isEmpty)
                        ? GestureDetector(
                            onTap: () {
                              //
                              if (kDebugMode) {
                                // print(
                                // getSnapShopValue1); // this is the value of likes list
                              }
                              // vibrate
                              HapticFeedback.lightImpact();
                              //
                              addLikeInFirebase(
                                  getSnapShopValue[index]['postId'].toString(),
                                  '1',
                                  getSnapShopValue[index]['documentId']
                                      .toString(),
                                  getSnapShopValue[index]['postLikesCount']
                                      .toString() // like
                                  );
                            },
                            child: Container(
                              height: 34.0,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  width: 0.4,
                                ),
                                borderRadius: BorderRadius.circular(
                                  22.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.favorite_border,
                                      size: 18.0,
                                      weight: 0.1,
                                    ),
                                    text_bold_comforta(
                                      //,
                                      ' ${getSnapShopValue[index]['postLikesCount']}',
                                      Colors.black,
                                      12.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              //
                              if (kDebugMode) {
                                // print(getSnapShopValue1[index]['postId']
                                // .toString());
                              }

                              addLikeInFirebase(
                                  getSnapShopValue[index]['postId'].toString(),
                                  '2',
                                  getSnapShopValue[index]['documentId']
                                      .toString(),
                                  getSnapShopValue[index]['postLikesCount']
                                      .toString() // un-like
                                  );
                            },
                            child: Container(
                              height: 34.0,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  width: 0.4,
                                ),
                                borderRadius: BorderRadius.circular(
                                  22.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.favorite,
                                      size: 18.0,
                                      weight: 0.1,
                                      color: Colors.redAccent,
                                    ),
                                    text_bold_comforta(
                                      //,
                                      ' ${getSnapShopValue[index]['postLikesCount']}',
                                      Colors.black,
                                      12.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
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
              ),
              //
              const SizedBox(
                width: 8.0,
              ),
              //
              GestureDetector(
                onTap: () {
                  //
                  totalCommentsCount =
                      getSnapShopValue[index]['postCommentCount'].toString();
                  //
                  postIdForComment =
                      getSnapShopValue[index]['postId'].toString();
                  //
                  setAutoFocus = true;
                  // show comment list bottom sheet
                  showModalBottomSheetUI(context);
                },
                child: Container(
                  height: 34.0,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      width: 0.4,
                    ),
                    borderRadius: BorderRadius.circular(
                      22.0,
                    ),
                  ),
                  /*
                      
                      */
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.chat_bubble_outline,
                          size: 18.0,
                          weight: 0.1,
                        ),
                        //
                        if (getSnapShopValue[index]['postCommentCount']
                                .toString() ==
                            '0') ...[
                          text_bold_comforta(
                            ' comment',
                            Colors.black,
                            14.0,
                          ),
                        ] else if (getSnapShopValue[index]['postCommentCount']
                                .toString() ==
                            '1') ...[
                          text_bold_comforta(
                            ' ${getSnapShopValue[index]['postCommentCount'].toString()} comment',
                            Colors.black,
                            12.0,
                          ),
                        ] else ...[
                          text_bold_comforta(
                            ' ${getSnapShopValue[index]['postCommentCount'].toString()} comments',
                            Colors.black,
                            12.0,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // }),
        // ]
      ],
    );
  }

  //
  //
  addLikeInFirebase(
    postId,
    type,
    getPostDocumentId,
    getLikesCount,
  ) async {
    //
    // printInDebugMode('======================');
    // printInDebugMode(postId);
    // printInDebugMode(getPostDocumentId);
    // printInDebugMode('======= TYPE ==========');
    // printInDebugMode(type);
    // printInDebugMode('======= TOTAL LIKES BEFORE ==========');
    // printInDebugMode(getLikesCount);
    //
    //
    var addOneLike = 0;
    if (type == '1') {
      addOneLike = int.parse(getLikesCount.toString()) + 1;
      // printInDebugMode('======= TOTAL LIKES AFTER ==========');
      // printInDebugMode(addOneLike.toString());
    } else {
      addOneLike = int.parse(getLikesCount.toString()) - 1;
      // printInDebugMode('======= TOTAL LIKES AFTER ==========');
      // printInDebugMode(addOneLike.toString());
    }
    //

    //
    if (type == '1') {
      //
      FirebaseFirestore.instance
          .collection(
            '$strFirebaseMode${FirestoreUtils.POST_LIKE}/$postId/${FirebaseAuth.instance.currentUser!.uid}',
          )
          .doc(getPostDocumentId)
          .set(
        {
          "postId": FieldValue.arrayUnion([
            postId,
          ])
        },
        SetOptions(merge: true),
      ).then(
        (value) {
          if (kDebugMode) {
            print('value 1.0');
          }
          //
          funcUpdateLikesCount(
            getPostDocumentId,
            addOneLike.toString(),
          );
        },
      );
    } else {
      //
      // printInDebugMode('=================');
      // printInDebugMode('DISLIKE THIS POST');
      // printInDebugMode('=================');
      //
      FirebaseFirestore.instance
          .collection(
            '$strFirebaseMode${FirestoreUtils.POST_LIKE}/$postId/${FirebaseAuth.instance.currentUser!.uid}',
          )
          .doc(getPostDocumentId)
          .delete()
          .then((_) {
        print(
          '''==> SUCCESSFULLY DISLIKED <==''',
        );
        funcUpdateLikesCount(
          getPostDocumentId,
          addOneLike.toString(),
        );
      });
    }
    //
  }

  //
  //
  funcUpdateLikesCount(
    getDocumentIdForEdit,
    likeCounter,
  ) {
    //
    FirebaseFirestore.instance
        .collection(
          '$strFirebaseMode${FirestoreUtils.POST_FEEDS}',
        )
        .doc(getDocumentIdForEdit)
        .set(
      {
        "postLikesCount": likeCounter.toString(),
      },
      SetOptions(merge: true),
    ).then(
      (value) {
        if (kDebugMode) {
          print('like done');
        }
        //
      },
    );
  }

  //
  //
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
                  Form(
                    key: formKey,
                    child: Padding(
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
                                    autofocus: setAutoFocus,
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
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  //
  //
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
              postIdForComment,
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
  //
}
