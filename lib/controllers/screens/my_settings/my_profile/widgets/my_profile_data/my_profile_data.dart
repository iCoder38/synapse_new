import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class MyProfileDataScreen extends StatefulWidget {
  const MyProfileDataScreen({super.key});

  @override
  State<MyProfileDataScreen> createState() => _MyProfileDataScreenState();
}

class _MyProfileDataScreenState extends State<MyProfileDataScreen> {
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
                    '7 - Communities',
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
                    '120 - Feeds',
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
