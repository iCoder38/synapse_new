// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import 'package:synapse_new/controllers/screens/my_settings/my_profile/widgets/description/my_profile_description.dart';
import 'package:synapse_new/controllers/screens/my_settings/my_profile/widgets/my_profile_data/my_profile_data.dart';
import 'package:synapse_new/controllers/screens/my_settings/my_profile/widgets/my_skill_experience_education/my_skill_and_all.dart';
import 'package:synapse_new/controllers/screens/my_settings/my_profile/widgets/result/my_profile_result.dart';

import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../utils/utils.dart';
import '../add_edit_education/add_edit_education.dart';
import '../add_edit_experience/add_experience.dart';
import '../add_edit_skill/add_edit_skill.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({
    Key? key,
    // required this.strMyProfile,
    required this.strFirebaseId,
  }) : super(key: key);

  // final String strMyProfile;
  final String strFirebaseId;

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
          '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA_COUNTS}/${FirestoreUtils.LOGIN_USER_FIREBASE_ID}/data',
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
          strTotalCommunityCount = element.data()['communityCount'].toString();
          strTotalFeedsCount = element.data()['feedCount'].toString();
          strTotalMarks = element.data()['marks'].toString();
          strTotalAttendance = element.data()['attendance'].toString();
        }
        setState(() {
          strLoader = '1';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                FirestoreUtils.LOGIN_USER_NAME,
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
                              Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 60.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          24.0,
                                        ),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          //
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
                                        borderRadius: BorderRadius.circular(
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
                                        borderRadius: BorderRadius.circular(
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
                      const MyProfileDescriptionScreen(),
                      //
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(
                              60.0,
                            ),
                          ),
                        ),
                      ),
                      //
                    ],
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: text_bold_roboto(
                        'Career profile',
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
                        'Data',
                        Colors.black,
                        18.0,
                      ),
                    ),
                  ),

                  // Communities and Feeds
                  MyProfileDataScreen(
                    getTotalCommunities: strTotalCommunityCount,
                    getTotalFeeds: strTotalFeedsCount,
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
                        'Performance',
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
    );
  }

  deleteSkillFromList(
    skillId,
    clickedData,
    allSkillsArray,
  ) {
    var newArr = [];
    newArr = allSkillsArray;
    // var index = 0;
    for (int i = 0; i < newArr.length; i++) {
      //
      if (clickedData['skillId'].toString() ==
          newArr[i]['skillId'].toString()) {
        // index = i;
        //
        // remove
        FirebaseFirestore.instance
            .collection(
              '$strFirebaseMode${FirestoreUtils.USERS_COLLECTION}',
            )
            .doc(getAndSaveDocumentId)
            .update(
          {
            'skills': FieldValue.arrayRemove([newArr[i]]),
          },
        ).then(
          (value) => {
            //
          },
        );
        //
      }
      //
    }
    // if (kDebugMode) {
    //   printInDebugMode('===== TOTAL ======');
    //   print(newArr);
    //   printInDebugMode('===== REMOVED INDEX ======');
    //   print(newArr.removeAt(index));
    //   printInDebugMode('===== AFTER REMOVE ======');
    //   print(newArr);
    // }
  }

  deleteEducationFromList(
    skillId,
    clickedData,
    allSkillsArray,
  ) {
    print('delete experience');
    var newArr = [];
    newArr = allSkillsArray;
    // var index = 0;
    for (int i = 0; i < newArr.length; i++) {
      //
      if (clickedData['educationId'].toString() ==
          newArr[i]['educationId'].toString()) {
        // index = i;
        //
        // remove
        FirebaseFirestore.instance
            .collection(
              '$strFirebaseMode${FirestoreUtils.USERS_COLLECTION}',
            )
            .doc(getAndSaveDocumentId)
            .update(
          {
            'education': FieldValue.arrayRemove([newArr[i]]),
          },
        ).then(
          (value) => {
            //
          },
        );
        //
      }
      //
    }
  }

  showEducationAlert(
    getSnapAllValue,
    i,
  ) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Flexible(
                  child: SingleChildScrollView(
                    child: text_bold_roboto(
                      //
                      'Delete this education ?',
                      //
                      Colors.black,
                      22.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //
                          deleteEducationFromList(
                              getSnapAllValue['education'][i]['educationId']
                                  .toString(),
                              getSnapAllValue['education'][i],
                              getSnapAllValue['education']);
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 120,
                          color: Colors.white30,
                          child: Center(
                            child: text_bold_comforta(
                              'Yes, Delete',
                              Colors.pinkAccent,
                              14.0,
                            ),
                          ),
                        ),
                      ),
                      //
                      GestureDetector(
                        onTap: () {
                          //
                          Navigator.pop(context);
                          // Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 80,
                          color: Colors.white30,
                          child: Center(
                            child: text_bold_comforta(
                              'Dismiss',
                              Colors.redAccent,
                              14.0,
                            ),
                          ),
                        ),
                      ),
                      //
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  deleteExperienceFromList(
    skillId,
    clickedData,
    allSkillsArray,
  ) {
    print('delete experience');
    var newArr = [];
    newArr = allSkillsArray;
    // var index = 0;
    for (int i = 0; i < newArr.length; i++) {
      //
      if (clickedData['experienceId'].toString() ==
          newArr[i]['experienceId'].toString()) {
        // index = i;
        //
        // remove
        FirebaseFirestore.instance
            .collection(
              '$strFirebaseMode${FirestoreUtils.USERS_COLLECTION}',
            )
            .doc(getAndSaveDocumentId)
            .update(
          {
            'workExperience': FieldValue.arrayRemove([newArr[i]]),
          },
        ).then(
          (value) => {
            //
          },
        );
        //
      }
      //
    }
  }

  showExperienceAlert(
    getSnapAllValue,
    i,
  ) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Flexible(
                  child: SingleChildScrollView(
                    child: text_bold_roboto(
                      //
                      'Delete this experience ?',
                      //
                      Colors.black,
                      22.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //
                          deleteExperienceFromList(
                              getSnapAllValue['workExperience'][i]
                                      ['experienceId']
                                  .toString(),
                              getSnapAllValue['workExperience'][i],
                              getSnapAllValue['workExperience']);
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 120,
                          color: Colors.white30,
                          child: Center(
                            child: text_bold_comforta(
                              'Yes, Delete',
                              Colors.pinkAccent,
                              14.0,
                            ),
                          ),
                        ),
                      ),
                      //
                      GestureDetector(
                        onTap: () {
                          //
                          Navigator.pop(context);
                          // Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 80,
                          color: Colors.white30,
                          child: Center(
                            child: text_bold_comforta(
                              'Dismiss',
                              Colors.redAccent,
                              14.0,
                            ),
                          ),
                        ),
                      ),
                      //
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showAlert(
    getSnapAllValue,
    i,
  ) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Flexible(
                  child: SingleChildScrollView(
                    child: text_bold_roboto(
                      //
                      'Delete this skill',
                      //
                      Colors.black,
                      22.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //
                          deleteSkillFromList(
                              getSnapAllValue['skills'][i]['skillId']
                                  .toString(),
                              getSnapAllValue['skills'][i],
                              getSnapAllValue['skills']);
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 120,
                          color: Colors.white30,
                          child: Center(
                            child: text_bold_comforta(
                              'Delete ?',
                              Colors.pinkAccent,
                              14.0,
                            ),
                          ),
                        ),
                      ),
                      //
                      GestureDetector(
                        onTap: () {
                          //
                          Navigator.pop(context);
                          // Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 80,
                          color: Colors.white30,
                          child: Center(
                            child: text_bold_comforta(
                              'Dismiss',
                              Colors.redAccent,
                              14.0,
                            ),
                          ),
                        ),
                      ),
                      //
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //
  void showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: text_bold_comforta(
          'Please select an option',
          Colors.black,
          16.0,
        ),
        // message: const Text('Message'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            /// This parameter indicates the action would be a default
            /// default behavior, turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditSkillScreen(
                    getFirebaseIdAddSkill: widget.strFirebaseId,
                  ),
                ),
              );
            },
            child: text_regular_comforta(
              'Add Skill',
              Colors.black,
              12.0,
            ),
          ),
          //
          CupertinoActionSheetAction(
            /// This parameter indicates the action would be a default
            /// default behavior, turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddEditExperienceScreen(),
                ),
              );
            },
            child: text_regular_comforta(
              'Add Experience',
              Colors.black,
              12.0,
            ),
          ),
          //
          CupertinoActionSheetAction(
            /// This parameter indicates the action would be a default
            /// default behavior, turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddEditEducationScreen(),
                ),
              );
            },
            child: text_regular_comforta(
              'Add Education',
              Colors.black,
              12.0,
            ),
          ),
          //
          CupertinoActionSheetAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as delete or exit and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Dismiss'),
          ),
        ],
      ),
    );
  }
  //
}
