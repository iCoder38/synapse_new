// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class MyProfileResultScreen extends StatefulWidget {
  const MyProfileResultScreen({
    Key? key,
    required this.getTotalMarks,
    required this.getTotalAttendance,
  }) : super(key: key);

  final String getTotalMarks;
  final String getTotalAttendance;

  @override
  State<MyProfileResultScreen> createState() => _MyProfileResultScreenState();
}

class _MyProfileResultScreenState extends State<MyProfileResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
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
                          'assets/images/result_icon.png',
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
                    '${widget.getTotalMarks}% marks',
                    Colors.black,
                    14.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        //
        Expanded(
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
                    height: 28,
                    width: 28,
                    // color: Colors.black,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: ExactAssetImage(
                          'assets/images/attendance_icon.png',
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
                    '${widget.getTotalAttendance}% attendance',
                    Colors.black,
                    14.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        //
      ],
    );
  }
}
