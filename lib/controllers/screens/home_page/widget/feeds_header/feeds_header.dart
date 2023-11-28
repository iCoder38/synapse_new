// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../my_settings/my_profile/my_profile.dart';
import '../../../utils/utils.dart';

class FeedsHeaderUIScreen extends StatefulWidget {
  const FeedsHeaderUIScreen({
    super.key,
    this.getDataForFeedsHeader,
  });

  final getDataForFeedsHeader;

  @override
  State<FeedsHeaderUIScreen> createState() => _FeedsHeaderUIScreenState();
}

class _FeedsHeaderUIScreenState extends State<FeedsHeaderUIScreen> {
  @override
  void initState() {
    // print(widget.getDataForFeedsHeader['timeStamp']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        top: 8.0,
      ),
      child: ListTile(
        leading: SizedBox(
          height: 50,
          width: 50,
          child: GestureDetector(
            onTap: () {
              //
              if (kDebugMode) {
                print('clicked on home page user profile image');
                print(widget.getDataForFeedsHeader['postEntityId'].toString());
              }
              //

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyProfileScreen(
                    strFirebaseId:
                        widget.getDataForFeedsHeader['postEntityId'].toString(),
                    strUsername: widget.getDataForFeedsHeader['postEntityName']
                        .toString(),
                  ),
                ),
              );
            },
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
        ),
        title: text_bold_comforta(
          widget.getDataForFeedsHeader['postEntityName'].toString(),
          Colors.black,
          18.0,
        ),
        subtitle: text_bold_comforta(
          widget.getDataForFeedsHeader['communityDetails']['communityName']
              .toString(),
          Colors.grey,
          12.0,
        ),
        trailing: text_bold_comforta(
          readTimestamp(
            int.parse(
              // '1698288800',
              widget.getDataForFeedsHeader['timeStamp'].toString(),
            ),
          ),
          Colors.black,
          8.0,
        ),
      ),
    );
  }

  //
}
//
 
