// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
          funcConvertTimeStampToDateAndTime(
            widget.getDataForFeedsHeader['timeStamp'],
          ),
          Colors.grey,
          10.0,
        ),
      ),
    );
  }
}
