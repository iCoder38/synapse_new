// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../community_image/post_image_ui.dart';
import '../community_like_comment/post_like_comment_ui.dart';
import 'post_headerr/post_header_ui.dart';

class CommunityPostUI extends StatefulWidget {
  const CommunityPostUI({
    super.key,
    this.getCommunityPostData,
    this.getCommunityData,
    // required this.indexNumber,
  });

  // final int indexNumber;
  final getCommunityData;
  final getCommunityPostData;

  @override
  State<CommunityPostUI> createState() => _CommunityPostUIState();
}

class _CommunityPostUIState extends State<CommunityPostUI> {
  @override
  void initState() {
    if (kDebugMode) {
      // print('========== CHECK ===============');
      // print(widget.getCommunityData);
      // print(widget.getCommunityPostData.length);
      // print('=================================');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            for (int index = 0;
                index < widget.getCommunityPostData.length;
                index++) ...[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: Column(
                  children: [
                    // ui : post header
                    PostHeaderUI(
                      indexNumber: index,
                      getPostData: widget.getCommunityPostData,
                      getCommunityPostDataForPostHeader:
                          widget.getCommunityData,
                    ),
                    // ui : image
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 6.0,
                        left: 14.0,
                        right: 14.0,
                      ),
                      child: PostImageUI(
                        getCommunityPostDataForPostImage:
                            widget.getCommunityPostData[index],
                      ),
                    ),
                    // ],
                    //
                    const SizedBox(
                      height: 0,
                    ),

                    // if (widget.getCommunityPostData[index]['postType'] ==
                    //     'text') ...[
                    //   //
                    // ] else ...[
                    // ui : Like and Comment
                    PostLikeCommentsUI(
                      indexNumber: index,
                      getCommunityPostDataForLikeComment:
                          widget.getCommunityPostData,
                    ),
                    //
                    // ],

                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 6,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
