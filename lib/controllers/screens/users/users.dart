// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../common/alert/app_color/app_color.dart';
import '../utils/utils.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: text_bold_comforta(
          'Users',
          Colors.white,
          16.0,
        ),
        leading: IconButton(
          onPressed: () {
            //
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
        ),
        backgroundColor: community_page_navigation_color(),
      ),
    );
  }
}
