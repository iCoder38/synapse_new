import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class MyProfileDescriptionScreen extends StatefulWidget {
  const MyProfileDescriptionScreen({super.key});

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
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
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
