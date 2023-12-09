import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/foundation.dart';

import '../../screens/home_page/widget/feeds_text_image.dart';

enlargeSingleImage(context, imageName) {
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
