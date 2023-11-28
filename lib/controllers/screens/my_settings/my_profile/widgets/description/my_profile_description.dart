// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class MyProfileDescriptionScreen extends StatefulWidget {
  const MyProfileDescriptionScreen({
    Key? key,
    required this.bio,
  }) : super(key: key);

  final String bio;

  @override
  State<MyProfileDescriptionScreen> createState() =>
      _MyProfileDescriptionScreenState();
}

class _MyProfileDescriptionScreenState
    extends State<MyProfileDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 260.0),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ReadMoreText(
          //
          widget.bio,
          //
          style: GoogleFonts.comfortaa(
            color: Colors.black,
            fontSize: 12.0,
          ),
          trimLines: 4,
          colorClickableText: Colors.pink,
          trimMode: TrimMode.Line,
          trimCollapsedText: '...Show more',
          trimExpandedText: '...Show less',
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
      ),
    );
  }
}
