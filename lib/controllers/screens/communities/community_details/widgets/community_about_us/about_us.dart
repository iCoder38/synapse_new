// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../../../../utils/utils.dart';

class CommunityAmoutUsScreen extends StatefulWidget {
  const CommunityAmoutUsScreen({super.key, this.getCommunityDetailsForAboutUs});

  final getCommunityDetailsForAboutUs;

  @override
  State<CommunityAmoutUsScreen> createState() => _CommunityAmoutUsScreenState();
}

class _CommunityAmoutUsScreenState extends State<CommunityAmoutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            height: 260,
            // width: 100,
            color: Colors.transparent,
            child: (widget.getCommunityDetailsForAboutUs['communityImage']
                        .toString() ==
                    '')
                ? Image.asset(
                    'assets/app_icon.png',
                    fit: BoxFit.fill,
                  )
                : CachedNetworkImage(
                    imageUrl: widget
                        .getCommunityDetailsForAboutUs['communityImage']
                        .toString(),
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                    ),
                  ),
          ),
          // ui : admin name and all
          showAdminPersonalDataUI(),

          // ui : likes and count
          /*Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
                border: Border.all(
                  width: 0.4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: text_regular_roboto(
                        //
                        'Like : ${widget.getCommunityDetailsForAboutUs['likesCount'].toString()}',
                        Colors.black,
                        14.0,
                      ),
                    ),
                  ),
                  //
                  Container(
                    height: 34,
                    width: 0.4,
                    color: Colors.black,
                  ),
                  //
                  Expanded(
                    child: Center(
                      child: text_regular_roboto(
                        //
                        'Followers : ${widget.getCommunityDetailsForAboutUs['followersCount'].toString()}',
                        Colors.black,
                        14.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),*/
          // ui : about us
          aboutUsUI(context),
        ],
      ),
    );
  }

  Column showAdminPersonalDataUI() {
    return Column(
      children: [
        ListTile(
          leading: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                12.0,
              ),
              border: Border.all(
                width: 0.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: (widget.getCommunityDetailsForAboutUs['adminProfilePicture']
                        .toString() ==
                    '')
                ? SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      'assets/apple.png',
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget
                          .getCommunityDetailsForAboutUs['adminProfilePicture']
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
          title: text_bold_roboto(
            'Admin : ${widget.getCommunityDetailsForAboutUs['adminName'].toString()}',
            Colors.black,
            16.0,
          ),
          subtitle: text_bold_roboto(
            'Email : ${widget.getCommunityDetailsForAboutUs['adminEmail'].toString()}',
            Colors.blueAccent,
            12.0,
          ),
        ),
      ],
    );
  }

  Container aboutUsUI(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10.0,
        top: 0.0,
        bottom: 10.0,
        right: 10.0,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          12.0,
        ),
        border: Border.all(
          width: 0.4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      // height: 220,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ReadMoreText(
          //
          widget.getCommunityDetailsForAboutUs['communityAbout'],
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
    );
  }
}
