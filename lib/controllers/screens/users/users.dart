// import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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
  //
  var searchText = '';
  late Stream streamQuery;
//
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.amber,
              child: TextField(onChanged: (value) {
                if (kDebugMode) {
                  print(value);
                }
                searchText = value;
                setState(() {});
              }),
            ),
            searchText == ''
                ? FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    future: FirebaseFirestore.instance
                        .collection(
                          '$strFirebaseMode${FirestoreUtils.USERS}',
                        )
                        .orderBy('name')
                        .limit(20)
                        .get(),
                    builder: (_, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error = ${snapshot.error}');
                      }

                      if (snapshot.hasData) {
                        print('without search');
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
                                      strFirebaseId:
                                          data['firebaseId'].toString(),
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
                  )
                : FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    future: FirebaseFirestore.instance
                        .collection(
                          '$strFirebaseMode${FirestoreUtils.USERS}',
                        )
                        // .orderBy('name')
                        // .where('name', isGreaterThanOrEqualTo: searchText)
                        .where('searchPattern', arrayContains: searchText)
                        // .where('name', isGreaterThanOrEqualTo: 'nik')
                        // .where('name', isLessThan: 'm' 'z')
                        // .limit(20)
                        .get(),
                    builder: (_, snapshot2) {
                      if (snapshot2.hasError) {
                        return Text('Error = ${snapshot2.error}');
                      }

                      if (snapshot2.hasData) {
                        print('with search');
                        print(searchText);
                        final docs = snapshot2.data!.docs;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: docs.length,
                          itemBuilder: (_, i) {
                            final data2 = docs[i].data();
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
                                data2['name'],
                                Colors.black,
                                18.0,
                              ),
                              subtitle: text_bold_comforta(
                                data2['email'],
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
                                      strFirebaseId:
                                          data2['firebaseId'].toString(),
                                      strUsername: data2['name'].toString(),
                                      strBio: data2['bio'].toString(),
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
          ],
        ),
      ),
    );
  }
}
