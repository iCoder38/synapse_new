// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../screens/utils/utils.dart';

class SenderUIScreen extends StatefulWidget {
  const SenderUIScreen({super.key, this.getDataForSenderWithIndex});

  final getDataForSenderWithIndex;

  @override
  State<SenderUIScreen> createState() => _SenderUIScreenState();
}

class _SenderUIScreenState extends State<SenderUIScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: (widget.getDataForSenderWithIndex['message'].toString() == '')
              ? Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.transparent,
                  width: 240,
                  height: 240,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      24,
                    ),
                    child: Image.network(
                      widget.getDataForSenderWithIndex['sender_name']
                          .toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(
                    left: 40,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        16,
                      ),
                      bottomLeft: Radius.circular(
                        16,
                      ),
                      topRight: Radius.circular(
                        16,
                      ),
                    ),
                    color: Color.fromARGB(255, 228, 232, 235),
                  ),
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: text_bold_comforta(
                    widget.getDataForSenderWithIndex['message'].toString(),
                    Colors.black,
                    14.0,
                  ),
                ),
          /*Text(
                    //
                    widget.getDataForSenderWithIndex['message'].toString(),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),*/
        ),

        //
        Align(
          alignment: Alignment.bottomRight,
          child: text_bold_comforta(
            funcConvertTimeStampToDateAndTimeForChat(
              int.parse(
                  widget.getDataForSenderWithIndex['time_stamp'].toString()),
            ),
            Colors.black,
            8.0,
          ),
        ),
        //
      ],
    );
  }
}
