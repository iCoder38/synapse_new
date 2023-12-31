// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:synapse_new/controllers/screens/my_settings/edit_my_event/edit_my_event.dart';

import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../events/all_events/widgets/event_name_members/event_name_members.dart';
import '../../events/event_details/event_details.dart';
import '../../utils/utils.dart';

class MyEventsScreen extends StatefulWidget {
  const MyEventsScreen({
    Key? key,
    required this.getUserFirebaseId,
  }) : super(key: key);

  final String getUserFirebaseId;

  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: text_bold_roboto(
          //
          'My Events'.toString(),
          Colors.white,
          20.0,
        ),
        // backgroundColor: Colors.white,
      ),
      /*floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          //
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const AddEventsScreen(),
          //   ),
          // );
        },
        child: const Icon(Icons.edit),
      ),*/
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('$strFirebaseMode${FirestoreUtils.EVENTS}')
              .orderBy('timeStamp', descending: true)
              .where('active', isEqualTo: 'yes')
              .where('eventAdminId', arrayContainsAny: [
                //
                widget.getUserFirebaseId.toString(),
              ])
              //
              .limit(20)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              // get and save value in some variable
              var getSnapShopValue = snapshot.data!.docs.toList();
              //
              if (getSnapShopValue.isEmpty) {
                //
                return Center(
                  child: text_bold_comforta(
                    'No events',
                    Colors.black,
                    14.0,
                  ),
                );
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      for (int i = 0; i < getSnapShopValue.length; i++) ...[
                        GestureDetector(
                          onTap: () {
                            //
                            showEditEvent(getSnapShopValue[i]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // height: 140,
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
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  //
                                  Padding(
                                    padding: const EdgeInsets.all(
                                      4.0,
                                    ),
                                    child: Container(
                                      height: 148,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(
                                          12.0,
                                        ),
                                      ),
                                      child: (getSnapShopValue[i]['eventImage']
                                                  .toString() ==
                                              '')
                                          ? Image.asset(
                                              'assets/student4.jpeg',
                                              fit: BoxFit.fill,
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                12.0,
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: getSnapShopValue[i]
                                                        ['eventImage']
                                                    .toString(),
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) =>
                                                    const SizedBox(
                                                  height: 40,
                                                  width: 40,
                                                  child: Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                    ),
                                  ),
                                  // UI : EVENT NAME AND MEMBERS COUNT
                                  EventNameMembersScreen(
                                    getDataWithIndexForNameAndMembers:
                                        getSnapShopValue[i],
                                  ),
                                  //
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_month,
                                          size: 18.0,
                                        ),
                                        //
                                        const SizedBox(
                                          width: 4.0,
                                        ),
                                        //
                                        Expanded(
                                          child: text_bold_comforta(
                                            //,
                                            getSnapShopValue[i]
                                                    ['eventStartDate'] +
                                                ' - ' +
                                                getSnapShopValue[i]
                                                    ['eventEndDate'],
                                            Colors.black,
                                            12.0,
                                          ),
                                        ),
                                        //
                                      ],
                                    ),
                                  ),
                                  //
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.pin_drop,
                                          size: 18.0,
                                        ),
                                        //
                                        const SizedBox(
                                          width: 4.0,
                                        ),
                                        //
                                        (getSnapShopValue[i]['eventOffline'] ==
                                                'no')
                                            ? text_bold_comforta(
                                                'Online',
                                                Colors.black,
                                                12.0,
                                              )
                                            : text_bold_comforta(
                                                'Offline',
                                                Colors.black,
                                                12.0,
                                              ),
                                        //
                                        const SizedBox(
                                          width: 8.0,
                                        ),
                                        //
                                        const Icon(
                                          Icons.money,
                                          size: 18.0,
                                        ),
                                        //
                                        const SizedBox(
                                          width: 4.0,
                                        ),
                                        //
                                        (getSnapShopValue[i]['eventFee'] == '0')
                                            ? Row(
                                                children: [
                                                  text_regular_comforta(
                                                    //,
                                                    'INR : ',
                                                    Colors.black,
                                                    10.0,
                                                  ),
                                                  text_bold_comforta(
                                                    //,
                                                    '0',
                                                    Colors.black,
                                                    16.0,
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                children: [
                                                  text_regular_comforta(
                                                    //,
                                                    'INR : ',
                                                    Colors.black,
                                                    10.0,
                                                  ),
                                                  text_bold_comforta(
                                                    //,
                                                    getSnapShopValue[i]
                                                        ['eventFee'],
                                                    Colors.black,
                                                    16.0,
                                                  ),
                                                ],
                                              )
                                        //
                                      ],
                                    ),
                                  ),
                                  //
                                ],
                              ),
                            ),
                          ),
                        ),
                      ], //
                      //
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                );
              }
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
            return Center(
                child: text_bold_comforta(
              'please wait...',
              Colors.black,
              14.0,
            ));
          }),
    );
  }

  //
  showEditEvent(snapshotWithIndex) async {
    //
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        /*title: text_bold_comforta(
          //
          '',
          Colors.black,
          18.0,
        ),*/
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditMyEventScreen(
                    getEventData: snapshotWithIndex,
                  ),
                ),
              );
            },
            child: text_bold_comforta('Edit', Colors.black, 14.0),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailsScreen(
                    getEventData: snapshotWithIndex,
                  ),
                ),
              );
            },
            child: text_bold_comforta('details', Colors.black, 14.0),
          ),
        ],
      ),
    );
  }
}
