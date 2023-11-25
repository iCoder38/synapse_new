import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/alert/alert.dart';
import '../../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../../utils/utils.dart';

class CommunityAddPostScreen extends StatefulWidget {
  const CommunityAddPostScreen({super.key, this.getCommunityFullDetails});
  final getCommunityFullDetails;
  @override
  State<CommunityAddPostScreen> createState() => _CommunityAddPostScreenState();
}

class _CommunityAddPostScreenState extends State<CommunityAddPostScreen> {
  //
  var documentIdForFeedsCount = '0';
  var totalFeeds = '0';
  //
  var communityImageUrl = '';
  var userSelectCommunityName = 'Personal';
  var userSelectCommunityDocumentId = '';
  var userSelectCommunityId = '';
  var uuid = const Uuid().toString();
  //
  TextEditingController contWhatInYourMind = TextEditingController();
  //
  XFile? image;
  final ImagePicker picker = ImagePicker();
  //
  @override
  void initState() {
    //
    // getAllMyCommunitiesFromFirebase();
    if (kDebugMode) {
      print('========== COMMUNITY FULL DETAILS 2.0 ==========');
      print(widget.getCommunityFullDetails);
      print('=================================================');
    }
    getDataFromCounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: text_bold_roboto(
          //
          'Add Post'.toString(),
          Colors.black,
          16.0,
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('${strFirebaseMode}communities')
                  .doc('India')
                  .collection('data')
                  .where('communityAdminId', arrayContainsAny: [
                    //
                    FirebaseAuth.instance.currentUser!.uid,
                    //
                  ])
                  .limit(40)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  if (kDebugMode) {
                    print('==================================');
                    print('==> MY TOTAL COMMUNITIES COUNT <==');
                    print('==================================');
                  }

                  var getSnapShopValue = snapshot.data!.docs.reversed.toList();
                  if (kDebugMode) {
                    print(getSnapShopValue.length);
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                text_regular_comforta(
                                  //
                                  FirebaseAuth.instance.currentUser!.displayName
                                      .toString(),
                                  Colors.black,
                                  16.0,
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 4.0),
                                //   child: Text(userName,
                                //       style: GoogleFonts.comfortaa(
                                //           textStyle: const TextStyle(
                                //               fontSize: 16,
                                //               fontWeight: FontWeight.bold))),
                                // ),
                                GestureDetector(
                                  onTap: () {
                                    //
                                    if (kDebugMode) {
                                      print('clicked to select');
                                    }

                                    /*showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () =>
                                              Navigator.of(context).pop(),
                                          child: Container(
                                            color: const Color.fromRGBO(
                                              0,
                                              0,
                                              0,
                                              0.001,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                //
                                              },
                                              child: DraggableScrollableSheet(
                                                initialChildSize: 0.4,
                                                minChildSize: 0.2,
                                                maxChildSize: 0.75,
                                                builder: (_, controller) {
                                                  return Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                25.0),
                                                        topRight:
                                                            Radius.circular(
                                                                25.0),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Icon(
                                                          Icons.remove,
                                                          color:
                                                              Colors.grey[600],
                                                        ),
                                                        communityListUI(
                                                            controller,
                                                            getSnapShopValue),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );*/
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      top: 4,
                                      left: 4,
                                    ),
                                    // padding: const EdgeInsets.only(left: 4.0),
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 225, 225, 225),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: text_regular_roboto(
                                        //
                                        widget.getCommunityFullDetails[
                                                'communityName']
                                            .toString(),
                                        // userSelectCommunityName.toString(),
                                        Colors.black,
                                        14.0,
                                      ),
                                      // child: Text(
                                      //   communityName,
                                      //   style: GoogleFonts.comfortaa(
                                      //     textStyle: const TextStyle(
                                      //       fontSize: 12,
                                      //     ),
                                      //   ),
                                      // ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //
                      GestureDetector(
                        onTap: () {
                          //
                          pickImage();
                        },
                        child: Container(
                          height: 260,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              12.0,
                            ),
                            border: Border.all(
                              width: 0.4,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: (image == null)
                                  ? SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Image.asset(
                                          'assets/apple.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    )
                                  : Image.file(
                                      //to show image, you type like this.
                                      File(image!.path),
                                      fit: BoxFit.fitHeight,
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      //
                      Container(
                        margin: const EdgeInsets.only(
                          top: 10.0,
                        ),
                        // height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          // color: Colors.brown,
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: contWhatInYourMind,
                            minLines: 1,
                            maxLines: 6,
                            decoration: const InputDecoration(
                              // labelText: '',
                              hintText: "what's in your mind ?",
                            ),
                          ),
                        ),
                      ),
                      //
                      GestureDetector(
                        onTap: () {
                          //

                          showLoadingUI(context, str_alert_please_wait);
                          imageValidationBeforeAddPost();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(
                              12.0,
                            ),
                          ),
                          child: Center(
                            child: text_bold_roboto(
                              'Create',
                              Colors.white,
                              16.0,
                            ),
                          ),
                        ),
                      ),
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
        ),
      ),
    );
  }

  Expanded communityListUI(ScrollController controller,
      List<QueryDocumentSnapshot<Object?>> getSnapShopValue) {
    return Expanded(
      child: ListView.builder(
        controller: controller,
        itemCount: getSnapShopValue.length,
        itemBuilder: (_, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: text_regular_roboto(
                    //
                    getSnapShopValue[index]['communityName'].toString(),
                    Colors.black,
                    16.0,
                  ),
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                      child: Image.network(
                        //
                        getSnapShopValue[index]['communityImage'].toString(),

                        fit: BoxFit.cover,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  onTap: () {
                    //
                    userSelectCommunityId =
                        getSnapShopValue[index]['communityId'].toString();
                    //
                    userSelectCommunityDocumentId =
                        getSnapShopValue[index]['documentId'].toString();
                    //
                    userSelectCommunityName =
                        getSnapShopValue[index]['communityName'].toString();
                    //
                    if (kDebugMode) {
                      print(userSelectCommunityId);
                      print(userSelectCommunityDocumentId);
                      print(userSelectCommunityName);
                    }
                    //
                    Navigator.pop(context);
                    //
                    setState(() {});
                  },
                ),
              ),
              //
              Container(
                height: 0.4,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
              ),
            ],
          );
          /*Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: text_bold_roboto(
                getSnapShopValue[index]['communityName'].toString(),
                Colors.black,
                16.0,
              ),
            ),
          );*/
        },
      ),
    );
  }

  //
  Future<void> pickImage() async {
    var img = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = img;
      //
      communityImageUrl = 'yes';
    });
    //
  }

//
  String generateRandomString(int lengthOfString) {
    final random = Random();
    const allChars =
        'AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL234567890';
    // below statement will generate a random string of length using the characters
    // and length provided to it
    final randomString = List.generate(lengthOfString,
        (index) => allChars[random.nextInt(allChars.length)]).join();
    return randomString; // return the generated string
  }
  //

  Future uploadImageToFirebase(BuildContext context) async {
    if (kDebugMode) {
      // print('dishu');
    }
    //
    var file = File(image!.path);
    var snapshot = await FirebaseStorage.instance
        .ref()
        .child('post/images/${generateRandomString(10)}')
        .putFile(file);
    // .onComplete;
    var downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      if (kDebugMode) {
        print(downloadUrl);
      }
      communityImageUrl = downloadUrl;
      //
      // addPostInFirebase('image');
      // getTotalFollowersInThisGroup('image');
      //
      addThisPostToThisCommunity('image');
    });
  }

  //
  imageValidationBeforeAddPost() {
    if (kDebugMode) {
      print(communityImageUrl);
    }
    if (communityImageUrl == '') {
      //
      // addPostInFirebase('text');
      // getTotalFollowersInThisGroup('text');
      //
      addThisPostToThisCommunity('text');
    } else {
      //
      uploadImageToFirebase(context);
    }
    // getTotalFollowersInThisGroup();
  }

  // add this post to community
  addThisPostToThisCommunity(type) {
    //
    var setTimeStamp = DateTime.now().millisecondsSinceEpoch;
    CollectionReference users = FirebaseFirestore.instance.collection(
      // '${strFirebaseMode}community_post/${widget.getCommunityFullDetails['communityId'].toString()}/data',
      '$strFirebaseMode${FirestoreUtils.POST_FEEDS}',
    );

    users
        .add(
          {
            'postId': const Uuid().v4(),
            'title': uuid.toString(),
            'textContent': contWhatInYourMind.text.toString(),
            'postImageLink': communityImageUrl.toString(),
            'postLikesCount': '0',
            'postCommentCount': '0',
            'postShareCount': '0',
            'timeStamp': setTimeStamp,
            // post admin data
            'postEntityId': FirebaseAuth.instance.currentUser!.uid,
            'postEntityEmail': FirebaseAuth.instance.currentUser!.email,
            'postEntityName': FirebaseAuth.instance.currentUser!.displayName,
            //
            'communityId': [
              widget.getCommunityFullDetails['communityId'].toString(),
            ],
            'postAdminId': [
              FirebaseAuth.instance.currentUser!.uid,
            ],
            // 'data': widget.getCommunityFullDetails,
            'communityDetails': {
              'communityName':
                  widget.getCommunityFullDetails['communityName'].toString(),
              'communityId':
                  widget.getCommunityFullDetails['communityId'].toString(),
              'communityDocumentId':
                  widget.getCommunityFullDetails['documentId'].toString(),
              'communityImage':
                  widget.getCommunityFullDetails['communityImage'].toString(),
              //
              'communityAdminName':
                  widget.getCommunityFullDetails['adminName'].toString(),
              'communityAdminId':
                  widget.getCommunityFullDetails['adminId'].toString(),
              'communityAdminEmail':
                  widget.getCommunityFullDetails['adminEmail'].toString(),
              //
              'communityAdminProfilePicture': widget
                  .getCommunityFullDetails['adminProfilePicture']
                  .toString(),
            },
            'postCommunityType': userSelectCommunityName.toString(),
            'postType': type.toString(),
            'postActive': 'yes',
            'likes': [
              //
            ],
            /*'followers': [
                FirebaseAuth.instance.currentUser!.uid,
              ],*/
          },
        )
        .then(
          (value) =>
              //
              dismissAndBack(
            value.id.toString(),
          ),
          //
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  dismissAndBack(value) {
    //
    FirebaseFirestore.instance
        .collection(
          '$strFirebaseMode${FirestoreUtils.POST_FEEDS}',
        )
        .doc(value)
        .set(
      {
        'documentId': value,
      },
      SetOptions(merge: true),
    ).then(
      (value1) {
        // dismiss popup
        updateFeedsCount();
      },
    );
    //
  }

  /*getTotalFollowersInThisCommunity(
    getPostType,
    getTimeStamp,
  ) async {
    // printInDebugMode(getDocumentId);
    if (kDebugMode) {
      print(widget.getCommunityFullDetails['communityId'].toString());
      print(widget.getCommunityFullDetails['documentId'].toString());
    }

    //
    FirebaseFirestore.instance
        .collection(
          '${strFirebaseMode}communities/India/data',
        )
        .where(
          'documentId',
          isEqualTo: widget.getCommunityFullDetails['documentId'].toString(),
        )
        /*.where('communityId', arrayContainsAny: [
          //
          widget.getCommunityFullDetails['communityId'].toString(),
          //
        ])*/
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.docs);
      }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('======> NO USER FOUND');
        }
      } else {
        if (kDebugMode) {
          print('======> Yes, USER FOUND');
        }
        for (var element in value.docs) {
          if (kDebugMode) {
            print(element.id);
            // print(element.data()['followers']);
            // print(element.data());
          }
          //
          // add this post to EACH users inside community_post firebase id
          addDataInFollowedUsers(
            element.data()['followers'],
            getPostType,
            getTimeStamp,
          );
        }
      }
    });
  }

  addDataInFollowedUsers(
    List<dynamic> getAllUsersFirebaseId,
    type,
    getAndParseTimeStamp,
  ) {
    print('add data in all followers feed page');
    //
    var setTimeStamp = getAndParseTimeStamp;
    // printInDebugMode(getAllUsersFirebaseId as String);
    for (int i = 0; i < getAllUsersFirebaseId.length; i++) {
      //
      // create feed id everytime
      var setUUID = const Uuid().v4();
      CollectionReference users = FirebaseFirestore.instance.collection(
        '${strFirebaseMode}feeds/${getAllUsersFirebaseId[i]}/data',
      );

      users
          .add(
            {
              'postId': setUUID,
              'title': uuid.toString(),
              'textContent': contWhatInYourMind.text.toString(),
              'postImageLink': communityImageUrl.toString(),
              'postLikesCount': '0',
              'postCommentCount': '0',
              'postShareCount': '0',
              'timeStamp': setTimeStamp,
              // post admin data
              'postEntityId': FirebaseAuth.instance.currentUser!.uid,
              'postEntityEmail': FirebaseAuth.instance.currentUser!.email,
              'postEntityName': FirebaseAuth.instance.currentUser!.displayName,
              //
              'communityId': [
                widget.getCommunityFullDetails['communityId'].toString(),
              ],
              'postAdminId': [
                FirebaseAuth.instance.currentUser!.uid,
              ],
              //
              'communityDetails': {
                'communityName':
                    widget.getCommunityFullDetails['communityName'].toString(),
                'communityId':
                    widget.getCommunityFullDetails['communityId'].toString(),
                'communityDocumentId':
                    widget.getCommunityFullDetails['documentId'].toString(),
                'communityImage':
                    widget.getCommunityFullDetails['communityImage'].toString(),
                //
                'communityAdminName':
                    widget.getCommunityFullDetails['adminName'].toString(),
                'communityAdminId':
                    widget.getCommunityFullDetails['adminId'].toString(),
                'communityAdminEmail':
                    widget.getCommunityFullDetails['adminEmail'].toString(),
                //
                'communityAdminProfilePicture': widget
                    .getCommunityFullDetails['adminProfilePicture']
                    .toString(),
              },
              'postCommunityType': userSelectCommunityName.toString(),
              'postType': type.toString(),
              'postActive': 'yes',
            },
          )
          .then(
            (value) =>
                //
                Navigator.pop(context),
            //
          )
          .catchError(
            (error) => print("Failed to add user: $error"),
          );
    }
  }*/

  // add community in firebase
  addPostInFirebase(postType) {
    //
  }

  //
  /*addCommunityIdInCommunity(elementId) {
    //
    FirebaseFirestore.instance
        .collection("${strFirebaseMode}post")
        .doc('India')
        .collection('data')
        .doc(elementId)
        .set(
      {
        'documentId': elementId,
      },
      SetOptions(merge: true),
    ).then(
      (value1) {
        // dismiss popup
        updateFeedsCount();
      },
    );
  }*/

  //
  //
  getDataFromCounts() {
    //

    FirebaseFirestore.instance
        .collection(
          '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA_COUNTS}/${FirebaseAuth.instance.currentUser!.uid}/data',
        )
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.docs);
      }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('======> NO USER FOUND <========');
        }
      } else {
        if (kDebugMode) {
          print('======> Yes, USER FOUND <========');
        }
        for (var element in value.docs) {
          if (kDebugMode) {
            print(element.id);
            //
            documentIdForFeedsCount = element.id;
            totalFeeds = element.data()['feedCount'].toString();
            //
            var addOne = 0;
            // addOne += 1;
            addOne = int.parse(totalFeeds) + 1;
            totalFeeds = addOne.toString();
            // print(element.data()['followers']);
            // print(element.data());
          }
          //
        }
      }
    });
  }

  //
  updateFeedsCount() {
    //
    FirebaseFirestore.instance
        .collection(
          '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA_COUNTS}/${FirebaseAuth.instance.currentUser!.uid}/data',
        )
        .doc(documentIdForFeedsCount.toString())
        .update(
      {
        'feedCount': totalFeeds.toString(),
      },
    ).then((value) => {
              //
              Navigator.pop(context), Navigator.pop(context),
            });
  }
}
