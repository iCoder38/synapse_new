// ignore_for_file: non_constant_identifier_names, avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/bar_bottom/bottom_bar.dart';
import '../controllers/common/alert/alert.dart';
import '../controllers/firebase_modals/firebase_auth_modals/firebase_auth_modals.dart';
import '../controllers/firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../controllers/screens/login/login.dart';
import '../controllers/screens/utils/utils.dart';

class RegisterScreeen extends StatefulWidget {
  const RegisterScreeen({super.key});

  @override
  State<RegisterScreeen> createState() => _RegisterScreeenState();
}

class _RegisterScreeenState extends State<RegisterScreeen> {
  final bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  String verificationCode = "";
  bool _obscureText = true;

  // AuthService authService = AuthService();

  //
  final create_an_user_model = Fib_Auth();
  //
  late final TextEditingController contFullName;
  late final TextEditingController contEmail;
  late final TextEditingController contPassword;
  //
  var arrSaveSearchPatternForName = [];
  var arrSaveSearchPatternForEmail = [];
  //
  @override
  void initState() {
    //
    contFullName = TextEditingController();
    contEmail = TextEditingController();
    contPassword = TextEditingController();
    //
    FirebaseAuth.instance.signOut();
    //
    super.initState();
  }

  @override
  void dispose() {
    //
    contFullName.dispose();
    contEmail.dispose();
    contPassword.dispose();
    //
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 50, right: 20),
                        child: Image.asset("assets/images/register_screen.png",
                            fit: BoxFit.fill,
                            height: MediaQuery.of(context).size.height * 0.375,
                            width: MediaQuery.of(context).size.width * 1),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(37, 204, 204, 204),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                controller: contFullName,
                                maxLength: 25,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(18.0),
                                  hintText: 'Full Name',
                                  prefixIcon: Icon(Icons.person),
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'Comfortaa',
                                      fontSize: 12),
                                  counterText: '',
                                  counterStyle: TextStyle(fontSize: 0),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    fullName = val;
                                  });
                                },
                                validator: (val) {
                                  return null;

                                  /*return ref
                                      .read(authControllerProvider)
                                      .nameValidator(val!);*/
                                },
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(37, 204, 204, 204),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                controller: contEmail,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(18.0),
                                  hintText: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'Comfortaa',
                                      fontSize: 12),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                                validator: (val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val!)
                                      ? null
                                      : "Please enter a valid email";
                                },
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(37, 204, 204, 204),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                controller: contPassword,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(18.0),
                                  hintText: 'Password',
                                  prefixIcon: GestureDetector(
                                    onTap: _togglePasswordVisibility,
                                    child: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'Comfortaa',
                                      fontSize: 12),
                                ),
                                validator: (val) {
                                  if (val!.length < 8) {
                                    return "Password must be at least 8 characters";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            GestureDetector(
                              onTap: (() {
                                // create user action clicked
                                if (kDebugMode) {
                                  print('====> CREATE AN USER CLICKED <====');
                                }
                                //
                                // for name
                                String temp = "";
                                arrSaveSearchPatternForName.clear();
                                for (int i = 0;
                                    i < contFullName.text.length;
                                    i++) {
                                  //
                                  temp = temp + contFullName.text[i];

                                  arrSaveSearchPatternForName.add(temp);
                                }
                                print(arrSaveSearchPatternForName);
                                contFullName.text.replaceAll(' ', '');
                                arrSaveSearchPatternForName
                                    .add(contFullName.text.replaceAll(' ', ''));
                                print('2');
                                print(arrSaveSearchPatternForName);
                                //
                                //
                                // for email
                                //
                                String temp2 = "";

                                for (int i = 0;
                                    i < contEmail.text.length;
                                    i++) {
                                  //
                                  temp2 = temp2 + contEmail.text[i];

                                  arrSaveSearchPatternForName.add(temp2);
                                }
                                // print(arrSaveSearchPatternForName);
                                contEmail.text.replaceAll(' ', '');
                                arrSaveSearchPatternForName
                                    .add(contEmail.text.replaceAll(' ', ''));
                                print('2');
                                print(arrSaveSearchPatternForName);
                                // remove multiple data from array
                                var ids = [1, 4, 4, 4, 5, 6, 6];
                                var distinctIds = arrSaveSearchPatternForName
                                    .toSet()
                                    .toList();
                                arrSaveSearchPatternForName = distinctIds;
                                // done all pattern
                                showLoadingUI(
                                  context,
                                  str_alert_please_wait,
                                );
                                FirebaseAuth.instance
                                    .signOut()
                                    .then((value) => {
                                          register_user_with_fib(),
                                        });
                              }),
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(
                                    81,
                                    191,
                                    166,
                                    1,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    12.0,
                                  ),
                                ),
                                child: Center(
                                  child: text_bold_roboto(
                                    'Sign Up',
                                    Colors.white,
                                    16.0,
                                  ),
                                ),
                              ),
                            )
                            /*Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                  onPressed: registerButtonClicked,
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                            ),*/
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Center(
                        child: Text(
                          "Or",
                          style: GoogleFonts.comfortaa(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontSize: 11),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      /*Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/google.png",
                              fit: BoxFit.fill, height: 30, width: 30),
                          const SizedBox(width: 10.0),
                          Image.asset("assets/line.png",
                              fit: BoxFit.fill, height: 43, width: 3),
                          const SizedBox(width: 10.0),
                          Image.asset("assets/facebook.png",
                              fit: BoxFit.fill, height: 30, width: 30),
                        ],
                      ),*/
                      const SizedBox(height: 50.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: GoogleFonts.comfortaa(
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                fontSize: 11),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            },
                            child: Text(
                              "Login",
                              style: GoogleFonts.comfortaa(
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
    );
  }

  //************* CREATE AN USER WITH FIREBASE **********************
  //*****************************************************************
  register_user_with_fib() async {
    //
    print(contPassword.text.length);
    if (contPassword.text.length <= 7) {
      // dismiss popup
      Navigator.pop(context);

      var snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: text_regular_roboto(
          //
          func_handle_error('password_length_eight'),
          Colors.white,
          14.0,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: contEmail.text.toString(),
              password: contPassword.text.toString(),
            )
            .then((value) => {
                  //

                  func_update_login_user_name_in_fib(
                    contFullName.text.toString(),
                  ),
                  //
                });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          if (kDebugMode) {
            print('The password provided is too weak.');
          }
          //
          Navigator.pop(context);
          // return_response = '1';
          var snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: text_regular_roboto(
              //
              'The password provided is too weak.',
              Colors.white,
              14.0,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //
        } else if (e.code == 'email-already-in-use') {
          if (kDebugMode) {
            print('The account already exists for that email.');
          }
          //
          Navigator.pop(context);
          var snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: text_regular_roboto(
              //
              'The account already exists for that email.',
              Colors.white,
              14.0,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
          //
          Navigator.pop(context);
          var snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: text_regular_roboto(
              //
              func_handle_error(e),
              Colors.white,
              14.0,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
      /*create_an_user_model
          .func_create_an_user_with_fib(contEmail.text, contPassword.text)
          .then((value) {
        if (kDebugMode) {
          print('=================================================');
          print('======> RESPONSE : CREATE USER <=======');
          print('=================================================');
          print(value);
        }

        //
        if (value.toString() != '1' && value.toString() != '2') {
          print('========================================================');
          print('======> RESPONSE : SUCCESSFULLY REGISTERED <=======');
          print('=======================================================');
          // update display name
          func_update_login_user_name_in_fib(
            contFullName.text.toString(),
          );
          //
        } else {
          print('=====================================================');
          print('==> FIREBASE ERROR : CREATE AN USER <==');
          print('=====================================================');
          // dismiss popup
          Navigator.pop(context);

          var snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: text_regular_roboto(
              //
              func_handle_error(value),
              Colors.white,
              14.0,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });*/
    }
  }

  //************* UPDATE LOGIN USER NAME IN FIREBASE ******************
  //*****************************************************************
  func_update_login_user_name_in_fib(login_user_name) {
    //
    FirebaseAuth.instance.currentUser!
        .updateDisplayName(login_user_name)
        .then((value) => {
              //
              print('''************************************** 
              SUCCESSFULLY REGISTERED ( FiB )
              - E - mail and Password. 
              - Updated Display Name. 
              *********************************************'''),

              addLoginUsersCount(),
            });
  }

  //*****************************************************************
  //*****************************************************************
  /*registerButtonClicked() async {
    if (formKey.currentState!.validate()) {
      email = email.toLowerCase();
      await ref
          .read(authControllerProvider)
          .signUpUserWithEmailPassword(fullName, email, password)
          .then((response) {
        if (response.statusCode == 200) {
          // dismiss popup
          Navigator.pop(context);
        } else if (response.statusCode == 202) {
          // dismiss popup
          Navigator.pop(context);
          showSnackbar(context, appPrimaryColor, response.message);
          nextScreenWithArguments(context, EmailVerification.routeName, {
            'email': email,
            'fullName': fullName,
            "newPassword": password,
          });
        } else {
          showSnackbar(context, Colors.red, response.message);
        }
      });
    }
  }*/
  addLoginUsersCount() {
    //
    saveLoginUserDataInFirebase();
    // setProfileDataForNewOrFirstTimeUserAfterLogin();
  }

  //
  setProfileDataForNewOrFirstTimeUserAfterLogin() {
    print('vedica');

    FirebaseFirestore.instance
        .collection(
          // '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA_COUNTS}/${FirestoreUtils.LOGIN_USER_FIREBASE_ID}/data',
          '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA_COUNTS}/${FirebaseAuth.instance.currentUser!.uid}/data',
        )
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.docs);
      }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('======> NO USER FOUND in HOME SCREEN <========');
        }
        CollectionReference users = FirebaseFirestore.instance.collection(
          '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA_COUNTS}/${FirebaseAuth.instance.currentUser!.uid}/data',
        );

        users
            .add(
              {
                'skillCount': '0',
                'experienceCount': '0',
                'educationCount': '0',
                'communityCount': '0',
                'feedCount': '0',
                'marks': '0',
                'attendance': '0',
                'eventCount': '0',
              },
            )
            .then(
              (value) =>
                  //
                  addDocumentIdForNewId(
                value.id,
              ),
            )
            .catchError(
              (error) => print("Failed to add user: $error"),
            );
      } else {
        if (kDebugMode) {
          print('======> Yes, USER FOUND in HOME SCREEN <========');
        }
        for (var element in value.docs) {
          if (kDebugMode) {
            print(element.id);
          }
          //
        }
      }
    });
  }

  addDocumentIdForNewId(elementId) {
    //
    if (kDebugMode) {
      print('============================');
      print('add document id in new user');
      print('============================');
    }

    FirebaseFirestore.instance
        .collection(
          '$strFirebaseMode${FirestoreUtils.USER_FULL_DATA_COUNTS}/${FirebaseAuth.instance.currentUser!.uid}/data',
        )
        .doc(elementId)
        .set(
      {
        'documentId': elementId,
      },
      SetOptions(merge: true),
    ).then(
      (value1) {
        // dismiss popup
        saveLoginUserDataInFirebase();
      },
    );
  }
  //

  //
  saveLoginUserDataInFirebase() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    //
    //
    FirebaseFirestore.instance
        .collection(
          '$strFirebaseMode${FirestoreUtils.USERS_COLLECTION}',
        )
        .where(
          'firebaseId',
          isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString(),
        )
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.docs);
      }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('======> NO USER FOUND');
        }

        //
        CollectionReference users = FirebaseFirestore.instance.collection(
          '$strFirebaseMode${FirestoreUtils.USERS}/data/${FirebaseAuth.instance.currentUser!.uid}',
        );

        users
            .add(
              {
                'active': 'no',
                'email': FirebaseAuth.instance.currentUser!.email,
                'firebaseId': FirebaseAuth.instance.currentUser!.uid,
                'profiledisplayImage': '',
                'name': FirebaseAuth.instance.currentUser!.displayName,
                'timeStamp': DateTime.now().millisecondsSinceEpoch,
                'verify': FirebaseAuth.instance.currentUser!.emailVerified,
                'profileType': 'Student',
                'bio': '',
                //
                'countSkill': '0',
                'countExperience': '0',
                'countEducation': '0',
                'countCommunity': '0',
                'countFeed': '0',
                'countMarks': '0',
                'countAttendance': '0',
                'countEvent': '0',
                //
                'searchPattern': arrSaveSearchPatternForName

                //
              },
            )
            .then(
              (value) => FirebaseFirestore.instance
                  .collection(
                    '$strFirebaseMode${FirestoreUtils.USERS}/data/${FirebaseAuth.instance.currentUser!.uid}',
                  )
                  // .doc('India')
                  //.collection('data')
                  .doc(value.id)
                  .set(
                {
                  'documentId': value.id,
                  'deviceToken': '',
                },
                SetOptions(merge: true),
              ).then(
                (value1) {
                  // push
                  // pushToHomePage();
                  Navigator.pop(context);
                  Navigator.pop(context);
                  //
                },
              ),
            )
            .catchError(
              (error) => print("Failed to add user: $error"),
            );
        //
      } else {
        for (var element in value.docs) {
          if (kDebugMode) {
            print(element.id);
            // print(element.data());
          }
          //
          saveNamePatternForSearch();
          // pushToHomePage();
        }
      }
    });
  }

  saveNamePatternForSearch() {
    //
    Navigator.pop(context);
    Navigator.pop(context);
  }

  //
  pushToHomePage() {
    //
    Navigator.push(
      context,
      MaterialPageRoute(
        // builder: (context) => const HomeFeedScreen(),
        builder: (context) => const BottomBarScreen(),
      ),
    );
  }
}
