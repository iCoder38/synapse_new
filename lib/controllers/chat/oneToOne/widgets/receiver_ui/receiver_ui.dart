// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../screens/utils/utils.dart';

class ReceiverUIScreen extends StatefulWidget {
  const ReceiverUIScreen({super.key, this.getDataForReceiverWithIndex});

  final getDataForReceiverWithIndex;

  @override
  State<ReceiverUIScreen> createState() => _ReceiverUIScreenState();
}

class _ReceiverUIScreenState extends State<ReceiverUIScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: (widget.getDataForReceiverWithIndex['message'].toString() ==
                  '')
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
                      widget.getDataForReceiverWithIndex['sender_name']
                          .toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(
                    right: 40,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        16,
                      ),
                      bottomRight: Radius.circular(
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
                  child: Text(
                    //
                    widget.getDataForReceiverWithIndex['message'].toString(),
                    //
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
        ),
        //
        Align(
          alignment: Alignment.bottomLeft,
          child: text_bold_comforta(
            funcConvertTimeStampToDateAndTimeForChat(
              widget.getDataForReceiverWithIndex['time_stamp'],
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
