// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:synapse_new/controllers/common/alert/alert.dart';

import '../../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../../utils/utils.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({
    Key? key,
    required this.getProfilePicture,
    required this.getUserBio,
    required this.getDocumentId,
  }) : super(key: key);

  final String getProfilePicture;
  final String getUserBio;
  final String getDocumentId;

  @override
  State<PersonalInformationScreen> createState() =>
      PersonalInformationScreenState();
}

class PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final formKey = GlobalKey<FormState>();
  //
  final ImagePicker picker = ImagePicker();
  XFile? image;
  //
  late final TextEditingController contUserName;
  late final TextEditingController contUserBio;
  //
  @override
  void initState() {
    //
    contUserName = TextEditingController(
        text: FirebaseAuth.instance.currentUser!.displayName);
    contUserBio = TextEditingController(
      text: widget.getUserBio,
    );
    super.initState();
  }

  @override
  void dispose() {
    contUserName.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0),
        title: text_bold_comforta(
          //
          'Personal Information',
          Colors.white,
          16.0,
        ),
        leading: IconButton(
          onPressed: () {
            //
            Navigator.pop(context, 'from_personal_information');
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              //
              FocusManager.instance.primaryFocus?.unfocus();
              showLoadingUI(context, 'updating...');
              updateName(
                contUserName.text.toString(),
              );
            },
            child: Center(
              child: SizedBox(
                // height: 20,
                width: 60,
                child: text_bold_comforta(
                  'save',
                  Colors.white,
                  14.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Center(
                child: GestureDetector(
              onTap: () {
                //
                pickImage();
              },
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(
                    60.0,
                  ),
                ),
                child: image == null
                    ? (widget.getProfilePicture != '')
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(24.0),
                            child: CachedNetworkImage(
                              imageUrl: widget.getProfilePicture,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const SizedBox(
                                height: 40,
                                width: 40,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          )
                        : const Center(
                            child: Icon(
                              Icons.camera_alt,
                              size: 64,
                            ),
                          )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(
                          60.0,
                        ),
                        child: Image.file(
                          File(image!.path),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                        ),
                      ),
              ),
            )),
            //
            const SizedBox(
              height: 80.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //
                  Row(
                    children: [
                      text_bold_comforta(
                        'Name',
                        Colors.black,
                        18.0,
                      ),
                    ],
                  ),
                  TextField(
                    controller: contUserName,
                    decoration: const InputDecoration(
                      // border: InputBorder.none,
                      // enabledBorder: UnderlineInputBorder(
                      // borderSide: BorderSide(color: Colors.cyan),
                      // ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: 'name...',
                      // labelText: FirebaseAuth.instance.currentUser!.displayName,
                    ),
                  ),
                  //
                  const SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    children: [
                      text_bold_comforta(
                        'Bio',
                        Colors.black,
                        18.0,
                      ),
                    ],
                  ),
                  TextField(
                    controller: contUserBio,
                    decoration: const InputDecoration(
                      // border: InputBorder.none,
                      // enabledBorder: UnderlineInputBorder(
                      // borderSide: BorderSide(color: Colors.cyan),
                      // ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: 'bio...',
                      // labelText: FirebaseAuth.instance.currentUser!.displayName,
                    ),
                    maxLines: 3,
                  ),

                  // const Divider(
                  //   color: Colors.black,
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

// update profile image
  Future<void> pickImage() async {
    var img = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = img;
    });
    //
    showLoadingUI(context, 'uploading...');
    //

    uploadImageToFirebase(context);
  }

  Future uploadImageToFirebase(BuildContext context) async {
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
          '$FIREBASE_STORAGE_ALL_PROFILE_PICTURES${FirebaseAuth.instance.currentUser!.uid}/content/display_image',
        )
        //
        .putFile(file);
    // .onComplete;
    var downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      if (kDebugMode) {
        print(downloadUrl);
      }
      //
      updateImage(downloadUrl);
    });
  }

  updateImage(urlIs) {
    //

    FirebaseFirestore.instance
        .collection(
          '$strFirebaseMode${FirestoreUtils.USERS}/data/${FirebaseAuth.instance.currentUser!.uid}',
        )
        .doc(widget.getDocumentId.toString())
        .update(
      {
        'profiledisplayImage': urlIs.toString(),
      },
    ).then((value) => {
              //
              Navigator.pop(context),
            });
  }

  // update name
  updateName(nameText) async {
    //
    await FirebaseAuth.instance.currentUser!
        .updateDisplayName(nameText)
        .then((value) => {
              //
              FirebaseFirestore.instance
                  .collection(
                    '$strFirebaseMode${FirestoreUtils.USERS}/data/${FirebaseAuth.instance.currentUser!.uid}',
                  )
                  .doc(widget.getDocumentId.toString())
                  .update(
                {
                  'name': nameText.toString(),
                  'bio': contUserBio.text.toString(),
                },
              ).then((value) => {
                        //
                        Navigator.pop(context),
                      }),
            });
  }
}
