import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      PersonalInformationScreenState();
}

class PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final formKey = GlobalKey<FormState>();
  //
  late final TextEditingController contUserName;
  //
  @override
  void initState() {
    //
    contUserName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    contUserName.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0),
        title: text_bold_comforta(
          //
          'Personal Information',
          Colors.white,
          16.0,
        ),
        leading: IconButton(
          onPressed: () {
            //
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(
                top: 10.0,
              ),
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(
                  60.0,
                ),
              ),
            ),
          ),
          //
          const SizedBox(
            height: 80.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //
                Row(
                  children: [
                    text_bold_comforta(
                      'Name',
                      Colors.black,
                      14.0,
                    ),
                  ],
                ),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'name...',
                    labelText: FirebaseAuth.instance.currentUser!.displayName,
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
