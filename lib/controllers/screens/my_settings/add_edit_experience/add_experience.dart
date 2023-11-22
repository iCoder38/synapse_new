import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../common/alert/alert.dart';
import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../utils/utils.dart';

class AddEditExperienceScreen extends StatefulWidget {
  const AddEditExperienceScreen({super.key});

  @override
  State<AddEditExperienceScreen> createState() =>
      _AddEditExperienceScreenState();
}

class _AddEditExperienceScreenState extends State<AddEditExperienceScreen> {
  //
  late final TextEditingController contCompanyName;
  late final TextEditingController contTitle;
  late final TextEditingController contEmploymentType;
  late final TextEditingController contDescription;
  late final TextEditingController contStartDate;
  late final TextEditingController contEndDate;
  //
  final formKey = GlobalKey<FormState>();
  //
  @override
  void initState() {
    //
    contCompanyName = TextEditingController();
    contTitle = TextEditingController();
    contEmploymentType = TextEditingController();
    contDescription = TextEditingController();
    contStartDate = TextEditingController();
    contEndDate = TextEditingController();
    //
    super.initState();
  }

  @override
  void dispose() {
    contCompanyName.dispose();
    contTitle.dispose();
    contEmploymentType.dispose();
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
          'Add Experience',
          Colors.white,
          18.0,
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
                  controller: contCompanyName,
                  obscureText: false,
                  decoration: const InputDecoration(
                    // suffixIcon: Icon(
                    //   Icons.arrow_drop_down,
                    // ),
                    border: OutlineInputBorder(),
                    labelText: 'Company',
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
                  controller: contTitle,
                  obscureText: false,
                  decoration: const InputDecoration(
                    // suffixIcon: Icon(
                    //   Icons.arrow_drop_down,
                    // ),
                    border: OutlineInputBorder(),
                    labelText: 'Title',
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
                  controller: contEmploymentType,
                  obscureText: false,
                  decoration: const InputDecoration(
                    // suffixIcon: Icon(
                    //   Icons.arrow_drop_down,
                    // ),
                    border: OutlineInputBorder(),
                    labelText: 'Employment type',
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
                      addExperiencenFirebase();
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
                        'Add Experience',
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
  addExperiencenFirebase() {
    //
    showLoadingUI(context, str_alert_please_wait);
    print('================================');
    print('==> ADDING SKILL IN FIREBASE <==');
    print('================================');
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
              'workExperience': FieldValue.arrayUnion(
                [
                  {
                    'experienceId': const Uuid().toString(),
                    'companyName': contCompanyName.text.toString(),
                    'title': contTitle.text.toString(),
                    'employmentType': contEmploymentType.text.toString(),
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
    });
  }

  successfullyAddedExperience() {
    Navigator.pop(context);
    Navigator.pop(context);
    //
  }
}
