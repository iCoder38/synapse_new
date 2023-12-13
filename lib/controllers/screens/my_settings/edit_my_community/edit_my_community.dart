// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:synapse_new/controllers/common/app_bar/app_bar.dart';
import 'package:synapse_new/controllers/update_data_on_firebase/communities/edit/edit.dart';
import 'package:uuid/uuid.dart';

import '../../../common/alert/alert.dart';
import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../../update_data_on_firebase/counters/add_in_community/community.dart';
import '../../utils/utils.dart';

class EditMyCommunityScreen extends StatefulWidget {
  const EditMyCommunityScreen({super.key, this.getCommunityFullData});

  final getCommunityFullData;

  @override
  State<EditMyCommunityScreen> createState() => _EditMyCommunityScreenState();
}

class _EditMyCommunityScreenState extends State<EditMyCommunityScreen> {
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
  var totalCoummunitiesAfterAdd = '0';
  //
  @override
  void initState() {
    //
    if (kDebugMode) {
      print('===================================');
      print(widget.getCommunityFullData);
      print('===================================');
    }

    contCommunityName = TextEditingController(
        text: widget.getCommunityFullData['communityName'].toString());
    contCommunityAbout = TextEditingController(
        text: widget.getCommunityFullData['communityAbout'].toString());
    //
    getLoginUserData();
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
      appBar: const AppBarScreen(navigationTitle: 'edit_community'),
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
                      //
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      //
                      editCommunityFromFirebase();
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
                        'Update',
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
      // createCommunityWithFirebase(
      //   savedUUID,
      // );
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
      // createCommunityWithFirebase(setUUID);
    }
  }

  //

  // /* ******* GET LOGIN USER DATA *********************/
  // /***************************************************/
  getLoginUserData() {
    //
    FirebaseFirestore.instance
        .collection(
          '$strFirebaseMode${FirestoreUtils.USERS}/data/${FirebaseAuth.instance.currentUser!.uid}',
        )
        .get()
        .then((value) {
      // if (kDebugMode) {
      //   print(value.docs);
      // }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('======> NO USER FOUND <========');
        }
      } else {
        if (kDebugMode) {
          print('======> LOGIN USER : FULL DATA <========');
        }
        for (var element in value.docs) {
          /*if (kDebugMode) {
            print(element.id);
            print(element.data());
            print('======= COMMUNITY COUNT ==================');
            print(element.data()['countCommunity'].toString());
            print('==========================================');
            //
          }*/
          totalCoummunities = element.data()['countCommunity'].toString();
          //
          documentIdForCommunitiesCount =
              element.data()['documentId'].toString();
          // print(totalCoummunities);
          // print(documentIdForCommunitiesCount);
          //
          // add 1
          var addOne = 0;
          addOne = int.parse(totalCoummunities) + 1;
          // print(addOne);
          totalCoummunitiesAfterAdd = addOne.toString();
          //
        }
      }
    });
  }

  // from firebase method
  editCommunityFromFirebase() async {
    //
    await editCommunityDetails(
            context,
            widget.getCommunityFullData['documentId'].toString(),
            contCommunityName.text.toString(),
            contCommunityAbout.text.toString())
        .then((value) => {
              //
              Navigator.pop(context),
              // Scaffold.of(context).showSnackBar(SnackBar(Text(value)));
              //
            });
  }
}
