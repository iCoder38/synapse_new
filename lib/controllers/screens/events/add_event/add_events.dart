// import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:synapse_new/controllers/google_maps/google_maps.dart';
import 'package:uuid/uuid.dart';

import '../../../common/alert/alert.dart';
import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../utils/utils.dart';

import 'package:google_place/google_place.dart';

class AddEventsScreen extends StatefulWidget {
  const AddEventsScreen({super.key});

  @override
  State<AddEventsScreen> createState() => _AddEventsScreenState();
}

class _AddEventsScreenState extends State<AddEventsScreen> {
  //
  TextEditingController contEventName = TextEditingController();
  TextEditingController contDescription = TextEditingController();
  TextEditingController contStartDate = TextEditingController();
  TextEditingController contEndDate = TextEditingController();
  TextEditingController contFee = TextEditingController();
  //
  final formKey = GlobalKey<FormState>();
  //
  File? imageFile;
  XFile? image;
  final ImagePicker picker = ImagePicker();
  var communityImageUrl = '';
  //
  var strEventStatus = 'free';
  var strEventPrivate = 'no';
  var strEventOffline = 'no';
  //
  var strUserEnteredLocation = '0';
  var arrSaveAllAddress = [];
  //
  // final GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: '');
  final startSearchFieldController = TextEditingController();
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? debounce;
//
  @override
  void initState() {
    //
    contEventName = TextEditingController();
    contDescription = TextEditingController();
    contStartDate = TextEditingController();
    contEndDate = TextEditingController();
    contFee = TextEditingController();
    //
    String apiKey = kGoogle_API_KEY;
    googlePlace = GooglePlace(apiKey);
    //
    super.initState();
  }

  //
  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      //

      if (kDebugMode) {
        print(result.predictions!);
        //
        // arrSaveAllAddress.clear();
        for (int i = 0; i < result.predictions!.length; i++) {
          print(result.predictions![i].description);
          arrSaveAllAddress.add(result.predictions![i].description);
        }
        print(result.predictions!.first.description);
      }
      setState(() {
        predictions = result.predictions!;
        strUserEnteredLocation = '1';
      });
    }
  }
  //

  @override
  void dispose() {
    contEventName.dispose();
    contDescription.dispose();
    contStartDate.dispose();
    contEndDate.dispose();
    contFee.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: text_bold_roboto(
          //
          'Add Events'.toString(),
          Colors.white,
          20.0,
        ),
        // backgroundColor: Colors.white,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              //
              Padding(
                padding: const EdgeInsets.all(
                  12.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    //
                    pickImage();
                  },
                  child: Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
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
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                            ),
                          ),
                  ),
                ),
              ),
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: contEventName,
                  obscureText: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Event Name',
                      hintText: 'event name...'),
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
                  controller: contDescription,
                  obscureText: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Event Description',
                      hintText: 'event description...'),
                  maxLines: 4,
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
                  controller: contStartDate,
                  obscureText: false,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.date_range),
                      border: OutlineInputBorder(),
                      labelText: 'Event Start Date',
                      hintText: 'event start date...'),
                  maxLines: 1,
                  onTap: () async {
                    DateTime? startPickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100));
                    if (startPickedDate != null) {
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(startPickedDate);
                      setState(() {
                        contStartDate.text = formattedDate;
                      });
                    }
                  },
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
                  controller: contEndDate,
                  obscureText: false,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.date_range),
                      border: OutlineInputBorder(),
                      labelText: 'Event End date',
                      hintText: 'event end date...'),
                  maxLines: 1,
                  onTap: () async {
                    DateTime? startPickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100));
                    if (startPickedDate != null) {
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(startPickedDate);
                      setState(() {
                        contEndDate.text = formattedDate;
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
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
                  top: 10.0,
                  left: 10.0,
                ),
                child: Row(
                  children: [
                    text_bold_comforta(
                      'Event address',
                      Colors.black,
                      14.0,
                    ),
                  ],
                ),
              ),
              TextField(
                controller: startSearchFieldController,
                autofocus: false,
                style: const TextStyle(fontSize: 16),
                maxLines: 2,
                decoration: InputDecoration(
                    hintText: 'start enter event location',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: InputBorder.none),
                onChanged: (value) {
                  if (debounce?.isActive ?? false) debounce!.cancel();
                  debounce = Timer(const Duration(milliseconds: 600), () {
                    if (value.isNotEmpty) {
                      //places api
                      setState(() {
                        strUserEnteredLocation = '3';
                      });
                      arrSaveAllAddress.clear();
                      autoCompleteSearch(value);
                    } else {
                      //clear out the results
                    }
                  });
                },
              ),
              if (strUserEnteredLocation == '0') ...[
                const SizedBox(
                  height: 0,
                )
              ] else if (strUserEnteredLocation == '3') ...[
                text_bold_comforta(
                  'please wait...',
                  Colors.black,
                  14.0,
                )
              ] else ...[
                Column(
                  children: [
                    for (int i = 0; i < arrSaveAllAddress.length; i++) ...[
                      GestureDetector(
                        onTap: () {
                          //
                          if (kDebugMode) {
                            // print(arrSaveAllAddress[i]);
                          }
                          setState(() {
                            strUserEnteredLocation = '0';
                            startSearchFieldController.text =
                                arrSaveAllAddress[i].toString();
                          });
                        },
                        child: ListTile(
                          title: text_bold_comforta(
                            arrSaveAllAddress[i],
                            Colors.black,
                            14.0,
                          ),
                        ),
                      )
                    ]
                  ],
                ),
              ],

              //
              /*GestureDetector(
                onTap: () {
                  //
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const GoogleMapsScreen(),
                  //   ),
                  // );
                  //
                },
                child: ListTile(
                  title: text_bold_comforta(
                    'Event Location',
                    Colors.black,
                    16.0,
                  ),
                  subtitle: text_bold_comforta(
                    'Please select a location',
                    Colors.black,
                    12.0,
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                  ),
                ),
              ),*/
              //
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  height: 1,
                  color: Colors.black,
                ),
              ),
              // is event offline
              eventOfflineUI(),
              //
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              // is event private
              eventPrivateUI(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              // is the event free ?
              eventFreeUI(),
              //
              (strEventStatus == 'free')
                  ? const SizedBox(
                      height: 0,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: contFee,
                        obscureText: false,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Event Price',
                            hintText: 'event price...'),
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  height: 1,
                  color: Colors.black,
                ),
              ),
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    //
                    if (strEventStatus == 'free') {
                      contFee.text = '0';
                    }
                    if (formKey.currentState!.validate()) {
                      //
                      validationBeforeSubmit();
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
                        'Add Events',
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

// Function to handle opening map and selecting location
  /*void openMapAndSelectLocation() async {
    // Open map and wait for the selected location
    final selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchPlacesScreen(),
      ),
    );

    // Handle the selected location
    if (selectedLocation != null) {
      setState(() {
        if (kDebugMode) {
          print('======== USER SELECT THIS LOCATION ===========');
          print(selectedLocation);
          print('===============================================');
        }
        // location = selectedLocation;
      });
    }
  }*/

  Padding eventOfflineUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const SizedBox(
            width: 6.0,
          ),
          Expanded(
            child: text_bold_comforta(
              'Is the event Offline ?',
              Colors.black,
              14.0,
            ),
          ),
          //
          GestureDetector(
            onTap: () {
              //
              print('yes click');
              setState(() {
                strEventOffline = 'yes';
              });
            },
            child: (strEventOffline == 'yes')
                ? Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      color: select_color,
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                    child: Center(
                      child: text_bold_comforta(
                        'Yes',
                        Colors.white,
                        14.0,
                      ),
                    ),
                  )
                : Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                    child: Center(
                      child: text_bold_comforta(
                        'Yes',
                        Colors.black,
                        14.0,
                      ),
                    ),
                  ),
          ),
          //

          const SizedBox(
            width: 4.0,
          ),
          //
          GestureDetector(
            onTap: () {
              //
              setState(() {
                strEventOffline = 'no';
              });
            },
            child: (strEventOffline == 'no')
                ? Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      color: select_color,
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                    child: Center(
                      child: text_bold_comforta(
                        'No',
                        Colors.white,
                        14.0,
                      ),
                    ),
                  )
                : Container(
                    height: 30,
                    width: 66,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                    child: Center(
                      child: text_bold_comforta(
                        'No',
                        Colors.black,
                        14.0,
                      ),
                    ),
                  ),
          ),
          //
          const SizedBox(
            width: 6.0,
          ),
          //
        ],
      ),
    );
  }

  Padding eventPrivateUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const SizedBox(
            width: 6.0,
          ),
          Expanded(
            child: text_bold_comforta(
              'Is the event private ?',
              Colors.black,
              14.0,
            ),
          ),
          //
          GestureDetector(
            onTap: () {
              //
              print('yes click');
              setState(() {
                strEventPrivate = 'yes';
              });
            },
            child: (strEventPrivate == 'yes')
                ? Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      color: select_color,
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                    child: Center(
                      child: text_bold_comforta(
                        'Yes',
                        Colors.white,
                        14.0,
                      ),
                    ),
                  )
                : Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                    child: Center(
                      child: text_bold_comforta(
                        'Yes',
                        Colors.black,
                        14.0,
                      ),
                    ),
                  ),
          ),
          //

          const SizedBox(
            width: 4.0,
          ),
          //
          GestureDetector(
            onTap: () {
              //
              setState(() {
                strEventPrivate = 'no';
              });
            },
            child: (strEventPrivate == 'no')
                ? Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      color: select_color,
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                    child: Center(
                      child: text_bold_comforta(
                        'No',
                        Colors.white,
                        14.0,
                      ),
                    ),
                  )
                : Container(
                    height: 30,
                    width: 66,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                    child: Center(
                      child: text_bold_comforta(
                        'No',
                        Colors.black,
                        14.0,
                      ),
                    ),
                  ),
          ),
          //
          const SizedBox(
            width: 6.0,
          ),
          //
        ],
      ),
    );
  }

  Padding eventFreeUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const SizedBox(
            width: 6.0,
          ),
          Expanded(
            child: text_bold_comforta(
              'Is the event free ?',
              Colors.black,
              14.0,
            ),
          ),
          //
          GestureDetector(
            onTap: () {
              //
              print('free click');
              setState(() {
                strEventStatus = 'free';
              });
            },
            child: (strEventStatus == 'free')
                ? Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      color: select_color,
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                    child: Center(
                      child: text_bold_comforta(
                        'Free',
                        Colors.white,
                        14.0,
                      ),
                    ),
                  )
                : Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                    child: Center(
                      child: text_bold_comforta(
                        'Free',
                        Colors.black,
                        14.0,
                      ),
                    ),
                  ),
          ),
          //
          const SizedBox(
            width: 4.0,
          ),
          //
          GestureDetector(
            onTap: () {
              //
              setState(() {
                strEventStatus = 'paid';
              });
            },
            child: (strEventStatus == 'paid')
                ? Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      color: select_color,
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                    child: Center(
                      child: text_bold_comforta(
                        'Paid',
                        Colors.white,
                        14.0,
                      ),
                    ),
                  )
                : Container(
                    height: 30,
                    width: 66,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                    child: Center(
                      child: text_bold_comforta(
                        'Paid',
                        Colors.black,
                        14.0,
                      ),
                    ),
                  ),
          ),
          //
          const SizedBox(
            width: 6.0,
          ),
          //
        ],
      ),
    );
  }

  Future<void> pickImage() async {
    var img = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = img;
      //
      communityImageUrl = 'yes';
    });
    //
  }

  validationBeforeSubmit() {
    if (communityImageUrl == 'yes') {
      //
      showLoadingUI(context, str_alert_please_wait);
      //
      uploadImageToFirebase(
        context,
        const Uuid().toString(),
      );
    } else {
      // s
      // Snackbar(context, Colors.redAccent, 'Please upload event image');
      if (kDebugMode) {
        print('please upload event image');
      }
    }
  }

  Future uploadImageToFirebase(BuildContext context, savedUUID) async {
    if (kDebugMode) {
      print('dishu');
    }
    //
    // var generateRandomNumber = generateRandomString(10);
    var file = File(image!.path);
    var snapshot = await FirebaseStorage.instance
        .ref()
        .child('$FIREBASE_STORAGE_EVENT_URL/$savedUUID/content/display_image')
        //
        .putFile(file);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      if (kDebugMode) {
        // print(downloadUrl);
      }
      communityImageUrl = downloadUrl;
      //
      addEventsInFirebase(
        downloadUrl,
        savedUUID,
      );
    });
  }

  //
  //
  addEventsInFirebase(
    imageURL,
    uuid,
  ) {
    //

    if (kDebugMode) {
      print('================================');
      print('==> ADDING EVENTS IN FIREBASE <==');
      print('================================');
    }

    CollectionReference users = FirebaseFirestore.instance.collection(
      // '${strFirebaseMode}post/India/data',
      '$strFirebaseMode${FirestoreUtils.EVENTS}',
    );

    users
        .add(
          {
            'eventId': const Uuid().v4(),
            'eventAdminId': [
              FirebaseAuth.instance.currentUser!.uid,
            ],
            // event creator date
            'eventUserName': FirebaseAuth.instance.currentUser!.displayName,
            'eventUserFirebaseId': FirebaseAuth.instance.currentUser!.uid,
            'eventUserEmail': FirebaseAuth.instance.currentUser!.email,
            // event data
            'eventName': contEventName.text.toString(),
            'eventStartDate': contStartDate.text.toString(),
            'eventEndDate': contEndDate.text.toString(),
            'eventFee': contFee.text.toString(),
            'eventImage': imageURL.toString(),
            'eventOffline': strEventOffline,
            'eventPrivate': strEventPrivate,
            'eventFree': strEventStatus,
            'eventDescription': contDescription.text.toString(),
            //
            'eventAddress': startSearchFieldController.text.toString(),
            // multiple data ( followers )
            'eventJoinedMembersId': [
              //
              FirebaseAuth.instance.currentUser!.uid,
            ],
            // multiple data ( likes )
            'eventLikes': [],
            //
            'eventsLikesCount': '0',
            //
            'timeStamp': DateTime.now().millisecondsSinceEpoch,
            'active': 'yes',
            //
          },
        )
        .then(
          (value) => addEventFirestoreId(value.id),
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  //
  addEventFirestoreId(elementId) {
    //

    FirebaseFirestore.instance
        .collection("$strFirebaseMode${FirestoreUtils.EVENTS}")
        .doc(elementId)
        .set(
      {
        'documentId': elementId,
      },
      SetOptions(merge: true),
    ).then(
      (value1) {
        // dismiss keyboard
        successfullyAddedExperience();
      },
    );
  }

  successfullyAddedExperience() {
    Navigator.pop(context);
    Navigator.pop(context);
    //
  }
  //
}
