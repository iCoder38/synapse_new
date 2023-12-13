// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:synapse_new/controllers/common/app_bar/app_bar.dart';
import 'package:synapse_new/controllers/screens/utils/utils.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  //
  bool selected = false;
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarScreen(navigationTitle: 'Notifications'),
      body: GestureDetector(
        onTap: () {
          setState(() {
            selected = !selected;
          });
        },
        child: (selected == true)
            ? AnimatedContainer(
                // width: selected ? 200.0 : 100.0,
                // height: selected ? 100.0 : 200.0,
                width: MediaQuery.of(context).size.width,
                height: 400,
                color: selected ? Colors.red : Colors.blue,
                alignment: selected
                    ? Alignment.center
                    : AlignmentDirectional.topCenter,
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                child: ListTile(
                  title: text_bold_comforta(
                    'dishu',
                    Colors.black,
                    14.0,
                  ),
                ))
            : AnimatedContainer(
                // width: selected ? 200.0 : 100.0,
                // height: selected ? 100.0 : 200.0,
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: selected ? Colors.red : Colors.blue,
                alignment: selected
                    ? Alignment.center
                    : AlignmentDirectional.topCenter,
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                child: ListTile(
                  title: text_bold_comforta(
                    'dishu',
                    Colors.black,
                    14.0,
                  ),
                )),
      ),
    );
  }
}
