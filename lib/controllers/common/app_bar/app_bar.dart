// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:synapse_new/controllers/screens/notifications/notifications.dart';

import '../../chat/dialog/dialog.dart';
import '../../screens/utils/utils.dart';
import '../alert/app_color/app_color.dart';
// import 'package:pludin/classes/header/utils.dart';

class AppBarScreen extends StatelessWidget implements PreferredSizeWidget {
  final String navigationTitle;
  @override
  final Size preferredSize;

  const AppBarScreen({
    Key? key,
    required this.navigationTitle,
  })  : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (navigationTitle == 'Home') {
      return AppBar(
        title: text_bold_comforta(
          //
          navigationTitle,
          Colors.black,
          20.0,
        ),
        automaticallyImplyLeading: false,
        actions: [
          //
          IconButton(
            onPressed: () {
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DialogScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.chat_outlined,
              size: 24.0,
            ),
          ),
          //
          IconButton(
            onPressed: () {
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications_none_rounded,
              size: 26.0,
            ),
          ),
        ],
      );
    } else if (navigationTitle == 'Dialog') {
      return AppBar(
        title: text_bold_comforta(
          navigationTitle,
          Colors.black,
          20.0,
        ),
        backgroundColor: dialog_page_navigation_color(),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 26.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // automaticallyImplyLeading: false,
      );
    } else if (navigationTitle == 'Notifications') {
      return AppBar(
        title: text_bold_comforta(
          navigationTitle,
          Colors.black,
          20.0,
        ),
        backgroundColor: dialog_page_navigation_color(),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 26.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // automaticallyImplyLeading: false,
      );
    } else if (navigationTitle == 'Followers') {
      return AppBar(
        title: text_bold_comforta(
          navigationTitle,
          Colors.black,
          20.0,
        ),
        backgroundColor: dialog_page_navigation_color(),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 26.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // automaticallyImplyLeading: false,
      );
    } else if (navigationTitle == 'my_communities') {
      return AppBar(
        title: text_bold_comforta(
          'My Communities',
          Colors.black,
          20.0,
        ),
        backgroundColor: dialog_page_navigation_color(),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 26.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // automaticallyImplyLeading: false,
      );
    } else if (navigationTitle == 'edit_community') {
      return AppBar(
        title: text_bold_comforta(
          'Edit',
          Colors.black,
          20.0,
        ),
        backgroundColor: dialog_page_navigation_color(),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 26.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // automaticallyImplyLeading: false,
      );
    } else {
      return AppBar(
        title: text_bold_comforta(
          navigationTitle,
          Colors.white,
          20.0,
        ),
        backgroundColor: dialog_page_navigation_color(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // automaticallyImplyLeading: false,
      );
    }

    /*if (backClick == '0') {
      return AppBar(
        title: text_bold_comforta(
          navigationTitle,
          Colors.white,
          20.0,
        ),
        // backgroundColor: navigationColor,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        automaticallyImplyLeading: false,
      );
    } else if (backClick == '1') {
      return AppBar(
        title: text_bold_comforta(
          navigationTitle,
          Colors.white,
          20.0,
        ),
        // backgroundColor: navigationColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
      );
    } else {
      return AppBar(
        title: text_bold_comforta(
          navigationTitle,
          Colors.white,
          20.0,
        ),
        // backgroundColor: navigationColor,
        // leading: IconButton(
        //   icon: const Icon(Icons.menu),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        actions: [
          IconButton(
            onPressed: () {
              if (kDebugMode) {
                print('object');
              }
            },
            icon: const Icon(
              Icons.notifications,
            ),
          )
        ],
        automaticallyImplyLeading: true,
      );
    }*/
  }
}
