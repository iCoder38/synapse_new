// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class FeedsTextAndImageUIScreen extends StatefulWidget {
  const FeedsTextAndImageUIScreen(
      {super.key, required this.strType, this.getFeedsDataForTextAndImage});

  final String strType;
  final getFeedsDataForTextAndImage;

  @override
  State<FeedsTextAndImageUIScreen> createState() =>
      _FeedsTextAndImageUIScreenState();
}

class _FeedsTextAndImageUIScreenState extends State<FeedsTextAndImageUIScreen> {
  @override
  Widget build(BuildContext context) {
    return (widget.strType == 'text')
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: const EdgeInsets.only(
                left: 20.0,
                right: 10.0,
              ),
              // height: 240,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: ReadMoreText(
                //
                widget.getFeedsDataForTextAndImage['textContent'].toString(),
                //
                style: GoogleFonts.comfortaa(
                  color: Colors.black,
                  fontSize: 16.0,
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
          )
        : Padding(
            padding: const EdgeInsets.only(
              left: 14.0,
              right: 14.0,
            ),
            child: Container(
              height: 340,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(
                  14.0,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  14.0,
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.getFeedsDataForTextAndImage['postImageLink']
                      .toString(),
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const SizedBox(
                    height: 40,
                    width: 40,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
  }
}
