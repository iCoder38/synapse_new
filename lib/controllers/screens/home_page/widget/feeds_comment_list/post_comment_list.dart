// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../../../utils/utils.dart';

class PostCommentListUI extends StatefulWidget {
  const PostCommentListUI({super.key, this.getCommentData});

  // final int index;
  final getCommentData;
  // final

  @override
  State<PostCommentListUI> createState() => _PostCommentListUIState();
}

class _PostCommentListUIState extends State<PostCommentListUI> {
  @override
  void initState() {
    // printInDebugMode('rajput');
    // printInDebugMode(widget.getCommentData[0]['postCommentCount']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          for (int index = 0;
              index < widget.getCommentData.length;
              index++) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  leading: //
                      Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                    ),
                  ),
                  title: text_bold_roboto(
                    //
                    widget.getCommentData[index]['postUserName'].toString(),
                    Colors.black,
                    18.0,
                  ),
                  subtitle: ReadMoreText(
                    //
                    widget.getCommentData[index]['commentMessage'].toString(),
                    style: GoogleFonts.comfortaa(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                    trimLines: 4,
                    colorClickableText: Colors.pink,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: '...more',
                    trimExpandedText: '...less',
                    moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                    lessStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  )),
            ),
            //
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            )
          ],
        ],
      ),
    );
  }

  //
  // edit comment counts
  editCommentCountsInPostInFirebase() {
    //
  }
  //
}
