// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:synapse_new/controllers/screens/communities/community_details/community_add_post/community_add_post.dart';
import 'package:synapse_new/controllers/screens/communities/community_details/widgets/community_about_us/about_us.dart';

import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
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
  var userSelectType = 'post';
  var setVisibility = true;
  var strFloatingActionButtonVisibility = true;
  //
  @override
  void initState() {
    print("======== PEOPLE IDs ==========");
    print(widget.getCommunityDetails);
    print("========================");
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
                            8.0,
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
                                Colors.white,
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
                            8.0,
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
        });
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
}
