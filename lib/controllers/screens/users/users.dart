// import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../common/alert/app_color/app_color.dart';
import '../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../my_settings/my_profile/my_profile.dart';
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
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
        ),
        backgroundColor: community_page_navigation_color(),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection(
              '$strFirebaseMode${FirestoreUtils.USERS}',
            )
            .orderBy('name')
            // .where('firebaseId', isEqualTo: widget.getAllFollowersId[i])
            .limit(20)
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return Text('Error = ${snapshot.error}');
          }

          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: docs.length,
              itemBuilder: (_, i) {
                final data = docs[i].data();
                return ListTile(
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(
                        20.0,
                      ),
                    ),
                  ),
                  title: text_bold_comforta(
                    data['name'],
                    Colors.black,
                    18.0,
                  ),
                  subtitle: text_bold_comforta(
                    data['email'],
                    Colors.black,
                    12.0,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      //
                    },
                    icon: const Icon(
                      Icons.chevron_right,
                    ),
                  ),
                  onTap: () {
                    //
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyProfileScreen(
                          strFirebaseId: data['firebaseId'].toString(),
                          strUsername: data['name'].toString(),
                          strBio: data['bio'].toString(),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }

          return const SizedBox(
            height: 0,
          );
        },
      ),
    );
  }
}
