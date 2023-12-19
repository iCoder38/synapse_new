// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print, prefer_typing_uninitialized_variables
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:synapse_new/controllers/chat/oneToOne/one_to_one_chat.dart';
import 'package:synapse_new/controllers/screens/events/all_events/all_events.dart';
import 'package:synapse_new/controllers/screens/my_settings/my_events/my_events.dart';
// / import 'package:google_fonts/google_fonts.dart';
// import 'package:readmore/readmore.dart';

import 'package:synapse_new/controllers/screens/my_settings/my_profile/widgets/description/my_profile_description.dart';
import 'package:synapse_new/controllers/screens/my_settings/my_profile/widgets/my_profile_data/my_profile_data.dart';
import 'package:synapse_new/controllers/screens/my_settings/my_profile/widgets/my_skill_experience_education/my_skill_and_all.dart';
import 'package:synapse_new/controllers/screens/my_settings/my_profile/widgets/result/my_profile_result.dart';

import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../home_page/widget/feeds_text_image.dart';
import '../../utils/utils.dart';
// import '../add_edit_education/add_edit_education.dart';
// import '../add_edit_experience/add_experience.dart';
// import '../add_edit_skill/add_edit_skill.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({
    Key? key,
    required this.strFirebaseId,
    required this.strUsername,
    required this.strBio,
    this.strProfileImage,
  }) : super(key: key);

  // final String strMyProfile;
  final String strFirebaseId;
  final String strUsername;
  final String strBio;
  final strProfileImage;

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  //
  var strLoader = '0';
  var getAndSaveDocumentId = '';
  var strScreenLoader = '0';
  var addSkills = [];
  var strSaveDocumentId = '0';
  late final Map<String, dynamic> saveLoginUserData;
  // counts
  var strTotalCommunityCount = '0';
  var strTotalFeedsCount = '0';
  var strTotalMarks = '0';
  var strTotalAttendance = '0';
  //
  @override
  void initState() {
    if (kDebugMode) {
      print('======= USER FIREBASE ID =============');
      print(widget.strFirebaseId);
      print('=======================================');
    }
    getUserProfileData();
    super.initState();
  }

  getUserProfileData() async {
    // printInDebugMode(getDocumentId);
    if (kDebugMode) {}

    //

    FirebaseFirestore.instance
        .collection(
          // '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA_COUNTS}/${widget.strFirebaseId}/data',
          '$strFirebaseMode${FirestoreUtils.USERS}/data/${FirebaseAuth.instance.currentUser!.uid}',
        )
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
          strSaveDocumentId = element.id;
          //
          strTotalCommunityCount = element.data()['countCommunity'].toString();
          strTotalFeedsCount = element.data()['countFeed'].toString();
          strTotalMarks = element.data()['countMarks'].toString();
          strTotalAttendance = element.data()['countAttendance'].toString();
        }
        setState(() {
          strLoader = '1';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LazyLoadIndexedStack(
      index: 0,
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purpleAccent,
            title: text_bold_comforta(
              'Profile',
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
          /*floatingActionButton: FloatingActionButton(
          onPressed: () {
            //
            showActionSheet(context);
          },
          child: const Icon(
            Icons.add,
          ),
        ),*/
          body: (strLoader == '0')
              ? Center(
                  child: text_bold_comforta(
                    'please wait...',
                    Colors.black,
                    16.0,
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 180,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.purpleAccent,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                              margin: const EdgeInsets.only(top: 50.0),
                              // height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  24.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 70.0,
                                  ),
                                  text_bold_comforta(
                                    //
                                    widget.strUsername.toString(),
                                    Colors.black,
                                    24.0,
                                  ),
                                  Center(
                                    child: text_bold_comforta(
                                      'Students',
                                      Colors.grey,
                                      12.0,
                                    ),
                                  ),
                                  //
                                  const Divider(
                                    height: 1,
                                    color: Colors.transparent,
                                  ),
                                  //
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  //
                                  (widget.strFirebaseId ==
                                          FirebaseAuth
                                              .instance.currentUser!.uid)
                                      ? Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 60.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    24.0,
                                                  ),
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    //
                                                  },
                                                  icon: const Icon(
                                                    Icons.comment_bank,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //
                                            // Container(
                                            //   height: 40.0,
                                            //   width: 1.0,
                                            //   color: Colors.grey,
                                            // ),
                                            //
                                            // Expanded(
                                            //   child: Container(
                                            //     height: 60.0,
                                            //     decoration: BoxDecoration(
                                            //       color: Colors.white,
                                            //       borderRadius:
                                            //           BorderRadius.circular(
                                            //         24.0,
                                            //       ),
                                            //     ),
                                            //     child: IconButton(
                                            //       onPressed: () {
                                            //         //
                                            //       },
                                            //       icon: const Icon(
                                            //         Icons.edit,
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                            //
                                            // Container(
                                            //   height: 40.0,
                                            //   width: 1.0,
                                            //   color: Colors.grey,
                                            // ),
                                            //
                                            // Expanded(
                                            //   child: Container(
                                            //     height: 60.0,
                                            //     decoration: BoxDecoration(
                                            //       color: Colors.white,
                                            //       borderRadius:
                                            //           BorderRadius.circular(
                                            //         24.0,
                                            //       ),
                                            //     ),
                                            //     child: IconButton(
                                            //       onPressed: () {
                                            //         //
                                            //       },
                                            //       icon: const Icon(
                                            //         Icons.mail,
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                            //
                                          ],
                                        )
                                      : Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 60.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    24.0,
                                                  ),
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    //
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            OneToOneChatScreen(
                                                          getFirebaseId: widget
                                                              .strFirebaseId
                                                              .toString(),
                                                          getName: widget
                                                              .strUsername,
                                                          // getEventData: getSnapShopValue[i],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    Icons.chat,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //
                                            Container(
                                              height: 40.0,
                                              width: 1.0,
                                              color: Colors.grey,
                                            ),
                                            //
                                            Expanded(
                                              child: Container(
                                                height: 60.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    24.0,
                                                  ),
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    //
                                                  },
                                                  icon: const Icon(
                                                    Icons.call,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //
                                            Container(
                                              height: 40.0,
                                              width: 1.0,
                                              color: Colors.grey,
                                            ),
                                            //
                                            Expanded(
                                              child: Container(
                                                height: 60.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    24.0,
                                                  ),
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    //
                                                  },
                                                  icon: const Icon(
                                                    Icons.mail,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //
                                          ],
                                        ),
                                  //
                                ],
                              ),
                            ),
                          ),
                          //
                          MyProfileDescriptionScreen(
                            bio: widget.strBio,
                          ),
                          //
                          widget.strProfileImage == null
                              ? Center(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      top: 10.0,
                                    ),
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(
                                        60.0,
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      //
                                      funcOpenImage(widget.strProfileImage);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        top: 10.0,
                                      ),
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.pink,
                                        borderRadius: BorderRadius.circular(
                                          60.0,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        child: CachedNetworkImage(
                                          imageUrl: widget.strProfileImage,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator()),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          //
                        ],
                      ),
                      //
                      /*Container(
                        margin: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                        ),
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                0,
                                3,
                              ), // changes position of shadow
                            ),
                          ],
                        ),
                      ),*/
                      //
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: text_bold_roboto(
                            //
                            "${widget.strUsername}'s Career Profile",
                            Colors.black,
                            18.0,
                          ),
                        ),
                      ),
                      MySkillAndAllScreen(
                        getFirebaseIdFromUser: widget.strFirebaseId,
                        getDocumentIdFromProfile: strSaveDocumentId,
                      ),
                      //
                      const SizedBox(
                        height: 20.0,
                      ),
                      //
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: text_bold_roboto(
                            //
                            "${widget.strUsername}'s Events",
                            Colors.black,
                            18.0,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyEventsScreen(
                                getUserFirebaseId:
                                    widget.strFirebaseId.toString(),
                                // getEventData: getSnapShopValue[i],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                          ),
                          height: 100,
                          // width: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              12.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                  0,
                                  3,
                                ), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  // color: Colors.black,
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                    image: DecorationImage(
                                      image: ExactAssetImage(
                                        'assets/images/event_icon.png',
                                      ),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                //
                                // const SizedBox(
                                //   height: 6,
                                // ),
                                //
                                // text_bold_comforta(
                                //   //
                                //   '0 - Events',
                                //   Colors.black,
                                //   14.0,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: text_bold_roboto(
                            "${widget.strUsername}'s Data",
                            Colors.black,
                            18.0,
                          ),
                        ),
                      ),

                      // Communities and Feeds
                      MyProfileDataScreen(
                        getTotalCommunities: strTotalCommunityCount,
                        getTotalFeeds: strTotalFeedsCount,
                        getFirebaseId: widget.strFirebaseId,
                      ),
                      //
                      const SizedBox(
                        height: 20.0,
                      ),
                      //
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: text_bold_roboto(
                            //
                            "${widget.strUsername}'s Performance",
                            Colors.black,
                            18.0,
                          ),
                        ),
                      ),
                      MyProfileResultScreen(
                        getTotalMarks: strTotalMarks.toString(),
                        getTotalAttendance: strTotalAttendance.toString(),
                      ),
                      //
                      const SizedBox(
                        height: 40.0,
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  //
  // click to enlarge image
  funcOpenImage(imageName) {
    if (kDebugMode) {
      // print(imageName);
    }
    //
    List<String> saveClickedImage = [];
    saveClickedImage.add(imageName);

    CustomImageProvider customImageProvider = CustomImageProvider(
        //
        imageUrls: saveClickedImage.toList(),
        //
        initialIndex: 0);
    showImageViewerPager(context, customImageProvider, doubleTapZoomable: true,
        onPageChanged: (page) {
      // print("Page changed to $page");
    }, onViewerDismissed: (page) {
      // print("Dismissed while on page $page");
    });
  }
}
