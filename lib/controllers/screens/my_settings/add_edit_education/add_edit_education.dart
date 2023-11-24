// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../common/alert/alert.dart';
import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../utils/utils.dart';

class AddEditEducationScreen extends StatefulWidget {
  const AddEditEducationScreen({
    Key? key,
    required this.strGetFirebaseIdForAddEducation,
  }) : super(key: key);

  final String strGetFirebaseIdForAddEducation;

  @override
  State<AddEditEducationScreen> createState() => _AddEditEducationScreenState();
}

class _AddEditEducationScreenState extends State<AddEditEducationScreen> {
  //
  late final TextEditingController contSchool;
  late final TextEditingController contDegree;
  late final TextEditingController contDomainOfStudy;
  late final TextEditingController contDescription;
  late final TextEditingController contStartDate;
  late final TextEditingController contEndDate;
  //
  final formKey = GlobalKey<FormState>();
  //
  @override
  void initState() {
    //
    contSchool = TextEditingController();
    contDegree = TextEditingController();
    contDomainOfStudy = TextEditingController();
    contDescription = TextEditingController();
    contStartDate = TextEditingController();
    contEndDate = TextEditingController();
    //
    super.initState();
  }

  @override
  void dispose() {
    contSchool.dispose();
    contDegree.dispose();
    contDomainOfStudy.dispose();
    contDescription.dispose();
    contStartDate.dispose();
    contEndDate.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_comforta(
          'Add Education',
          Colors.white,
          22.0,
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  // readOnly: true,
                  controller: contSchool,
                  obscureText: false,
                  decoration: const InputDecoration(
                    // suffixIcon: Icon(
                    //   Icons.arrow_drop_down,
                    // ),
                    border: OutlineInputBorder(),

                    hintText: 'Ex. Osmania University',
                    labelText: 'School',
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
                    // showActionSheetForProficiency(context);
                  },
                ),
              ),
              //
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  // readOnly: true,
                  controller: contDegree,
                  obscureText: false,
                  decoration: const InputDecoration(
                    // suffixIcon: Icon(
                    //   Icons.arrow_drop_down,
                    // ),
                    border: OutlineInputBorder(),
                    hintText: 'Ex. Bachelor of technology',
                    labelText: 'Degree',
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
                    // showActionSheetForProficiency(context);
                  },
                ),
              ),
              //
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  // readOnly: true,
                  controller: contDomainOfStudy,
                  obscureText: false,
                  decoration: const InputDecoration(
                    // suffixIcon: Icon(
                    //   Icons.arrow_drop_down,
                    // ),
                    border: OutlineInputBorder(),
                    labelText: 'Domain if Study',
                    hintText: 'Ex. Business',
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
                    // showActionSheetForProficiency(context);
                  },
                ),
              ),
              //
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  // readOnly: true,
                  controller: contDescription,
                  obscureText: false,
                  decoration: const InputDecoration(
                    // suffixIcon: Icon(
                    //   Icons.arrow_drop_down,
                    // ),
                    border: OutlineInputBorder(),
                    labelText: 'Description',
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
                    // showActionSheetForProficiency(context);
                  },
                ),
              ),
              //
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  readOnly: true,
                  controller: contStartDate,
                  obscureText: false,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.calendar_month,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Start Date',
                  ),
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onTap: () async {
                    DateTime? startPickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now());
                    if (startPickedDate != null) {
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(startPickedDate);
                      setState(() {
                        contStartDate.text = formattedDate;
                      });
                    }
                  },
                ),
              ),
              //
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  readOnly: true,
                  controller: contEndDate,
                  obscureText: false,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.calendar_month,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'End date',
                  ),
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onTap: () async {
                    DateTime? startPickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now());
                    if (startPickedDate != null) {
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(startPickedDate);
                      setState(() {
                        contEndDate.text = formattedDate;
                      });
                    }
                  },
                ),
              ),
              //
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    //
                    if (formKey.currentState!.validate()) {
                      //
                      addEducationInFirebase();
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
                        'Add Education',
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
  addEducationInFirebase() {
    //
    showLoadingUI(context, str_alert_please_wait);
    print('================================');
    print('==> ADDING EDUCATION IN FIREBASE <==');
    print('================================');
    CollectionReference users = FirebaseFirestore.instance.collection(
      '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA}/${widget.strGetFirebaseIdForAddEducation}/educations',
    );

    users
        .add(
          {
            // 'educationId': const Uuid().toString(),
            'schoolName': contSchool.text.toString(),
            'degree': contDegree.text.toString(),
            'domainOfStudy': contDomainOfStudy.text.toString(),
            'description': contDescription.text.toString(),
            'timeStamp': DateTime.now().millisecondsSinceEpoch,
            'endDate': contEndDate.text.toString(),
            'startDate': contStartDate.text.toString(),
            // 'active': 'yes',
          },
        )
        .then(
          (value) =>
              //
              FirebaseFirestore.instance
                  .collection(
                    '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA}/${widget.strGetFirebaseIdForAddEducation}/educations',
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
    /*FirebaseFirestore.instance
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
        print('======> Yes, USER FOUND');
        for (var element in value.docs) {
          if (kDebugMode) {
            print(element.id);
          }
          // add skills
          FirebaseFirestore.instance
              .collection(
                '$strFirebaseMode${FirestoreUtils.USERS_COLLECTION}',
              )
              .doc(element.id)
              .update(
            {
              'education': FieldValue.arrayUnion(
                [
                  {
                    'educationId': const Uuid().toString(),
                    'schoolName': contSchool.text.toString(),
                    'degree': contDegree.text.toString(),
                    'domainOfStudy': contDomainOfStudy.text.toString(),
                    'description': contDescription.text.toString(),
                    'timeStamp': DateTime.now().millisecondsSinceEpoch,
                    'endDate': contEndDate.text.toString(),
                    'startDate': contStartDate.text.toString(),
                    'active': 'yes',
                  }
                ],
              ),
            },
          ).then(
            (value) => {
              //
              successfullyAddedExperience(),
            },
          );
        }
      }
    });*/
  }

  successfullyAddedExperience() {
    Navigator.pop(context);
    Navigator.pop(context);
    //
  }
}
