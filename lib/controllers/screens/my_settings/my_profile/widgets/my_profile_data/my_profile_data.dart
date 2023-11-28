// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:synapse_new/controllers/screens/my_feeds/my_feeds.dart';

import '../../../../utils/utils.dart';
import '../../../my_communitities/my_communities.dart';

class MyProfileDataScreen extends StatefulWidget {
  const MyProfileDataScreen({
    Key? key,
    required this.getTotalCommunities,
    required this.getTotalFeeds,
    required this.getFirebaseId,
  }) : super(key: key);

  final String getTotalCommunities;
  final String getTotalFeeds;
  final String getFirebaseId;

  @override
  State<MyProfileDataScreen> createState() => _MyProfileDataScreenState();
}

class _MyProfileDataScreenState extends State<MyProfileDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyCommunitiesScreen(
                    communityAdminFirebaseId: widget.getFirebaseId,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              height: 80,

              // width: 120,
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
                    ), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 26,
                      width: 26,
                      // color: Colors.black,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: ExactAssetImage(
                            'assets/images/communities_icon.png',
                          ),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    //
                    const SizedBox(
                      height: 6,
                    ),
                    //
                    text_bold_comforta(
                      //
                      '${widget.getTotalCommunities} - communities',
                      Colors.black,
                      14.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        //
        Expanded(
          child: GestureDetector(
            onTap: () {
              //
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyFeedsScreen(
                    getAdminFirebaseId: widget.getFirebaseId,
                    // communityAdminFirebaseId: widget.getFirebaseId,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(
                // left: 10.0,
                right: 10.0,
              ),
              height: 80,

              // width: 120,
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
                    ), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 26,
                      width: 26,
                      // color: Colors.black,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: ExactAssetImage(
                            'assets/images/feeds_icon.png',
                          ),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    //
                    const SizedBox(
                      height: 6,
                    ),
                    //
                    text_bold_comforta(
                      //
                      '${widget.getTotalFeeds} - Feeds',
                      Colors.black,
                      14.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        //

        //
      ],
    );
  }
}
