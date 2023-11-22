import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:synapse_new/controllers/screens/communities/all_communitites/all_communities.dart';
import 'package:synapse_new/controllers/screens/events/all_events/all_events.dart';
import 'package:synapse_new/controllers/screens/home_page/home_page.dart';
import 'package:synapse_new/controllers/screens/utils/utils.dart';

import '../screens/my_settings/main_profile_page.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  //
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  /// widget list
  final List<Widget> bottomBarPages = [
    const HomePageScreen(),
    const AllCommunitiesScreen(),
    const AllEventsScreen(),
    const MainProfilePageScreen(),

    // const Page2(),
    // const Page3(),
    // const Page4(),
    // const Page5(),
  ];
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          bottomBarPages.length,
          (index) => bottomBarPages[index],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        /// Provide NotchBottomBarController
        notchBottomBarController: _controller,
        color: Colors.white,
        showLabel: false,
        notchColor: Colors.black87,

        /// restart app if you change removeMargins
        removeMargins: false,
        bottomBarWidth: 200,
        durationInMilliSeconds: 300,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.home_filled,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.home_filled,
              color: Colors.blueAccent,
            ),
            itemLabel: 'Page 1',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.group,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.group,
              color: Colors.blueAccent,
            ),
            itemLabel: 'Page 2',
          ),

          ///svg example
          // BottomBarItem(
          //   inActiveItem: Image.asset(
          //     'assets/search_icon.svg',
          //     color: Colors.blueGrey,
          //   ),
          //   activeItem: Image.asset(
          //     'assets/search_icon.svg',
          //     color: Colors.white,
          //   ),
          //   itemLabel: 'Page 3',
          // ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.event,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.event,
              color: Colors.pink,
            ),
            itemLabel: 'Page 4',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.person,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.person,
              color: Colors.yellow,
            ),
            itemLabel: 'Page 5',
          ),
        ],
        onTap: (index) {
          /// perform action on tab change and to update pages you can update pages without pages
          // log('current selected index $index');
          if (kDebugMode) {
            print('current selected index $index');
          }
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
