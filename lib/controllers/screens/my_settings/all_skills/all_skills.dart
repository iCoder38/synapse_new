// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:synapse_new/controllers/screens/my_settings/add_edit_skill/add_edit_skill.dart';

import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../utils/utils.dart';
import '../../../update_data_on_firebase/delete_career_profile_data/delete_data.dart';

class AllSkillsScreen extends StatefulWidget {
  const AllSkillsScreen({
    Key? key,
    required this.strFirebaseId,
    required this.strGetDocumentId,
  }) : super(key: key);

  final String strFirebaseId;
  final String strGetDocumentId;

  @override
  State<AllSkillsScreen> createState() => _AllSkillsScreenState();
}

class _AllSkillsScreenState extends State<AllSkillsScreen> {
  //
  var strFloatingButtonVisibility = false;
  //
  @override
  void initState() {
    if (kDebugMode) {
      print('======== SKILL LIST : FIREBASE ID ========');
      print(widget.strFirebaseId);
      print('===========================================');
    }
    if (widget.strFirebaseId ==
        FirebaseAuth.instance.currentUser!.uid.toString()) {
      //
      strFloatingButtonVisibility = true;
    } else {
      //
      strFloatingButtonVisibility = false;
    }
    // setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0),
          title: text_bold_comforta(
            'Skills',
            Colors.white,
            16.0,
          ),
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
        floatingActionButton: Visibility(
          visible: strFloatingButtonVisibility,
          child: FloatingActionButton(
            onPressed: () {
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditSkillScreen(
                    getFirebaseIdAddSkill: widget.strFirebaseId,
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.add,
            ),
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(
                  '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA}/${widget.strFirebaseId}/skills',
                )
                /*.where(
                  'documentId',
                  isEqualTo: widget.strGetDocumentId.toString(),
                )*/
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                //
                var getSnapShopValue = snapshot.data!.docs.toList();
                // getAndSaveDocumentId =
                // getSnapShopValue[0]['documentId'].toString();
                if (kDebugMode) {
                  print('================================');
                  print(getSnapShopValue.length);
                  print('================================');

                  // printInDebugMode('======= LOGIN USER DATA =======');
                  // print(getSnapShopValue[0]['skills'][0]['skillName']);
                  // print(getSnapShopValue[0]['skills'].length);
                  // printInDebugMode('================================');
                }
                return ListView.builder(
                  itemCount: getSnapShopValue.length,
                  /*prototypeItem: const ListTile(
                    title: Text('title'),
                  ),*/
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: text_bold_comforta(
                        getSnapShopValue[index]['skillName'].toString(),
                        Colors.black,
                        22.0,
                      ),
                      subtitle: text_bold_comforta(
                        getSnapShopValue[index]['skillProficiency'].toString(),
                        Colors.black,
                        12.0,
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          //
                          deletePopup(
                              getSnapShopValue[index]['documentId'].toString());
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.redAccent,
                        ),
                      ),
                    );
                  },
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
            })
        /**/
        );
  }

  //
  deletePopup(skillDocumentId) {
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
                          Navigator.pop(context);
                          // deleteSkill(skillDocumentId);
                          deleteCareerProfileFromFirebase(
                              widget.strFirebaseId, skillDocumentId, 'skills');
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
  // deleteSkill(documentIdToDelete) {

  //   /*final collection = FirebaseFirestore.instance.collection(
  //     '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA}/${widget.strFirebaseId}/skills',
  //   );
  //   collection
  //       .doc(documentIdToDelete) // <-- Doc ID to be deleted.
  //       .delete() // <-- Delete
  //       .then((_) => print('Deleted'))
  //       .catchError((error) => print('Delete failed: $error'));*/
  // }
}
