import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:synapse_new/controllers/screens/communities/community_details/community_details.dart';
import 'package:synapse_new/controllers/screens/communities/community_followers/community_followers.dart';
import 'package:synapse_new/controllers/screens/users/users.dart';

import '../../../common/alert/app_color/app_color.dart';
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
          16.0,
        ),
        backgroundColor: community_page_navigation_color(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                //
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddEditCommunityScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                //
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AllUsersScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.people_outline,
                color: Colors.black,
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
      /*floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          //
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditCommunityScreen(),
            ),
          );
          //
        },
        child: const Icon(Icons.edit),
      ),*/
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ),
                ),
                // child: ,
              ),
            ),*/
            //
            allCommunityStreamBuilderWithUI(),
          ],
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>
      allCommunityStreamBuilderWithUI() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
              "${strFirebaseMode}communities",
            )
            .orderBy('timeStamp', descending: false)
            .limit(20)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (kDebugMode) {
              // print('=======================');
              // print('====> YES, DATA 2 <====');
              // print('=======================');
            }

            var getSnapShopValue = snapshot.data!.docs.reversed.toList();
            if (kDebugMode) {
              // print('object 1');
              // print(getSnapShopValue);
              // print('object 2');
            }

            return Column(
              children: [
                ListView.builder(
                  // controller: controller,
                  controller: _scrollController,
                  itemCount: getSnapShopValue.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 0, bottom: 10),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(0.0),
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
                                          errorWidget: (context, url, error) =>
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
                                trailing: GestureDetector(
                                  onTap: () {
                                    //
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CommunityFollowersScreen(
                                                getCommunityId:
                                                    getSnapShopValue[index]
                                                            ['communityId']
                                                        .toString(),
                                                getAllFollowersId:
                                                    getSnapShopValue[index]
                                                        ['followers']),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 44,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        12.0,
                                      ),
                                      border: Border.all(
                                        width: 0.2,
                                      ),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color:
                                      //         Colors.grey.withOpacity(0.5),
                                      //     spreadRadius: 5,
                                      //     blurRadius: 7,
                                      //     offset: const Offset(0,
                                      //         3), // changes position of shadow
                                      //   ),
                                      // ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        text_bold_comforta(
                                          //
                                          getSnapShopValue[index]['followers']
                                              .length,
                                          Colors.black,
                                          16.0,
                                        ),
                                        text_bold_comforta(
                                          'followers',
                                          Colors.black,
                                          12.0,
                                        ),
                                      ],
                                    ),
                                  ),
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
                /*const SizedBox(
                  height: 70.0,
                ),*/
                //
              ],
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
        });
  }
}
