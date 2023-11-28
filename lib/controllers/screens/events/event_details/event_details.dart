// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readmore/readmore.dart';
import 'package:synapse_new/controllers/update_data_on_firebase/events/add_member_in_events/add_member_in_event.dart';
import 'package:synapse_new/controllers/update_data_on_firebase/events/remove_member_from_firebase/remove_event_member_from_firebase.dart';
import 'package:uuid/uuid.dart';

import '../../../common/alert/alert.dart';
import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../utils/utils.dart';
import '../event_description/event_description.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key, this.getEventData});

  final getEventData;

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  //
  var strEventName = '';
  var strEventImage = '';
  var strEventAdminName = '';
  var strEventDescription = '';
  var strEventOnlineStatus = '';
  var strEventStartDate = '';
  var strEventEndDate = '';
  var strEventAdminId = '';
  var strEventId = '';
  var strEventAddress = '';
  var strEventDocumentId = '';
  //
  var arrSaveAllImages = [];
  //
  var strJoinLoader = '0';
  //
  XFile? image;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  //
  @override
  void initState() {
    print('======================================');
    if (kDebugMode) {
      print(widget.getEventData);
    }
    print('======================================');
    //
    getAndparseValue();
    super.initState();
  }

  getAndparseValue() {
    //
    strEventName = widget.getEventData['eventName'].toString();
    strEventImage = widget.getEventData['eventImage'].toString();
    strEventAdminName = widget.getEventData['eventUserName'].toString();
    strEventDescription = widget.getEventData['eventDescription'].toString();
    strEventOnlineStatus = widget.getEventData['eventOffline'].toString();
    strEventStartDate = widget.getEventData['eventStartDate'].toString();
    strEventEndDate = widget.getEventData['eventEndDate'].toString();
    strEventAdminId = widget.getEventData['eventUserFirebaseId'].toString();
    strEventId = widget.getEventData['eventId'].toString();
    strEventAddress = widget.getEventData['eventAddress'].toString();
    strEventDocumentId = widget.getEventData['documentId'].toString();
    //
    checkYouJoinedThisEventOrNot();
    //
    // setState(() {
    //   if (kDebugMode) {
    //     print('refresh');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: text_bold_roboto(
          //
          'Details',
          Colors.white,
          20.0,
        ),
        // backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 240,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: strEventImage,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => const SizedBox(
                      height: 40,
                      width: 40,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            //
            ListTile(
              title: text_bold_comforta(
                //
                strEventName,
                Colors.black,
                22.0,
              ),
              trailing: strJoinLoader == '0'
                  ? const SizedBox(
                      height: 0,
                    )
                  : strJoinLoader == '1'
                      ? GestureDetector(
                          onTap: () {
                            //
                            setState(() {
                              strJoinLoader = '2';
                            });
                            //
                            addMeInThisEvent();
                            //
                          },
                          child: Container(
                            // height: 40,
                            // width: 60,

                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 69, 114, 150),
                              border: Border.all(
                                width: 0.4,
                              ),
                              borderRadius: BorderRadius.circular(
                                12.0,
                              ),
                            ),
                            height: 40,
                            width: 80,

                            child: Center(
                              child: text_bold_comforta(
                                'Join',
                                Colors.white,
                                14.0,
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            //
                            setState(() {
                              strJoinLoader = '1';
                            });
                            // CLASS : FIREBASE COMMON
                            removeMeFromEventInFirebase(
                                strEventDocumentId.toString());

                            //
                          },
                          child: Container(
                            // height: 40,
                            // width: 60,

                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 0.4,
                              ),
                              borderRadius: BorderRadius.circular(
                                12.0,
                              ),
                            ),
                            height: 40,
                            width: 80,

                            child: Center(
                              child: text_bold_comforta(
                                'Joined',
                                Colors.black,
                                14.0,
                              ),
                            ),
                          ),
                        ),
              subtitle: Row(
                children: [
                  text_bold_roboto(
                    //
                    'By : ',
                    Colors.blueAccent,
                    16.0,
                  ),
                  text_bold_comforta(
                    //
                    strEventAdminName,
                    Colors.black,
                    12.0,
                  ),
                ],
              ),
            ),
            // UI : Event Description
            EventDescriptionUI(
              getEventDescription: strEventDescription,
            ),
            //
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                height: 1,
                color: Colors.grey,
              ),
            ),
            //
            ListTile(
              leading: const Icon(
                Icons.location_city,
                color: Colors.blueAccent,
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.blueAccent,
              ),
              title: text_bold_comforta(
                'Address',
                Colors.black,
                16.0,
              ),
              subtitle: text_bold_comforta(
                //
                strEventAddress,
                Colors.grey,
                12.0,
              ),
            ),
            //
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                height: 1,
                color: Colors.grey,
              ),
            ),
            //
            ListTile(
              leading: const Icon(
                Icons.pin_drop,
                color: Colors.blueAccent,
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.blueAccent,
              ),
              title: (strEventOnlineStatus == 'yes')
                  ? text_bold_comforta(
                      'Online',
                      Colors.black,
                      16.0,
                    )
                  : text_bold_comforta(
                      'Offline',
                      Colors.black,
                      16.0,
                    ),
              subtitle: (strEventOnlineStatus == 'yes')
                  ? text_bold_comforta(
                      'This is an online event',
                      Colors.grey,
                      12.0,
                    )
                  : text_bold_comforta(
                      'This is an online event',
                      Colors.grey,
                      12.0,
                    ),
            ),
            //
            ListTile(
              leading: const Icon(
                Icons.watch,
                color: Colors.blueAccent,
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.blueAccent,
              ),
              title: text_bold_comforta(
                //
                'Time',
                Colors.black,
                14.0,
              ),
              subtitle: text_bold_comforta(
                //
                '$strEventStartDate - $strEventEndDate',
                Colors.grey,
                12.0,
              ),
            ),
            //
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                height: 1,
                color: Colors.grey,
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              child: Container(
                // height: 60,
                width: MediaQuery.of(context).size.width,
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
                      ),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: text_bold_roboto(
                        'Media',
                        Colors.black,
                        18.0,
                      ),
                    ),
                    //
                    (strEventAdminId ==
                            FirebaseAuth.instance.currentUser!.uid.toString())
                        ? IconButton(
                            onPressed: () {
                              //
                              // openUploadOptions(context);
                            },
                            icon: const Icon(
                              Icons.add,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              //
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          )
                  ],
                ),
              ),
            ),
            // UI :
            const SizedBox(
              height: 20.0,
            ),
            /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: EventsPhotosUI(
                strGetEventId: strEventId,
              ),
            ),*/
          ],
        ),
      ),
    );
  }

//
  void openUploadOptions(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Please select an option'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          //
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              //
              selectImages();
              //
            },
            child: text_bold_comforta(
              'Open Gallery',
              Colors.black,
              14.0,
            ),
          ),
          //
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: text_bold_comforta(
              'Dismiss',
              Colors.red,
              16.0,
            ),
          ),
        ],
      ),
    );
  }

  //
  // select multiple images
  void selectImages() async {
    //
    if (kDebugMode) {
      print('dishant rajput 1');
    }
    imageFileList!.clear();
    //
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    // imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }

    /*setState(() {
      str_user_profile_loader = '0';
    });*/

    if (kDebugMode) {
      print('dishant rajput 2');
      print("Image List Length: =====> ${imageFileList!.last}");
      print("Image List Length: =====> ${imageFileList!.length}");
    }

    //
    uploadImageToFirebase(
      context,
      'savedUUID',
    );
    //
  }

  //
  Future uploadImageToFirebase(BuildContext context, savedUUID) async {
    if (kDebugMode) {
      print('==============================');
      print('time to upload multiple image on firebase');
      // print(imageFileList);
    }
    //
    showLoadingUI(context, str_alert_please_wait);
    arrSaveAllImages.clear();
    for (int i = 0; i < imageFileList!.length; i++) {
      //
      image = imageFileList![i];
      // printInDebugMode('==============================');
      if (kDebugMode) {
        // print(image);
      }
      // printInDebugMode('==============================');
      var file = File(image!.path);
      var snapshot = await FirebaseStorage.instance
          .ref()
          .child(
            '$FIREBASE_STORAGE_EVENT_MEDIA_URL/$strEventId/${const Uuid().toString()}/content/display_image',
            // 'test1/${UUID.getUUID().toString()}',
          )
          //
          .putFile(file);
      if (kDebugMode) {
        // printInDebugMode('========== INDEX ===========');
        // print(i);
        // printInDebugMode('==============================');
      }

      //
      var downloadUrl = await snapshot.ref.getDownloadURL();
      // setState(() {
      if (kDebugMode) {
        print(downloadUrl);
      }
      //
      arrSaveAllImages.add(downloadUrl);
      // });
    }
    print('===============================');
    print('UPLOADED ALL IMAGES TO FIREBASE');
    if (kDebugMode) {
      print(arrSaveAllImages);
    }
    print('===============================');
    //
    addMediaInFirebase();
  }

  //
  // add community in firebase
  addMediaInFirebase() {
    //
    print('=======================');
    print('adding events media');
    print('=======================');
    for (int i = 0; i < arrSaveAllImages.length; i++) {
      //
      CollectionReference users = FirebaseFirestore.instance.collection(
        '$strFirebaseMode${FirestoreUtils.EVENTS_MEDIA}/$strEventId/data',
      );

      users
          .add(
            {
              'eventId': strEventId.toString(),
              'media_image': arrSaveAllImages[i].toString(),
              'timeStamp': DateTime.now().millisecondsSinceEpoch,
            },
          )
          .then(
            (value) =>
                //
                addCommunityIdInCommunity(
              value.id,
            ),
          )
          .catchError(
            (error) => print("Failed to add user: $error"),
          );
      //
    }
    //
    // dismiss popup
    Navigator.pop(context);
    //
  }

  //
  addCommunityIdInCommunity(
    elementId,
  ) {
    //
    print('=======================');
    print('add event media id in id');
    print('=======================');
    FirebaseFirestore.instance
        .collection('$strFirebaseMode${FirestoreUtils.EVENTS_MEDIA}')
        .doc(strEventId)
        .collection('data')
        .doc(elementId)
        .set(
      {
        'documentId': elementId,
      },
      SetOptions(merge: true),
    ).then(
      (value1) {
        // Navigator.pop(context);
        // followThisGroupInFirebase(cid);
      },
    );
  }

  //
  // check you joined this event or not
  checkYouJoinedThisEventOrNot() {
    //

    FirebaseFirestore.instance
        .collection(
          '$strFirebaseMode${FirestoreUtils.EVENTS}',
        )
        .where('documentId', isEqualTo: strEventDocumentId.toString())
        .where(
          'eventJoinedMembersId',
          arrayContainsAny: [
            FirebaseAuth.instance.currentUser!.uid,
          ],
        )
        .get()
        .then((value) {
          if (kDebugMode) {
            print(value.docs);
          }

          if (value.docs.isEmpty) {
            if (kDebugMode) {
              print("======> NO, YOU DIDN'T JOIN THIS EVENT <========");
            }
            setState(() {
              strJoinLoader = '1';
            });
          } else {
            if (kDebugMode) {
              print("======> YES, YOU ALREADY JOINED THIS EVENT <========");
            }
            for (var element in value.docs) {
              if (kDebugMode) {
                print(element.id);
                //
              }
              //
            }
            //
            setState(() {
              strJoinLoader = '2';
            });
          }
        });
  }

  // add me in this event
  addMeInThisEvent() {
    if (kDebugMode) {
      print('=======================');
      print('add me in this event');
      print('=======================');
    }

    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}event_follow/$strEventId/data',
    );

    users
        .add(
          {
            'eventId': strEventId.toString(),
            'eventName': strEventName.toString(),
            'timeStamp': DateTime.now().millisecondsSinceEpoch,
            'followerId': FirebaseAuth.instance.currentUser!.uid.toString(),
          },
        )
        .then(
          (value) => joinMyIdInThisEvent(strEventDocumentId.toString()),
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  // add this member in this event
}
