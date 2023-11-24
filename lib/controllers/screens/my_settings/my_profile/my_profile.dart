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
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  //
  var getAndSaveDocumentId = '';
  var strScreenLoader = '0';
  var addSkills = [];
  late final Map<String, dynamic> saveLoginUserData;
  //
  @override
  void initState() {
    // getLoginUserData();
    super.initState();
  }

  getLoginUserData() {
    //
    FirebaseFirestore.instance
        .collection('$strFirebaseMode${FirestoreUtils.USERS_COLLECTION}')
        .where(
          'firebaseId',
          isEqualTo: FirestoreUtils.LOGIN_USER_FIREBASE_ID.toString(),
        )
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.docs);
      }

      if (value.docs.isEmpty) {
        print('======> NO USER FOUND');
      } else {
        print('===================================================');
        print('==> Yes, USER FOUND <==');

        for (var element in value.docs) {
          if (kDebugMode) {
            print(element.id);
            print(element.data());
            print(element.data().runtimeType);
          }
          // printInDebugMode('=================================================');
          //
          saveLoginUserData = element.data();
          print('=================================================');
          // print(saveLoginUserData);
          print('=================================================');
          //
          addSkills = saveLoginUserData['skills'];
          // addSkills.add(element.data());
          if (kDebugMode) {
            print(addSkills);
            print(addSkills.length);
          }
        }
        //
        setState(() {
          strScreenLoader = '1';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('$strFirebaseMode${FirestoreUtils.USERS_COLLECTION}')
            // .orderBy('timeStamp', descending: true)
            .where(
              'firebaseId',
              isEqualTo: FirestoreUtils.LOGIN_USER_FIREBASE_ID.toString(),
            )
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            //
            var getSnapShopValue = snapshot.data!.docs.toList();
            getAndSaveDocumentId = getSnapShopValue[0]['documentId'].toString();
            if (kDebugMode) {
              print('================================');
              print(getAndSaveDocumentId);

              // printInDebugMode('======= LOGIN USER DATA =======');
              // print(getSnapShopValue[0]['skills'][0]['skillName']);
              // print(getSnapShopValue[0]['skills'].length);
              print('================================');
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.purpleAccent,
                title: text_bold_comforta(
                  'Profile',
                  Colors.white,
                  16.0,
                ),
                /*bottom: TabBar(
                  isScrollable: true,
                  tabs: [
                    text_bold_comforta('About', Colors.white, 14.0),
                    text_bold_comforta(
                        'Skills (${getSnapShopValue[0]['skills'].length})',
                        Colors.white,
                        14.0),
                    text_bold_comforta(
                        'Experience (${getSnapShopValue[0]['workExperience'].length})',
                        Colors.white,
                        14.0),
                    text_bold_comforta(
                        'Education (${getSnapShopValue[0]['education'].length})',
                        Colors.white,
                        14.0),
                    // text_bold_comforta('Feeds', Colors.white, 14.0),
                  ],
                ),*/
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
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  //
                  showActionSheet(context);
                },
                child: const Icon(
                  Icons.add,
                ),
              ),
              body: SingleChildScrollView(
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
                                    'Student',
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
                          'My Profile',
                          Colors.black,
                          18.0,
                        ),
                      ),
                    ),
                    const MySkillAndAllScreen(),
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

                    //
                    const MyProfileDataScreen(),
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
                    const MyProfileResultScreen(),
                  ],
                ),
              ),
              /*TabBarView(
                  // controller: _tabController,
                  children: [
                    Column(
                      children: [
                        //
                        
                        //
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 180,
                            width: 180,
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
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                        ),
                        //
                        const SizedBox(
                          height: 20.0,
                        ),
                        //
                        text_bold_comforta(
                          //
                          FirestoreUtils.LOGIN_USER_NAME,
                          Colors.black,
                          18.0,
                        ),
                        //
                        text_regular_roboto(
                          //
                          FirestoreUtils.LOGIN_USER_EMAIL,
                          Colors.grey,
                          12.0,
                        ),
                        //
                      ],
                    ),
                    // tab 2
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          //
                          for (int i = 0;
                              i < getSnapShopValue[0]['skills'].length;
                              i++) ...[
                            ListTile(
                              title: text_bold_comforta(
                                //
                                getSnapShopValue[0]['skills'][i]['skillName']
                                    .toString(),
                                Colors.black,
                                16.0,
                              ),
                              subtitle: text_regular_comforta(
                                //
                                getSnapShopValue[0]['skills'][i]
                                        ['skillProficiency']
                                    .toString(),
                                Colors.black,
                                12.0,
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  //
                                  if (kDebugMode) {
                                    print('==> delete skill  <==');
                                  }
                                  //
                                  showAlert(
                                    getSnapShopValue[0],
                                    i,
                                  );
                                },
                                child: Container(
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(
                                      12.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: text_regular_comforta(
                                      'delete',
                                      Colors.white,
                                      14.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                              height: 2.0,
                            ),
                          ]
                        ],
                      ),
                    ),
                    // tab 3
                    Column(
                      children: [
                        //
                        for (int i = 0;
                            i < getSnapShopValue[0]['workExperience'].length;
                            i++) ...[
                          ListTile(
                            title: text_bold_comforta(
                              //
                              getSnapShopValue[0]['workExperience'][i]
                                      ['title']
                                  .toString(),
                              Colors.black,
                              16.0,
                            ),
                            subtitle: text_regular_comforta(
                              //
                              getSnapShopValue[0]['workExperience'][i]
                                      ['employmentType']
                                  .toString(),
                              Colors.black,
                              12.0,
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                //
                                if (kDebugMode) {
                                  print('==> delete <==');
                                }
                                //
                                showExperienceAlert(
                                  getSnapShopValue[0],
                                  i,
                                );
                              },
                              child: Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(
                                    12.0,
                                  ),
                                ),
                                child: Center(
                                  child: text_regular_comforta(
                                    'delete',
                                    Colors.white,
                                    14.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.black,
                            height: 2.0,
                          ),
                        ]
                      ],
                    ),
                    // tab 4
                    Column(
                      children: [
                        //
                        for (int i = 0;
                            i < getSnapShopValue[0]['education'].length;
                            i++) ...[
                          ListTile(
                            title: text_bold_comforta(
                              //
                              getSnapShopValue[0]['education'][i]
                                      ['schoolName']
                                  .toString(),
                              Colors.black,
                              16.0,
                            ),
                            subtitle: text_regular_comforta(
                              //
                              'Domain : ${getSnapShopValue[0]['education'][i]['domainOfStudy']}',
                              Colors.black,
                              12.0,
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                //
                                if (kDebugMode) {
                                  print('==> delete <==');
                                }
                                //
                                showEducationAlert(
                                  getSnapShopValue[0],
                                  i,
                                );
                              },
                              child: Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(
                                    12.0,
                                  ),
                                ),
                                child: Center(
                                  child: text_regular_comforta(
                                    'delete',
                                    Colors.white,
                                    14.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.black,
                            height: 2.0,
                          ),
                        ]
                      ],
                    ),
                    // tab 5
                    /*Column(
                          children: [
                            //
                            ListTile(
                              title: text_bold_comforta(
                                'Experience 1',
                                Colors.black,
                                16.0,
                              ),
                              subtitle: text_regular_comforta(
                                'str',
                                Colors.black,
                                14.0,
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                              height: 2.0,
                            ),
                          ],
                        ),*/
                  ],
                ),*/
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
            child: CircularProgressIndicator(
              color: Colors.pink,
            ),
          );
        });
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
                  builder: (context) => const AddEditSkillScreen(),
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
