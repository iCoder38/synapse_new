import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:synapse_new/controllers/screens/communities/community_details/community_details.dart';

import '../../utils/utils.dart';
import '../add_edit_community/add_community.dart';

class AllCommunitiesScreen extends StatefulWidget {
  const AllCommunitiesScreen({super.key});

  @override
  State<AllCommunitiesScreen> createState() => _AllCommunitiesScreenState();
}

class _AllCommunitiesScreenState extends State<AllCommunitiesScreen> {
  //
  final ScrollController _scrollController = ScrollController();
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: text_bold_comforta(
          'Communities',
          Colors.white,
          20.0,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                //
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddEditCommunityScreen(),
                  ),
                );
              },
              child: Container(
                height: 40,
                // width: 120,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: text_regular_comforta(
                      'Add Community',
                      Colors.black,
                      14.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     //
          //   },
          //   icon: const Icon(
          //     Icons.add,
          //   ),
          // ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(
                "${strFirebaseMode}communities/India/data",
              )
              .orderBy('timeStamp', descending: false)
              // .where(
              //   'room_id',
              //   whereIn: [
              //     '',
              //   ],
              // )
              .limit(40)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (kDebugMode) {
                print('=======================');
                print('====> YES, DATA 2 <====');
                print('=======================');
              }
              //
              // if (strScrollOnlyOneTime == '1') {
              //   _needsScroll = true;
              //   WidgetsBinding.instance
              //       .addPostFrameCallback((_) => _scrollToEnd());
              // }
              //

              var getSnapShopValue = snapshot.data!.docs.reversed.toList();
              if (kDebugMode) {
                print('object 1');
                print(getSnapShopValue);
                print('object 2');
              }

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    ListView.builder(
                      // controller: controller,
                      controller: _scrollController,
                      itemCount: getSnapShopValue.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              //
                              if (kDebugMode) {
                                print('==> you clicked community <==');
                              }
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
                            child: Card(
                              child: Column(
                                children: [
                                  Container(
                                    height: 220,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.transparent,
                                    child: (getSnapShopValue[index]
                                                    ['communityImage']
                                                .toString() ==
                                            '')
                                        ? Image.asset(
                                            'assets/app_icon.png',
                                            fit: BoxFit.cover,
                                          )
                                        : ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              12.0,
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
                                                    child:
                                                        CircularProgressIndicator()),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                    /*Image.network(
                                          getSnapShopValue[index]['communityImage']
                                              .toString(),
                                        ),*/
                                  ),
                                  ListTile(
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            12.0,
                                          ),
                                          border: Border.all()),
                                    ),
                                    title: text_bold_comforta(
                                      //
                                      '${getSnapShopValue[index]['communityName']}',
                                      Colors.black,
                                      18.0,
                                    ),
                                    subtitle: text_regular_comforta(
                                      //
                                      'Admin : ${getSnapShopValue[index]['adminName']}',
                                      Colors.black,
                                      14.0,
                                    ),
                                  ),
                                  //
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    //
                    const SizedBox(
                      height: 70.0,
                    ),
                    //
                  ],
                ),
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
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
