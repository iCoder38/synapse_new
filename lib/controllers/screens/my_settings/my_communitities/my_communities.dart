// import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:synapse_new/controllers/screens/communities/community_details/community_details.dart';

import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../../utils/utils.dart';

class MyCommunitiesScreen extends StatefulWidget {
  const MyCommunitiesScreen({super.key});

  @override
  State<MyCommunitiesScreen> createState() => _MyCommunitiesScreenState();
}

class _MyCommunitiesScreenState extends State<MyCommunitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_comforta(
          'My Communities',
          Colors.white,
          20.0,
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection(
              '$strFirebaseMode${FirestoreUtils.COMMUNITIES}/India/data',
            )
            //
            .orderBy('timeStamp', descending: false)
            .where(
              'communityAdminId',
              arrayContainsAny: [
                //
                FirebaseAuth.instance.currentUser!.uid.toString()
              ],
            )
            .limit(10)
            .get(),
        // .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (kDebugMode) {
              print('============================');
              print('===> TOTAL COMMUNITIES  <===');
            }

            var getSnapShopValue = snapshot.data!.docs.reversed.toList();
            if (kDebugMode) {
              print(getSnapShopValue.length);
              print('==================================');
            }
            //
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  for (int index = 0;
                      index < getSnapShopValue.length;
                      index++) ...[
                    GestureDetector(
                      onTap: () {
                        //
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommunityDetailsScreen(
                              getCommunityName:
                                  '${getSnapShopValue[index]['communityName']}',
                              getCommunityDetails:
                                  getSnapShopValue[index].data(),
                            ),
                          ),
                        );
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
                                    imageUrl: getSnapShopValue[index]
                                            ['communityImage']
                                        .toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Center(
                                          child: CircularProgressIndicator()),
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
                                  getSnapShopValue[index]['communityName']
                                      .toString(),
                                  Colors.black,
                                  18.0,
                                ),
                                subtitle: text_bold_comforta(
                                  getSnapShopValue[index]['adminName']
                                      .toString(),
                                  Colors.grey,
                                  12.0,
                                ),
                                trailing: text_bold_comforta(
                                  funcConvertTimeStampToDateAndTime(
                                    getSnapShopValue[index]['timeStamp'],
                                  ),
                                  Colors.grey,
                                  10.0,
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
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.pink,
            ),
          );
        },
      ),
    );
  }
}
