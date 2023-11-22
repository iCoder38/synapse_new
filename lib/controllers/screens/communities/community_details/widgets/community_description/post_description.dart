// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class PostDescriptionUI extends StatefulWidget {
  const PostDescriptionUI({super.key, this.getCommunityPostDataForDescription});

  final getCommunityPostDataForDescription;

  @override
  State<PostDescriptionUI> createState() => PostDescriptionUIState();
}

class PostDescriptionUIState extends State<PostDescriptionUI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: ReadMoreText(
        //
        widget.getCommunityPostDataForDescription['textContent'].toString(),
        style: GoogleFonts.comfortaa(
          color: Colors.black,
          fontSize: 14.0,
        ),
        trimLines: 2,
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
      ),
    );
  }
}
