// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:synapse_new/controllers/screens/communities/community_details/community_add_post/community_add_post.dart';
import 'package:synapse_new/controllers/screens/communities/community_details/widgets/community_about_us/about_us.dart';
import 'package:uuid/uuid.dart';

import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../home_page/widget/feeds_comment_list/post_comment_list.dart';
import '../../home_page/widget/feeds_header/feeds_header.dart';
import '../../home_page/widget/feeds_text_image.dart';
import '../../utils/utils.dart';
import 'widgets/post_header/post_header.dart';

class CommunityDetailsScreen extends StatefulWidget {
  const CommunityDetailsScreen(
      {super.key, required this.getCommunityName, this.getCommunityDetails});

  final String getCommunityName;
  final getCommunityDetails;

  @override
  State<CommunityDetailsScreen> createState() => CommunityDetailsScreenState();
}

class CommunityDetailsScreenState extends State<CommunityDetailsScreen> {
  //
  final formKey = GlobalKey<FormState>();
  TextEditingController contWriteComment = TextEditingController();
  var setAutoFocus = false;
  var postIdForComment;
  var totalCommentsCount;
  //
  var userSelectType = 'post';
  var setVisibility = true;
  var strFloatingActionButtonVisibility = true;
  //
  @override
  void initState() {
    if (kDebugMode) {
      // print("======== PEOPLE IDs ==========");
      // print(widget.getCommunityDetails);
      // print("========================");
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: text_bold_roboto(
          //
          widget.getCommunityName.toString(),
          Colors.black,
          16.0,
        ),
        backgroundColor: Colors.white,
      ),
      // floatingActionButton:

      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('${strFirebaseMode}communities/India/data')
              .where(
                'documentId',
                isEqualTo: widget.getCommunityDetails['documentId'],
              )
              .where('followers', arrayContainsAny: [
            //
            FirebaseAuth.instance.currentUser!.uid.toString()
          ]).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              if (kDebugMode) {
                print('==================================');
                print('====> TO SHOW FOLLOW BUTTON <=====');
              }

              var getSnapShopValue = snapshot.data!.docs.reversed.toList();
              if (kDebugMode) {
                print(getSnapShopValue.length);
              }
              return (getSnapShopValue.isEmpty)
                  ? Stack(
                      children: [
                        showAllPostsListFromFirebase(),
                        //
                        Padding(
                          padding: const EdgeInsets.all(
                            16.0,
                          ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton.extended(
                              onPressed: () {
                                //
                                followThisGroupInFirebase();
                              },
                              label: text_bold_comforta(
                                'Follow',
                                Colors.black,
                                14.0,
                              ),
                            ),
                          ),
                        )
                        //
                      ],
                    )
                  : Stack(
                      children: [
                        showAllPostsListFromFirebase(),
                        //
                        Padding(
                          padding: const EdgeInsets.all(
                            16.0,
                          ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                              onPressed: () {
                                //
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CommunityAddPostScreen(
                                      getCommunityFullDetails:
                                          widget.getCommunityDetails,
                                    ),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.edit,
                              ),
                            ),
                          ),
                        )
                        //
                      ],
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
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>
      showAllPostsListFromFirebase() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(
              // '${strFirebaseMode}post/${widget.getCommunityDetails['communityId'].toString()}/data')
              '$strFirebaseMode${FirestoreUtils.POST_FEEDS}')
          .orderBy('timeStamp', descending: true)
          .where('communityId', arrayContainsAny: [
            //
            widget.getCommunityDetails['communityId'].toString()
            //
          ])
          .limit(40)
          .snapshots(),
      /*FirebaseFirestore.instance
          .collection('$strFirebaseMode${FirestoreUtils.POST_FEEDS}')
          //
          .orderBy('timeStamp', descending: false)
          .where(
            'communityId',
            arrayContainsAny: [
              widget.getCommunityDetails['communityId'].toString()
            ],
          )
          .limit(10)
          .snapshots(),*/
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (kDebugMode) {
            // print('======================');
            // print('===> TOTAL POST  <===');
          }

          var getSnapShopValue = snapshot.data!.docs.reversed.toList();
          if (kDebugMode) {
            // print(getSnapShopValue.length);
            // print('==================================');
          }
          //
          /*for (int index1 = 0; index1 < getSnapShopValue.length; index1++) {
            //
            checkMyIdForLike.add(
              getSnapShopValue[index1]['likes'],
            );
          }*/
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
                  // like, comment UI
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
    );
    /*StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
                // '${strFirebaseMode}post/${widget.getCommunityDetails['communityId'].toString()}/data')
                '$strFirebaseMode${FirestoreUtils.POST_FEEDS}')
            .orderBy('timeStamp', descending: true)
            .where('communityId', arrayContainsAny: [
              //
              widget.getCommunityDetails['communityId'].toString()
              //
            ])
            .limit(40)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (kDebugMode) {
              print('==================================');
              print('======> MY TOTAL POST COUNT <=====');
            }

            var getSnapShopValue = snapshot.data!.docs.reversed.toList();
            if (kDebugMode) {
              print(getSnapShopValue.length);
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (userSelectType == 'post') ...[
                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child: getTopThreeTabsUI(context),
                    ),
                    Expanded(
                      //  ui : post ui
                      child: (getSnapShopValue.isEmpty)
                          ? const SizedBox(
                              height: 0,
                            )
                          : CommunityPostUI(
                              getCommunityData: widget.getCommunityDetails,
                              getCommunityPostData:
                                  snapshot.data!.docs.toList(),
                            ),
                    ),
                  ] else if (userSelectType == 'about') ...[
                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child: getTopThreeTabsUI(context),
                    ),
                    //
                    // text_bold_comforta(
                    //   'here',
                    //   Colors.black,
                    //   14.0,
                    // ),
                    Expanded(
                      // ui : about us
                      child: CommunityAmoutUsScreen(
                        getCommunityDetailsForAboutUs:
                            widget.getCommunityDetails,
                      ),
                    ),
                  ] else if (userSelectType == 'people') ...[
                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child: getTopThreeTabsUI(context),
                    ),
                    //
                    if (widget.getCommunityDetails['followers'].length ==
                        0) ...[
                      Expanded(
                        child: Center(
                          child: text_bold_comforta(
                            'No one follow this community',
                            Colors.black,
                            14.0,
                          ),
                        ),
                      ),
                    ] else ...[
                      //
                      for (int i = 0;
                          i < widget.getCommunityDetails['followers'].length;
                          i++) ...[
                        //
                        Expanded(
                          child: ListTile(
                            title: text_bold_comforta(
                              'str',
                              Colors.black,
                              16.0,
                            ),
                            subtitle: text_bold_comforta(
                              'str',
                              Colors.black,
                              12.0,
                            ),
                          ),
                        ),
                        //
                      ]
                      //
                    ],
                    // (widget.getCommunityDetails['followers'].length == 0)
                    // ? text_regular_comforta('', Colors.black, 14.0,):

                    /*Expanded(
                      // Added
                      child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection(
                                '$strFirebaseMode${FirestoreUtils.POST_LIKE}/${getSnapShopValue[0]['postId'].toString()}/${FirebaseAuth.instance.currentUser!.uid}')
                            .where('postId', arrayContainsAny: [
                          //
                          getSnapShopValue[0]['postId'].toString(),
                        ])
                            // .limit(40)
                            .get(),
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
                                ? Container(
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
                                            ' ${getSnapShopValue[0]['postLikesCount']}',
                                            Colors.black,
                                            12.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(
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
                                            ' ${getSnapShopValue[0]['postLikesCount']}',
                                            Colors.black,
                                            12.0,
                                          ),
                                        ],
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
                    ),*/
                  ]
                ],
              ),
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
        });*/
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

  Container postUI(BuildContext context,
      List<QueryDocumentSnapshot<Object?>> getSnapShopValue) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: getSnapShopValue.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      //
                      if (kDebugMode) {
                        print('==> you clicked post 1 <==');
                      }
                      //
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          // Text('data'),
                          ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  25.0,
                                ),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.withOpacity(0.5),
                                //     spreadRadius: 5,
                                //     blurRadius: 7,
                                //     offset: const Offset(
                                //         0, 3), // changes position of shadow
                                //   ),
                                // ],
                              ),
                            ),
                            title: text_bold_roboto(
                              //
                              widget.getCommunityDetails['adminName']
                                  .toString(),
                              Colors.black,
                              16.0,
                            ),
                            subtitle: text_regular_roboto(
                              //
                              widget.getCommunityDetails['communityName']
                                  .toString(),
                              Colors.grey,
                              12.0,
                            ),
                            trailing: IconButton.filled(
                              onPressed: () {
                                //
                                // openPostSettingsOptions(context);
                              },
                              icon: const Icon(
                                Icons.settings,
                              ),
                            ),
                          ),
                          //
                          if (getSnapShopValue[index]['postImageLink']
                                  .toString() !=
                              '') ...[
                            Container(
                              margin: const EdgeInsets.only(
                                top: 10.0,
                              ),
                              height: 220,
                              // width: 100,
                              color: Colors.transparent,
                              child: (getSnapShopValue[index]['postImageLink']
                                          .toString() ==
                                      '')
                                  ? Image.asset(
                                      'assets/student4.jpeg',
                                      fit: BoxFit.fill,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: getSnapShopValue[index]
                                              ['postImageLink']
                                          .toString(),
                                      placeholder: (context, url) =>
                                          const SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                              /*Image.network(
                                      getSnapShopValue[index]['postImageLink']
                                          .toString(),
                                    ),*/
                            ),
                          ],
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(
                                      22.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  // height: 20,
                                  // width: MediaQuery.of(context).size.width,
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: text_bold_roboto(
                                      //
                                      '${getSnapShopValue[index]['postEntityName']}',
                                      Colors.black,
                                      20.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: text_bold_roboto(
                                  ' Admin name : ',
                                  Colors.black,
                                  14.0,
                                ),
                              ),
                              Container(
                                // height: 20,
                                // width: MediaQuery.of(context).size.width,
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: text_regular_roboto(
                                    //
                                    '${getSnapShopValue[index]['textContent']}',
                                    Colors.black,
                                    12.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ); /*ListTile(
                  title: text_bold_roboto(
                    'str',
                    Colors.black,
                    16.0,
                  ),
                );*/
              },
            ),
            /*GridView.count(
                        crossAxisCount: 3,
                        children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                            .map((el) => Text(el.toString()))
                            .toList() as List<Widget>,
                        // shrinkWrap: true, // changed
                      ),*/
          ),
        ],
      ),
    );
  }

  Row getTopThreeTabsUI(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              //
              setState(() {
                userSelectType = 'post';
                setVisibility = true;
              });
            },
            child: (userSelectType == 'post')
                ? Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Center(
                      child: text_bold_roboto(
                        'Post',
                        Theme.of(context).primaryColor,
                        18.0,
                      ),
                    ),
                  )
                : Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Center(
                      child: text_bold_roboto(
                        'Post',
                        Colors.black,
                        14.0,
                      ),
                    ),
                  ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              //
              setState(() {
                userSelectType = 'about';
                setVisibility = false;
              });
            },
            child: (userSelectType == 'about')
                ? Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Center(
                      child: text_bold_roboto(
                        'About',
                        Theme.of(context).primaryColor,
                        18.0,
                      ),
                    ),
                  )
                : Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Center(
                      child: text_bold_roboto(
                        'About',
                        Colors.black,
                        14.0,
                      ),
                    ),
                  ),
          ),
        ),
        /*Expanded(
          child: GestureDetector(
            onTap: () {
              //
              setState(() {
                userSelectType = 'people';
                setVisibility = false;
              });
            },
            child: (userSelectType == 'people')
                ? Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Center(
                      child: text_bold_roboto(
                        'People',
                        Theme.of(context).primaryColor,
                        18.0,
                      ),
                    ),
                  )
                : Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Center(
                      child: text_bold_roboto(
                        'People',
                        Colors.black,
                        14.0,
                      ),
                    ),
                  ),
          ),
        ),*/
      ],
    );
  }

  //
  followThisGroupInFirebase() {
    //
    FirebaseFirestore.instance
        .collection('${strFirebaseMode}communities/India/data')
        .doc(widget.getCommunityDetails['documentId'])
        .update(
      {
        "followers": FieldValue.arrayUnion(
          [
            FirebaseAuth.instance.currentUser!.uid,
          ],
        ),
      },
    ).then((value) => {
              //
              addMeInFollowList(),
            });
  }

  //
  //
  addMeInFollowList() {
    //
    CollectionReference users = FirebaseFirestore.instance.collection(
        '$strFirebaseMode${FirestoreUtils.FOLLOW}/${FirebaseAuth.instance.currentUser!.uid}/data');

    users
        .add(
          {
            'communityIds': [
              widget.getCommunityDetails['communityId'].toString(),
            ],
            'timeStamp': DateTime.now().millisecondsSinceEpoch,
          },
        )
        .then(
          (value) =>
              //
              addFirestoreIdInAfterFollow(
            value.id,
          ),
          //
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  //
  addFirestoreIdInAfterFollow(elementId) {
    //
    FirebaseFirestore.instance
        .collection(
            '$strFirebaseMode${FirestoreUtils.FOLLOW}/${FirebaseAuth.instance.currentUser!.uid}/data')
        .doc(elementId)
        .set(
      {
        'followId': elementId,
      },
      SetOptions(merge: true),
    ).then(
      (value1) {
        // dismiss popup
        // Navigator.pop(context);
        // Navigator.pop(context);
        // addMeOnValidPost(elementId);
      },
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
        if (kDebugMode) {
          print(
            '''==> SUCCESSFULLY DISLIKED <==''',
          );
        }
        funcUpdateLikesCount(
          getPostDocumentId,
          addOneLike.toString(),
        );
      });
    }
    //
  }

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
}
