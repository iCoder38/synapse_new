// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../common/alert/alert.dart';
import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../utils/utils.dart';

class AddEditSkillScreen extends StatefulWidget {
  const AddEditSkillScreen({
    Key? key,
    required this.getFirebaseIdAddSkill,
  }) : super(key: key);

  final String getFirebaseIdAddSkill;

  @override
  State<AddEditSkillScreen> createState() => _AddEditSkillScreenState();
}

class _AddEditSkillScreenState extends State<AddEditSkillScreen> {
  //
  late final TextEditingController contSkill;
  late final TextEditingController contProficiency;
  late final TextEditingController contDescription;
  //
  final formKey = GlobalKey<FormState>();
  //
  @override
  void initState() {
    //
    contSkill = TextEditingController();
    contProficiency = TextEditingController();
    contDescription = TextEditingController();
    //
    super.initState();
  }

  @override
  void dispose() {
    contSkill.dispose();
    contProficiency.dispose();
    contDescription.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_comforta(
          'Add Skill',
          Colors.black,
          16.0,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: contSkill,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Skill',
                  ),
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: true,
                  controller: contProficiency,
                  obscureText: false,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Proficiency',
                  ),
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onTap: () {
                    //
                    showActionSheetForProficiency(context);
                  },
                ),
              ),
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: contDescription,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    //

                    if (formKey.currentState!.validate()) {
                      //
                      addSkillInFirebase();
                    }
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                    ),
                    child: Center(
                      child: text_bold_comforta(
                        'Add Skill',
                        Colors.white,
                        16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //
  addSkillInFirebase() {
    //
    showLoadingUI(context, str_alert_please_wait);
    print('================================');
    print('==> ADDING SKILL IN FIREBASE <==');
    print('================================');
    CollectionReference users = FirebaseFirestore.instance.collection(
      '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA}/${widget.getFirebaseIdAddSkill}/skills',
    );

    users
        .add(
          {
            'skillName': contSkill.text.toString(),
            'skillDescription': contDescription.text.toString(),
            'skillProficiency': contProficiency.text.toString(),
          },
        )
        .then(
          (value) =>
              //
              FirebaseFirestore.instance
                  .collection(
                    '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA}/${widget.getFirebaseIdAddSkill}/skills',
                  )
                  .doc(value.id)
                  .set(
            {
              'documentId': value.id.toString(),
            },
            SetOptions(merge: true),
          ).then(
            (value1) {
              // dismiss popup
              Navigator.pop(context);
              Navigator.pop(context);
              // followThisGroupInFirebase(cid);
            },
          ),
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  successfullyAddedSkills() {
    Navigator.pop(context);
    //
    showAlert();
  }

  showAlert() {
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
                      'Successsfully added',
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
                          contSkill.text = '';
                          contProficiency.text = '';
                          contDescription.text = '';
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 120,
                          color: Colors.white30,
                          child: Center(
                            child: text_bold_comforta(
                              'Add more skills',
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
                          Navigator.pop(context);
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
  void showActionSheetForProficiency(BuildContext context) {
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
              contProficiency.text = 'Beginner';

              Navigator.pop(context);
            },
            child: text_regular_comforta(
              'Beginner',
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
              contProficiency.text = 'Intermediate';
              Navigator.pop(context);
            },
            child: text_regular_comforta(
              'Intermediate',
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
              contProficiency.text = 'Advanced';

              Navigator.pop(context);
            },
            child: text_regular_comforta(
              'Advanced',
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
