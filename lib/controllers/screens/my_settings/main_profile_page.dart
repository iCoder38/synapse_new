// import 'dart:js_util';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:connectingstudents/features/home/presentation/widgets/drawer_widget.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:synapse_new/controllers/screens/my_settings/my_profile/my_profile.dart';

import '../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../utils/utils.dart';
import 'my_communitities/my_communities.dart';

class MainProfilePageScreen extends StatefulWidget {
  const MainProfilePageScreen({super.key});

  @override
  State<MainProfilePageScreen> createState() => _MainProfilePageScreenState();
}

class _MainProfilePageScreenState extends State<MainProfilePageScreen> {
  //
  var strlogout = '0';
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: text_bold_comforta(
          'Profile',
          Colors.white,
          22.0,
        ),
        /*leading: IconButton(
          onPressed: () {
            //
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),*/
      ),
      // drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ListTile(
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
              ),
              title: text_regular_comforta(
                FirestoreUtils.LOGIN_USER_NAME,
                Colors.black,
                16.0,
              ),
              subtitle: text_regular_comforta(
                'How others will see your profile',
                Colors.black38,
                12.0,
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.black,
              ),
              onTap: () {
                //

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyProfileScreen(),
                  ),
                );
              },
            ),
            //

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(
                  Icons.money,
                  color: Colors.amber,
                ),
                title: text_regular_comforta(
                  'Premium membership',
                  Colors.black,
                  16.0,
                ),
                subtitle: text_regular_comforta(
                  'Why premium ?',
                  Colors.grey,
                  12.0,
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.black54,
                ),
                onTap: () {
                  //
                },
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  text_bold_comforta(
                    'My Data',
                    // 'Communities / Posts / Events',
                    Colors.black,
                    24.0,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.people,
                color: Colors.amber,
              ),
              title: text_regular_comforta(
                'My Communities',
                Colors.black,
                16.0,
              ),
              // subtitle: text_regular_comforta(
              //   'You can manage your communities',
              //   Colors.grey,
              //   12.0,
              // ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.black54,
              ),
              onTap: () {
                //

                //
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyCommunitiesScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.feed,
                color: Colors.amber,
              ),
              title: text_regular_comforta(
                'My Posts',
                Colors.black,
                16.0,
              ),
              // subtitle: text_regular_comforta(
              //   'why activate this plan ?',
              //   Colors.grey,
              //   12.0,
              // ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.black54,
              ),
              onTap: () {
                //
              },
            ),
            //
            //
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  text_bold_comforta(
                    'Settings',
                    // 'Communities / Posts / Events',
                    Colors.black,
                    24.0,
                  ),
                ],
              ),
            ),
            //
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.amber,
              ),
              title: text_regular_comforta(
                'Personal information',
                Colors.black,
                16.0,
              ),
              // subtitle: text_regular_comforta(
              //   'why activate this plan ?',
              //   Colors.grey,
              //   12.0,
              // ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.black54,
              ),
              onTap: () {
                //
              },
            ),
            //
            ListTile(
              leading: const Icon(
                Icons.payment,
                color: Colors.amber,
              ),
              title: text_regular_comforta(
                'Payments',
                Colors.black,
                16.0,
              ),
              // subtitle: text_regular_comforta(
              //   'why activate this plan ?',
              //   Colors.grey,
              //   12.0,
              // ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.black54,
              ),
              onTap: () {
                //
              },
            ),
            //
            ListTile(
              leading: const Icon(
                Icons.notifications,
                color: Colors.amber,
              ),
              title: text_regular_comforta(
                'Notifications',
                Colors.black,
                16.0,
              ),
              // subtitle: text_regular_comforta(
              //   'why activate this plan ?',
              //   Colors.grey,
              //   12.0,
              // ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.black54,
              ),
              onTap: () {
                //
              },
            ),
            //
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  text_bold_comforta(
                    'About',
                    // 'Communities / Posts / Events',
                    Colors.black,
                    24.0,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.policy,
                color: Colors.amber,
              ),
              title: text_regular_comforta(
                'About Us',
                Colors.black,
                16.0,
              ),
              // subtitle: text_regular_comforta(
              //   'why activate this plan ?',
              //   Colors.grey,
              //   12.0,
              // ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.black54,
              ),
              onTap: () {
                //
              },
            ),
            //
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  text_bold_comforta(
                    'Support',
                    // 'Communities / Posts / Events',
                    Colors.black,
                    24.0,
                  ),
                ],
              ),
            ),
            //
            ListTile(
              leading: const Icon(
                Icons.email,
                color: Colors.amber,
              ),
              title: text_regular_comforta(
                'Email',
                Colors.black,
                16.0,
              ),
              subtitle: text_regular_comforta(
                'Feel free to contact us. Our team will help you within 24 hours.',
                Colors.grey,
                12.0,
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.black54,
              ),
              onTap: () {
                //
              },
            ),
            //
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  text_bold_comforta(
                    'Legal',
                    // 'Communities / Posts / Events',
                    Colors.black,
                    24.0,
                  ),
                ],
              ),
            ),
            //
            //
            ListTile(
              leading: const Icon(
                Icons.policy,
                color: Colors.amber,
              ),
              title: text_regular_comforta(
                'Disclaimer',
                Colors.black,
                16.0,
              ),
              // subtitle: text_regular_comforta(
              //   'why activate this plan ?',
              //   Colors.grey,
              //   12.0,
              // ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.black54,
              ),
              onTap: () {
                //
              },
            ),
            //
            //
            ListTile(
              leading: const Icon(
                Icons.policy,
                color: Colors.amber,
              ),
              title: text_regular_comforta(
                'Privacy',
                Colors.black,
                16.0,
              ),
              // subtitle: text_regular_comforta(
              //   'why activate this plan ?',
              //   Colors.grey,
              //   12.0,
              // ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.black54,
              ),
              onTap: () {
                //
              },
            ),
            //
            //
            ListTile(
              leading: const Icon(
                Icons.policy,
                color: Colors.amber,
              ),
              title: text_regular_comforta(
                'Terms',
                Colors.black,
                16.0,
              ),
              // subtitle: text_regular_comforta(
              //   'why activate this plan ?',
              //   Colors.grey,
              //   12.0,
              // ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.black54,
              ),
              onTap: () {
                //
              },
            ),
            //
            //
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  text_bold_comforta(
                    '2 - Step authentication',
                    // 'Communities / Posts / Events',
                    Colors.black,
                    24.0,
                  ),
                ],
              ),
            ),
            //
            ListTile(
              leading: const Icon(
                Icons.face,
                color: Colors.amber,
              ),
              title: text_regular_comforta(
                'Face / Finger Id',
                Colors.black,
                16.0,
              ),
              // subtitle: text_regular_comforta(
              //   'why activate this plan ?',
              //   Colors.grey,
              //   12.0,
              // ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.black54,
              ),
              onTap: () {
                //
              },
            ),
            //
            ListTile(
              leading: const Icon(
                Icons.face,
                color: Colors.amber,
              ),
              title: text_regular_comforta(
                'Number code',
                Colors.black,
                16.0,
              ),
              subtitle: text_regular_comforta(
                'Always enter the code when you open the app.',
                Colors.grey,
                12.0,
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.black54,
              ),
              onTap: () {
                //
              },
            ),
            //
            //
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  text_bold_comforta(
                    'Feedback',
                    // 'Communities / Posts / Events',
                    Colors.black,
                    24.0,
                  ),
                ],
              ),
            ),
            //
            ListTile(
              leading: const Icon(
                Icons.edit,
                color: Colors.amber,
              ),
              title: text_regular_comforta(
                'Give us feedback',
                Colors.black,
                16.0,
              ),
              subtitle: text_regular_comforta(
                'Please help us to improve.',
                Colors.grey,
                12.0,
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.black54,
              ),
              onTap: () {
                //
              },
            ),
            //
            const Padding(
              padding: EdgeInsets.all(2.0),
              child: Divider(
                color: Colors.black,
              ),
            ),
            //
            (strlogout == '3')
                ? Column(
                    children: [
                      const CircularProgressIndicator(),
                      //
                      const SizedBox(
                        height: 6.0,
                      ),
                      text_regular_comforta(
                        'Logging out',
                        Colors.black,
                        14.0,
                      )
                    ],
                  )
                : (strlogout == '0')
                    ? Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: GestureDetector(
                          onTap: () {
                            //
                            // signOut();
                            setState(() {
                              strlogout = '1';
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              text_bold_comforta(
                                'logout',
                                // 'Communities / Posts / Events',
                                Colors.red,
                                14.0,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          text_bold_comforta(
                            'Are you sure you want to logout ?',
                            Colors.black,
                            16.0,
                          ),
                          //
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  //
                                  setState(() {
                                    strlogout = '3';
                                  });
                                  signOut();
                                },
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(
                                      12.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: text_regular_comforta(
                                      'Yes, Logout',
                                      Colors.white,
                                      14.0,
                                    ),
                                  ),
                                ),
                              ),
                              //
                              const SizedBox(
                                width: 12.0,
                              ),
                              //
                              GestureDetector(
                                onTap: () {
                                  //
                                  setState(() {
                                    strlogout = '0';
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.greenAccent,
                                    borderRadius: BorderRadius.circular(
                                      12.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: text_bold_comforta(
                                      'Stay',
                                      Colors.black,
                                      14.0,
                                    ),
                                  ),
                                ),
                              ),
                              //
                            ],
                          ),
                        ],
                      ),
            const Padding(
              padding: EdgeInsets.all(2.0),
              child: Divider(
                color: Colors.black,
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  text_bold_comforta(
                    'Deactivate',
                    // 'Communities / Posts / Events',
                    Colors.black,
                    24.0,
                  ),
                ],
              ),
            ),
            //

            ListTile(
              leading: const Icon(
                Icons.face,
                color: Colors.amber,
              ),
              title: text_bold_comforta(
                'De-activate',
                Colors.redAccent,
                16.0,
              ),
              subtitle: text_regular_comforta(
                'If you use this feature your account will be de-activated and all of your data will be removed permanently.',
                Colors.grey,
                12.0,
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.black54,
              ),
              onTap: () {
                //
              },
            ),
            //
            const SizedBox(
              height: 80.0,
            ),
          ],
        ),
      ),
    );
  }

  //
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
//
}
