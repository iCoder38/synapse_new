// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:synapse_new/controllers/screens/utils/utils.dart';

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
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: ReadMoreText(
                      //
                      widget.getFeedsDataForTextAndImage['textContent']
                          .toString(),
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
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(
              left: 14.0,
              right: 14.0,
            ),
            child: Column(
              children: [
                //
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        child: ReadMoreText(
                          //
                          widget.getFeedsDataForTextAndImage['textContent']
                              .toString(),
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
                      ),
                    ),
                  ],
                ),
                //
                const SizedBox(
                  height: 8.0,
                ),
                //
                GestureDetector(
                  onTap: () {
                    //
                    funcOpenImage(widget
                        .getFeedsDataForTextAndImage['postImageLink']
                        .toString());
                  },
                  /*child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      16.0,
                    ),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: BlurHash(
                        hash: 'LCF=HA039V=^01~9D+NH?FR+E.R*',
                        imageFit: BoxFit.cover,
                        image: widget
                            .getFeedsDataForTextAndImage['postImageLink']
                            .toString(),
                      ),
                    ),
                  ),*/
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
                        imageUrl: widget
                            .getFeedsDataForTextAndImage['postImageLink']
                            .toString(),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const SizedBox(
                          height: 40,
                          width: 40,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  // click to enlarge image
  funcOpenImage(imageName) {
    if (kDebugMode) {
      // print(imageName);
    }
    //
    List<String> saveClickedImage = [];
    saveClickedImage.add(imageName);

    CustomImageProvider customImageProvider = CustomImageProvider(
        //
        imageUrls: saveClickedImage.toList(),
        //
        initialIndex: 0);
    showImageViewerPager(context, customImageProvider, doubleTapZoomable: true,
        onPageChanged: (page) {
      // print("Page changed to $page");
    }, onViewerDismissed: (page) {
      // print("Dismissed while on page $page");
    });
  }
}

class CustomImageProvider extends EasyImageProvider {
  @override
  final int initialIndex;
  final List<String> imageUrls;

  CustomImageProvider({required this.imageUrls, this.initialIndex = 0})
      : super();

  @override
  ImageProvider<Object> imageBuilder(BuildContext context, int index) {
    return NetworkImage(imageUrls[index]);
  }

  @override
  int get imageCount => imageUrls.length;
}
