import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:synapse_new/controllers/chat/dialog/dialog.dart';
import 'package:synapse_new/controllers/screens/communities/all_communitites/all_communities.dart';
import 'package:synapse_new/controllers/screens/events/all_events/all_events.dart';
import 'package:synapse_new/controllers/screens/home_page/home_page.dart';
import 'package:synapse_new/controllers/screens/synapse_ai/synapse_ai.dart';
// import 'package:synapse_new/controllers/screens/utils/utils.dart';

import '../common/alert/app_color/app_color.dart';
import '../screens/my_settings/main_profile_page.dart';

// lazy load index
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

//
class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  //
  final PageStorageBucket bucket = PageStorageBucket();
  int selectedIndex = 0;

  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 5;

// lazy index stack
  int lazyIndex = 0;
//
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  //
  final List<Widget> bottomBarPages = [
    const HomePageScreen(),
    const AllCommunitiesScreen(),
    const SynapseAIScreen(),
    // const AllEventsScreen(),
    const DialogScreen(),
    const MainProfilePageScreen(),
  ];
  //
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: LazyLoadIndexedStack(
          index: lazyIndex,
          children: const [
            HomePageScreen(),
            AllCommunitiesScreen(),
            SynapseAIScreen(),
            AllEventsScreen(),
            // DialogScreen(),
            MainProfilePageScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: home_page_bottom_tab_color(),
          onTap: (index) {
            setState(() => lazyIndex = index);
          },
          currentIndex: lazyIndex,
          items: [
            BottomNavigationBarItem(
              backgroundColor: home_page_bottom_tab_color(),
              // backgroundColor: Colors.white,
              icon: const Icon(
                Icons.feed,
                color: Colors.black,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: community_page_navigation_color(),
              icon: const Icon(
                Icons.people,
                color: Colors.black,
              ),
              label: 'Comms',
            ),
            /*BottomNavigationBarItem(
              backgroundColor: event_page_navigation_color(),
              icon: const Icon(
                Icons.event,
                color: Colors.black,
              ),
              label: 'Events',
            ),*/
            //
            BottomNavigationBarItem(
              backgroundColor: event_page_navigation_color(),
              icon: const Icon(
                Icons.smart_toy,
                color: Colors.black,
              ),
              label: 'AI',
            ),
            //
            BottomNavigationBarItem(
              backgroundColor: dialog_page_navigation_color(),
              icon: const Icon(
                Icons.event,
                color: Colors.black,
              ),
              label: 'Event',
            ),
            BottomNavigationBarItem(
              backgroundColor: profile_page_navigation_color(),
              icon: const Icon(
                Icons.group,
                color: Colors.black,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
