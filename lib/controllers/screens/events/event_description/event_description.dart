// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../../utils/utils.dart';

class EventDescriptionUI extends StatefulWidget {
  const EventDescriptionUI({super.key, required this.getEventDescription});

  final String getEventDescription;

  @override
  State<EventDescriptionUI> createState() => _EventDescriptionUIState();
}

class _EventDescriptionUIState extends State<EventDescriptionUI> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: text_bold_roboto(
        'Description',
        Colors.black,
        16.0,
      ),
      subtitle: ReadMoreText(
        //
        widget.getEventDescription,

        style: GoogleFonts.comfortaa(
          color: Colors.black,
          fontSize: 14.0,
        ),
        trimLines: 4,
        colorClickableText: Colors.pink,
        trimMode: TrimMode.Line,
        trimCollapsedText: '...Show more',
        trimExpandedText: '...Show less',
        moreStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.pink,
        ),
        lessStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.pink,
        ),
      ),
    );
  }
}
