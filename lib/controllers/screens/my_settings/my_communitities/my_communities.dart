// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:readmore/readmore.dart';
import 'package:synapse_new/controllers/common/app_bar/app_bar.dart';

import 'package:synapse_new/controllers/screens/communities/community_details/community_details.dart';
import 'package:synapse_new/controllers/screens/my_settings/edit_my_community/edit_my_community.dart';

import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../utils/utils.dart';

class MyCommunitiesScreen extends StatefulWidget {
  const MyCommunitiesScreen({
    Key? key,
    required this.communityAdminFirebaseId,
  }) : super(key: key);

  final String communityAdminFirebaseId;

  @override
  State<MyCommunitiesScreen> createState() => _MyCommunitiesScreenState();
}

class _MyCommunitiesScreenState extends State<MyCommunitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return LazyLoadIndexedStack(
      index: 0,
      children: [
        Scaffold(
          appBar: const AppBarScreen(navigationTitle: 'my_communities'),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(
                  '$strFirebaseMode${FirestoreUtils.COMMUNITIES}',
                )
                //
                .orderBy('timeStamp', descending: false)
                .where(
                  'communityAdminId',
                  arrayContainsAny: [
                    //
                    widget.communityAdminFirebaseId.toString(),
                  ],
                )
                .limit(10)
                .snapshots(),
            // .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (kDebugMode) {
                  print('============================');
                  print('===> TOTAL COMMUNITIES  <===');
                }

                var getSnapShopValueCommunities =
                    snapshot.data!.docs.reversed.toList();
                if (kDebugMode) {
                  print(getSnapShopValueCommunities.length);
                  print('==================================');
                }
                //
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      for (int index = 0;
                          index < getSnapShopValueCommunities.length;
                          index++) ...[
                        GestureDetector(
                          onTap: () {
                            //
                            communityPopup(
                                context,
                                getSnapShopValueCommunities[index],
                                getSnapShopValueCommunities[index].data(),
                                getSnapShopValueCommunities[index]
                                        ['communityName']
                                    .toString());
                            /* 
                           Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommunityDetailsScreen(
                      getCommunityName:
                          '${getSnapShopValue[index]['communityName']}',
                      getCommunityDetails: getSnapShopValue[index].data(),
                    ),
                  ),
                );
                */
                          },
                          child: Container(
                            // height: 240,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(
                                12.0,
                              ),
                            ),
                            child: Column(
                              children: [
                                //
                                const SizedBox(
                                  height: 20.0,
                                ),
                                // Image
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 14.0,
                                    right: 14.0,
                                  ),
                                  child: Container(
                                    height: 340,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[500],
                                      borderRadius: BorderRadius.circular(
                                        14.0,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        14.0,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            getSnapShopValueCommunities[index]
                                                    ['communityImage']
                                                .toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                                //
                                // feeds header
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    top: 8.0,
                                  ),
                                  child: ListTile(
                                    leading: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          25.0,
                                        ),
                                        child: Image.network(
                                          dummy_image_url,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    title: text_bold_comforta(
                                      getSnapShopValueCommunities[index]
                                              ['communityName']
                                          .toString(),
                                      Colors.black,
                                      18.0,
                                    ),
                                    subtitle: text_bold_comforta(
                                      getSnapShopValueCommunities[index]
                                              ['adminName']
                                          .toString(),
                                      Colors.grey,
                                      12.0,
                                    ),
                                    trailing: text_bold_comforta(
                                      readTimestamp(
                                        int.parse(
                                          getSnapShopValueCommunities[index]
                                                  ['timeStamp']
                                              .toString(),
                                        ),
                                      ),
                                      Colors.black,
                                      8.0,
                                    ),
                                  ),
                                ),
                                //
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Row(
                                //     children: [
                                //       Container(
                                //         height: 34.0,
                                //         // width: 80.0,
                                //         decoration: BoxDecoration(
                                //           color: Colors.transparent,
                                //           border: Border.all(
                                //             width: 0.4,
                                //           ),
                                //           borderRadius: BorderRadius.circular(
                                //             22.0,
                                //           ),
                                //         ),
                                //         child: Padding(
                                //           padding: const EdgeInsets.all(8.0),
                                //           child: Center(
                                //             child: Row(
                                //               children: [
                                //                 text_bold_comforta(
                                //                   'likes : ',
                                //                   Colors.black,
                                //                   14.0,
                                //                 ),
                                //                 text_bold_comforta(
                                //                   //,
                                //                   ' ${getSnapShopValue[index]['likesCount']}',
                                //                   Colors.black,
                                //                   12.0,
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //       //
                                //       const SizedBox(
                                //         width: 10.0,
                                //       ),
                                //       //
                                //       Container(
                                //         height: 34.0,
                                //         // width: 80.0,
                                //         decoration: BoxDecoration(
                                //           color: Colors.transparent,
                                //           border: Border.all(
                                //             width: 0.4,
                                //           ),
                                //           borderRadius: BorderRadius.circular(
                                //             22.0,
                                //           ),
                                //         ),
                                //         child: Padding(
                                //           padding: const EdgeInsets.all(8.0),
                                //           child: Center(
                                //             child: Row(
                                //               children: [
                                //                 text_bold_comforta(
                                //                   'comments : ',
                                //                   Colors.black,
                                //                   14.0,
                                //                 ),
                                //                 text_bold_comforta(
                                //                   //,
                                //                   ' ${getSnapShopValue[index]['likesCount']}',
                                //                   Colors.black,
                                //                   12.0,
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //       //
                                //     ],
                                //   ),
                                // ),
                                //
                              ],
                            ),
                          ),
                        ),
                        // like comment and share
                        // userLiked
                        // likeCommentUIandService(
                        //   context,
                        //   getSnapShopValue,
                        //   index,
                        //   true,
                        // ),
                        //
                        Container(
                          height: 6,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey[500],
                        ),
                      ],
                      //
                    ],
                  ),
                );
                //
              } else if (snapshot.hasError) {
                if (kDebugMode) {
                  print(snapshot.error);
                }
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.pink,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  //
  void communityPopup(BuildContext context, data, snapshotWithIndex,
      snapshotWithCommunityName) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        // title: const Text('Camera option'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditMyCommunityScreen(
                    getCommunityFullData: data.data(),
                    // getCommunityName: snapshotWithCommunityName,
                    // getCommunityDetails: snapshotWithIndex,
                  ),
                ),
              );
              //
            },
            child: text_bold_comforta('edit', Colors.black, 14.0),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommunityDetailsScreen(
                    getCommunityName: snapshotWithCommunityName,
                    getCommunityDetails: snapshotWithIndex,
                  ),
                ),
              );
              //
            },
            child: text_bold_comforta('details', Colors.black, 14.0),
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
    );
  }
}
