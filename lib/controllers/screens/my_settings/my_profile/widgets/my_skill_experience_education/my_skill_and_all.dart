// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:synapse_new/controllers/screens/my_settings/add_edit_education/add_edit_education.dart';
import 'package:synapse_new/controllers/screens/my_settings/all_education/all_education.dart';
import 'package:synapse_new/controllers/screens/my_settings/all_experiences/all_experience.dart';

import 'package:synapse_new/controllers/screens/my_settings/all_skills/all_skills.dart';

import '../../../../utils/utils.dart';
import '../../../add_edit_experience/add_experience.dart';

class MySkillAndAllScreen extends StatefulWidget {
  const MySkillAndAllScreen({
    Key? key,
    required this.getFirebaseIdFromUser,
    required this.getDocumentIdFromProfile,
  }) : super(key: key);

  final String getFirebaseIdFromUser;
  final String getDocumentIdFromProfile;

  @override
  State<MySkillAndAllScreen> createState() => _MySkillAndAllScreenState();
}

class _MySkillAndAllScreenState extends State<MySkillAndAllScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Container(
            height: 120,

            // width: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                12.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(
                    0,
                    3,
                  ), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllSkillsScreen(
                            strFirebaseId: widget.getFirebaseIdFromUser,
                            strGetDocumentId: widget.getDocumentIdFromProfile,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 44,
                      width: 44,
                      // color: Colors.black,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: ExactAssetImage(
                            'assets/images/skills.png',
                          ),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  //
                  text_bold_comforta(
                    'Skills',
                    Colors.black,
                    14.0,
                  ),
                ],
              ),
              //
            ),
          ),
        ),
        //
        const SizedBox(
          width: 8.0,
        ),
        //
        Expanded(
          child: Container(
            height: 120,

            // width: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                12.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(
                    0,
                    3,
                  ), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllExperienceScreen(
                            strGetDocumentId: widget.getDocumentIdFromProfile,
                            strFirebaseId: widget.getFirebaseIdFromUser,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 44,
                      width: 44,
                      // color: Colors.black,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: ExactAssetImage(
                            'assets/images/experience.png',
                          ),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  //
                  const SizedBox(
                    height: 6,
                  ),
                  //
                  text_bold_comforta(
                    'Experiences',
                    Colors.black,
                    14.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        //
        const SizedBox(
          width: 8.0,
        ),
        //
        Expanded(
          child: Container(
            height: 120,

            // width: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                12.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(
                    0,
                    3,
                  ), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllEducationScreen(
                            strGetDocumentId: widget.getDocumentIdFromProfile,
                            strFirebaseId: widget.getFirebaseIdFromUser,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 44,
                      width: 44,
                      // color: Colors.black,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: ExactAssetImage(
                            'assets/images/education.png',
                          ),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  //
                  const SizedBox(
                    height: 6,
                  ),
                  //
                  text_bold_comforta(
                    'Education',
                    Colors.black,
                    14.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        //
        const SizedBox(
          width: 8.0,
        ),
      ],
    );
  }
}
