import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../common/alert/alert.dart';
import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../utils/utils.dart';

class AddEditCommunityScreen extends StatefulWidget {
  const AddEditCommunityScreen({super.key});

  @override
  State<AddEditCommunityScreen> createState() => _AddEditCommunityScreenState();
}

class _AddEditCommunityScreenState extends State<AddEditCommunityScreen> {
  //
  File? imageFile;
  XFile? image;
  final ImagePicker picker = ImagePicker();
  var communityImageUrl = '';
  //
  final formKey = GlobalKey<FormState>();
  //
  var uuid = const Uuid().v4();
  late final TextEditingController contCommunityName;
  late final TextEditingController contCommunityAbout;
  //
  var documentIdForCommunitiesCount = '0';
  var totalCoummunities = '0';
  //
  @override
  void initState() {
    //
    contCommunityName = TextEditingController();
    contCommunityAbout = TextEditingController();
    //
    getDataFromCounts();
    super.initState();
  }

  @override
  void dispose() {
    contCommunityName.dispose();
    contCommunityAbout.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: text_bold_roboto(
          //
          'Add Community'.toString(),
          Colors.white,
          20.0,
        ),
        // backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              //
              GestureDetector(
                onTap: () {
                  //
                  pickImage();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                    ),
                    child: image == null
                        ? const Center(
                            child: Icon(
                              Icons.camera_alt,
                              size: 64,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(
                              12.0,
                            ),
                            child: Image.file(
                              File(image!.path),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                            ),
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: contCommunityName,
                  obscureText: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Community Name',
                      hintText: 'community name...'),
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
                  controller: contCommunityAbout,
                  obscureText: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Community About',
                      hintText: 'community about...'),
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
                child: GestureDetector(
                  onTap: () {
                    //
                    if (formKey.currentState!.validate()) {
                      //
                      showLoadingUI(context, 'please wait...');
                      imageValidationCheckBeforeUpload();
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
                        'Add Community',
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
  Future<void> pickImage() async {
    var img = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = img;
      //
      communityImageUrl = 'yes';
    });
    //
  }

  // Future<bool> checkIfCommunityAlreadyExist(String communityId) async {
  //   return await ref
  //       .watch(communityControllerProvider)
  //       .checkIfCommunityAlreadyExist(communityId);
  // }

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

  Future uploadImageToFirebase(BuildContext context, savedUUID) async {
    if (kDebugMode) {
      print('dishu');
    }
    //
    // var generateRandomNumber = generateRandomString(10);
    var file = File(image!.path);
    var snapshot = await FirebaseStorage.instance
        .ref()
        // .child('communities/images/${generateRandomString(10)}')
        .child(
            '$FIREBASE_STORAGE_COMMUNITY_URL/$savedUUID/content/display_image')
        //
        .putFile(file);
    // .onComplete;
    var downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      if (kDebugMode) {
        print(downloadUrl);
      }
      communityImageUrl = downloadUrl;
      //
      createCommunityWithFirebase(
        savedUUID,
      );
    });
  }

  imageValidationCheckBeforeUpload() {
    //
    var setUUID = uuid.toString();
    //
    if (kDebugMode) {
      print(communityImageUrl);
    }
    if (communityImageUrl == 'yes') {
      //
      uploadImageToFirebase(context, setUUID);
    } else {
      //
      createCommunityWithFirebase(setUUID);
    }
  }

  // add community in firebase
  createCommunityWithFirebase(setUUID) {
    //
    if (kDebugMode) {
      print('=======================');
      print('adding community');
      print('=======================');
    }

    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}communities/India/data',
    );

    users
        .add(
          {
            'communityImage': communityImageUrl.toString(),
            'communityId': setUUID.toString(),
            'communityName': contCommunityName.text.toString(),
            'communityAbout': contCommunityAbout.text.toString(),
            'followersCount': '0',
            'likesCount': '0',
            'timeStamp': DateTime.now().millisecondsSinceEpoch,
            'followers': [
              // FirebaseAuth.instance.currentUser!.uid,
            ],
            'adminId': FirebaseAuth.instance.currentUser!.uid,
            'adminName': FirebaseAuth.instance.currentUser!.displayName,
            'adminEmail': FirebaseAuth.instance.currentUser!.email,
            'adminProfilePicture': ''.toString(),
            'communityAdminId': [
              FirebaseAuth.instance.currentUser!.uid,
            ],
            'communityType': 'community'
          },
        )
        // COMMUNITY<%>'PERSONAL-FIREBASEID'
        // COMMUNITY<%>'COMMUNITY-NAME'
        .then(
          (value) =>
              //
              addCommunityIdInCommunity(
            value.id,
            setUUID.toString(),
          ),
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  //
  addCommunityIdInCommunity(elementId, cid) {
    //
    if (kDebugMode) {
      print('=======================');
      print('add community id in id');
      print(elementId);
      print('=======================');
    }

    FirebaseFirestore.instance
        .collection("${strFirebaseMode}communities")
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
        // followThisGroupInFirebase(cid);
        updateCommunitiesCount();
      },
    );
  }

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
            documentIdForCommunitiesCount = element.id;
            totalCoummunities = element.data()['communityCount'].toString();
            //
            var addOne = 0;
            addOne = int.parse(totalCoummunities) + 1;
            totalCoummunities = addOne.toString();
          }
          //
        }
      }
    });
  }

  //
  updateCommunitiesCount() {
    //
    if (kDebugMode) {
      print('=======================');
      print('UPDATE COMMUNITY COUNT');
      print(FirebaseAuth.instance.currentUser!.uid);
      print('=======================');
    }
    //
    // setProfileDataForNewOrFirstTimeUserAfterLogin();
    updateUserCountNew();
  }

  //
  //
  setProfileDataForNewOrFirstTimeUserAfterLogin() async {
    if (kDebugMode) {
      print('vedica');
      // print(FirestoreUtils.LOGIN_USER_FIREBASE_ID);
    }

    //
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
          print('======> LOGIN USER COUNT DATA NOT FOUND <========');
        }
        CollectionReference users = FirebaseFirestore.instance.collection(
          '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA_COUNTS}/${FirebaseAuth.instance.currentUser!.uid}/data',
        );

        users
            .add(
              {
                'skillCount': '0',
                'experienceCount': '0',
                'educationCount': '0',
                'communityCount': '0',
                'feedCount': '0',
                'marks': '0',
                'attendance': '0',
              },
            )
            .then(
              (value) =>
                  //
                  addDocumentIdForNewId(
                value.id,
              ),
            )
            .catchError(
              (error) => print("Failed to add user: $error"),
            );
      } else {
        if (kDebugMode) {
          print('======> LOGIN USER COUNT DATA FOUND <========');
        }
        for (var element in value.docs) {
          if (kDebugMode) {
            print(element.id);
          }
          //
          updateUserCount(
              element.id, element.data()['communityCount'].toString());
          //
        }
      }
    });
  }

  addDocumentIdForNewId(elementId) {
    //
    if (kDebugMode) {
      print('============================');
      print('add document id in new user');
      print('============================');
    }

    FirebaseFirestore.instance
        .collection(
          '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA_COUNTS}/${FirebaseAuth.instance.currentUser!.uid}/data',
        )
        .doc(elementId)
        .set(
      {
        'documentId': elementId,
      },
      SetOptions(merge: true),
    ).then(
      (value1) {
        //
        updateUserCount(elementId, '0');
      },
    );
  }

  //
  updateUserCount(getDocumentId, communityCount) {
    if (kDebugMode) {
      print('============================');
      print('UPDATE USER COUNTS IN COMMUNITY');
      print('============================');
    }
    int addOne;
    addOne = int.parse(communityCount) + 1;
    //
    if (kDebugMode) {
      print('============ ADD ONE =========');
      print(addOne);
      print(getDocumentId);
      print('==============================');
    }

    //
    FirebaseFirestore.instance
        .collection(
          '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA_COUNTS}/${FirebaseAuth.instance.currentUser!.uid}/data',
        )
        .doc(getDocumentId.toString())
        .update(
      {
        'communityCount': addOne.toString(),
      },
    ).then((value) => {
              //
              Navigator.pop(context), Navigator.pop(context),
            });
  }

  //
  updateUserCountNew() {
    //
    FirebaseFirestore.instance
        .collection(
          '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA_COUNTS}/${FirebaseAuth.instance.currentUser!.uid}/data',
        )
        .doc(documentIdForCommunitiesCount.toString())
        .update(
      {
        'communityCount': totalCoummunities.toString(),
      },
    ).then((value) => {
              //
              Navigator.pop(context), Navigator.pop(context),
            });
  }
  //
}
