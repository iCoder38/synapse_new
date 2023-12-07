// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print

import 'dart:io';
import 'dart:math' as math;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:synapse_new/controllers/chat/oneToOne/widgets/receiver_ui/receiver_ui.dart';
import 'package:synapse_new/controllers/chat/oneToOne/widgets/sender_ui.dart/sender_ui.dart';

import '../../common/alert/app_color/app_color.dart';
import '../../screens/utils/utils.dart';
import 'firebase/update_last_message/firebase_single_chat_methods.dart';

class OneToOneChatScreen extends StatefulWidget {
  const OneToOneChatScreen({
    Key? key,
    required this.getName,
    required this.getFirebaseId,
  }) : super(key: key);

  final String getName;
  final String getFirebaseId;

  @override
  State<OneToOneChatScreen> createState() => _OneToOneChatScreenState();
}

class _OneToOneChatScreenState extends State<OneToOneChatScreen> {
  //
  // late DataBase handler;
  //
  var strImageLoader = '0';
  var strFriendLoader = '0';
  var strLoginUserName = '';
  var strLoginUserId = '';
  var strLoginUserFirebaseId = '';
  var strloginUserImage = '';
  //
  var strScrollOnlyOneTime = '0';
  var lastMessage = '';
  //
  File? imageFile;
  var str_image_processing = '0';
  //
  bool _needsScroll = false;
  final ScrollController _scrollController = ScrollController();
  //
  TextEditingController contTextSendMessage = TextEditingController();
  TextEditingController contTextTag = TextEditingController();
  //
  var strGroupName = '';
  var strDisableTextField = '1';
  //
  var strUserInputTags = '0';
  //
  var roomId = '';
  var reverseRoomId = '';
  //
  @override
  void initState() {
    if (kDebugMode) {
      print('**************** CHAT DATA ***************************');
      // print(widget.chatDialogData);
      print('*******************************************************');
    }
    super.initState();
    //
    strGroupName = 'group name';
    roomId =
        '${FirebaseAuth.instance.currentUser!.uid}+${widget.getFirebaseId.toString()}';
    reverseRoomId =
        '${widget.getFirebaseId.toString()}+${FirebaseAuth.instance.currentUser!.uid}';
    //
  }

  _scrollToEnd() async {
    if (_needsScroll) {
      _needsScroll = false;
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_comforta(
          'Chat',
          Colors.black,
          16.0,
        ),
        backgroundColor: dialog_page_navigation_color(),
      ),
      //
      // backgroundColor: Colors.white,
      //
      body: Stack(
        children: [
          Container(
            color: Colors.transparent,
            margin: const EdgeInsets.only(top: 0, bottom: 60),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(
                      "${strFirebaseMode}chat",
                    )
                    .orderBy('time_stamp', descending: true)
                    .where(
                      'room_id',
                      whereIn: [
                        roomId,
                        reverseRoomId,
                      ],
                    )
                    .limit(10)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    if (kDebugMode) {
                      print('=====> YES, DATA');
                    }
                    //
                    // if (strScrollOnlyOneTime == '1') {
                    // if (kDebugMode) {
                    // print('=====> YES, DATA 2');
                    // }
                    _needsScroll = true;
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => _scrollToEnd());
                    // }
                    //

                    var getSnapShopValue =
                        snapshot.data!.docs.reversed.toList();
                    // if (kDebugMode) {
                    // print(getSnapShopValue);
                    // }
                    return Stack(
                      children: [
                        //
                        ListView.builder(
                          controller: _scrollController,
                          itemCount: getSnapShopValue.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.only(
                                left: 14,
                                right: 14,
                                //
                                top: 10,
                                bottom: 10,
                              ),
                              child: Align(
                                alignment: (getSnapShopValue[index]['sender_id']
                                            .toString() ==
                                        FirebaseAuth.instance.currentUser!.uid
                                    ? Alignment.topRight
                                    : Alignment.topLeft),
                                child: (getSnapShopValue[index]['sender_id']
                                            .toString() ==
                                        FirebaseAuth.instance.currentUser!.uid)
                                    ? SenderUIScreen(
                                        getDataForSenderWithIndex:
                                            getSnapShopValue[index],
                                      )
                                    : ReceiverUIScreen(
                                        getDataForReceiverWithIndex:
                                            getSnapShopValue[index]),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    //
                    if (kDebugMode) {
                      print(snapshot.error);
                    }
                    //
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          //
          // ======> SEND MESSAGE UI <======
          // ===============================
          (strDisableTextField == '0')
              ? const SizedBox(
                  height: 40,
                )
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: sendMessageUI(),
                ),
          // ================================
          // ================================
          //
        ],
      ),
    );
  }

  Align imageProcessingLoaderUI() {
    return Align(
      alignment: Alignment.topCenter,
      child: InkWell(
        onTap: () {
          // _needsScroll = true;
          // WidgetsBinding.instance
          //     .addPostFrameCallback(
          //         (_) =>
          //             _scrollToEnd());
        },
        child: Container(
          margin: const EdgeInsets.all(
            10.0,
          ),
          width: 160,
          height: 40,
          decoration: BoxDecoration(
            color: const Color.fromARGB(
              255,
              250,
              247,
              247,
            ),
            borderRadius: BorderRadius.circular(
              14.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(
                  0,
                  3,
                ), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: text_bold_comforta(
              'processing...',
              Colors.black,
              14.0,
            ),
          ),
        ),
      ),
    );
  }

  //
  //
  Container sendMessageUI() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: contTextSendMessage,
                minLines: 1,
                maxLines: 5,
                decoration: const InputDecoration(
                  // labelText: '',
                  hintText: 'write something',
                ),
              ),
            ),
          ),
          //

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              width: 40,
              child: IconButton(
                onPressed: () {
                  //
                  (contTextSendMessage.text == '')
                      ? const SizedBox(
                          height: 0,
                        )
                      : (strDisableTextField == '0')
                          ? contTextSendMessage.text = ''
                          : sendMessageViaFirebase(contTextSendMessage.text);
                  lastMessage = contTextSendMessage.text.toString();
                },
                icon: const Icon(
                  Icons.send,
                ),
              ),
            ),
          ),
          /*IconButton(
            onPressed: () {
              if (kDebugMode) {
                print('send');
              }
              //

              sendMessageViaFirebase(contTextSendMessage.text);
              lastMessage = contTextSendMessage.text.toString();
              contTextSendMessage.text = '';

              // }
            },
            icon: const Icon(
              Icons.send,
            ),
          ),*/
          //
        ],
      ),
    );
  }

  //
  // send message
  sendMessageViaFirebase(strLastMessageEntered) {
    //
    contTextSendMessage.text = '';
    //
    var timeStamValue = DateTime.now().millisecondsSinceEpoch;
    //
    if (kDebugMode) {
      print('USER SEND DATA IN CHAT');
    }

    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}chat',
    );

    users
        .add(
          {
            'sender_name':
                FirebaseAuth.instance.currentUser!.displayName.toString(),
            'sender_id': FirebaseAuth.instance.currentUser!.uid.toString(),
            'sender_email': FirebaseAuth.instance.currentUser!.email.toString(),
            // 'time_stamp': timeStamValue.toString(),
            'time_stamp': timeStamValue,
            'message': strLastMessageEntered.toString(),
            'room_id': roomId.toString(),
            'members': [
              FirebaseAuth.instance.currentUser!.uid,
              widget.getFirebaseId,
            ],
            'users': [
              roomId,
              reverseRoomId,
            ]
          },
        )
        .then(
          (value) => addChatDocumentId(
              value.id, timeStamValue, strLastMessageEntered.toString()),
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

//
  addChatDocumentId(value2, timeStamp, lastMessage) {
    FirebaseFirestore.instance
        .collection("${strFirebaseMode}chat")
        .doc(value2)
        .set(
      {
        'documentId': value2.toString(),
      },
      SetOptions(merge: true),
    ).then(
      // checkDialog(value2, timeStamp, lastMessage)
      (value1) => checkDialog(roomId, reverseRoomId, value2, timeStamp,
          lastMessage, widget.getFirebaseId, widget.getName),
    );
  }

  //

  //
  // funcEditDialog(elementId) {
  //   FirebaseFirestore.instance
  //       .collection("${strFirebaseMode}groups")
  //       .doc("India")
  //       .collection("details")
  //       .doc(elementId)
  //       .set(
  //     {
  //       'time_stamp': DateTime.now().millisecondsSinceEpoch,
  //       'last_message': lastMessage.toString(),
  //     },
  //     SetOptions(merge: true),
  //   ).then(
  //     (value1) => print(''),
  //   );
  // }

  //
  //
  void openGalleryOrCamera(BuildContext context) {
    /*showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Camera option'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              // ignore: deprecated_member_use
              PickedFile? pickedFile = await ImagePicker().getImage(
                source: ImageSource.camera,
                maxWidth: 1800,
                maxHeight: 1800,
              );
              if (pickedFile != null) {
                setState(() {
                  //
                  strImageLoader = '1';
                  //
                  str_image_processing = '1';
                  print('camera');
                  imageFile = File(pickedFile.path);
                });
                //

                //
                uploadImageToFirebase(context);
                //

                //
              }
            },
            child: text_bold_comforta('Open Camera', Colors.black, 14.0),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              // ignore: deprecated_member_use
              PickedFile? pickedFile = await ImagePicker().getImage(
                source: ImageSource.gallery,
                maxWidth: 1800,
                maxHeight: 1800,
              );
              if (pickedFile != null) {
                setState(() {
                  //
                  strImageLoader = '1';
                  //
                  if (kDebugMode) {
                    print('gallery');
                  }
                  imageFile = File(pickedFile.path);
                });
                str_image_processing = '1';
                uploadImageToFirebase(context);
              }
            },
            child: text_bold_comforta('Open Gallery', Colors.black, 14.0),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: text_bold_comforta('Dismiss', Colors.black, 14.0),
          ),
        ],
      ),
    );*/
  }

  //
  // upload image via firebase
  Future uploadImageToFirebase(BuildContext context) async {
    if (kDebugMode) {
      print('=====> CREATING IMAGE URL <=====');
    }

    Reference storageRef = FirebaseStorage.instance
        .ref()
        .child(
          'private_chat/${FirebaseAuth.instance.currentUser!.uid}',
        )
        .child(
          generateRandomString(10),
        );
    await storageRef.putFile(imageFile!);
    return await storageRef.getDownloadURL().then((value) => {
          sendImagViaMessageForGroupChat(value),
        });
  }

  sendImagViaMessageForGroupChat(attachmentPath) {
    // print(cont_txt_send_message.text);

    setState(() {
      strImageLoader = '0';
    });

    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}chat',
    );

    users
        .add(
          {
            'attachment_path': attachmentPath.toString(),
            'sender_name': strLoginUserName.toString(),
            'sender_firebase_id': FirebaseAuth.instance.currentUser!.uid,
            'message': ''.toString(),
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            'room': 'group',
            'type': 'image',
            'chat_members': ''
          },
        )
        .then((value) => print('dishant rajput') //addChatDocumentId(value.id),
            )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

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
  Future<void> pushToChatDetails(BuildContext context) async {
    //
    // final result = await Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => GroupChatDetailsScreen(
    //         dictGetDataForDetails: widget.chatDialogData,
    //       ),
    //     ));

    // if (!mounted) return;
    // //
    // if (result == 'ok') {
    //   print(result);
    //   setState(() {
    //     print('=====> update UI');
    //     // strGroupName = result;
    //   });
    //   // funcGetLocalDBdata();
    // }
  }

  // funcRemoved() {
  // Navigator.pop(context);
  /*QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      text: 'message'.toString(),
    );*/
  //
  // }
}
