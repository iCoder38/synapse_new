// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class EventNameMembersScreen extends StatefulWidget {
  const EventNameMembersScreen(
      {super.key, this.getDataWithIndexForNameAndMembers});

  final getDataWithIndexForNameAndMembers;

  @override
  State<EventNameMembersScreen> createState() => _EventNameMembersScreenState();
}

class _EventNameMembersScreenState extends State<EventNameMembersScreen> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: text_bold_comforta(
        //,
        widget.getDataWithIndexForNameAndMembers['eventName'].toString(),
        Colors.black,
        16.0,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.getDataWithIndexForNameAndMembers['eventJoinedMembersId']
                  .length
                  .toString() ==
              '0') ...[
            //
            text_bold_comforta(
              //
              '${widget.getDataWithIndexForNameAndMembers['eventJoinedMembersId'].length} member',
              Colors.black,
              12.0,
            ),
          ] else if (widget
                  .getDataWithIndexForNameAndMembers['eventJoinedMembersId']
                  .length
                  .toString() ==
              '1') ...[
            //
            text_bold_comforta(
              //
              '${widget.getDataWithIndexForNameAndMembers['eventJoinedMembersId'].length} member',
              Colors.black,
              12.0,
            ),
          ] else ...[
            //
            text_bold_comforta(
              //
              '${widget.getDataWithIndexForNameAndMembers['eventJoinedMembersId'].length} members',
              Colors.black,
              12.0,
            ),
          ]
        ],
      ),
    );
  }
}
