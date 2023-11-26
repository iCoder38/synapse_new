// ignore_for_file: non_constant_identifier_names, prefer_final_fields, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synapse_new/register/register.dart';

import '../../bar_bottom/bottom_bar.dart';
import '../../common/alert/alert.dart';
import '../../firebase_modals/firebase_auth_modals/firebase_auth_modals.dart';
import '../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //
  final login_via_fib_model = Fib_Auth();
  late final TextEditingController contEmail;
  late final TextEditingController contPassword;
  //
  final formKey = GlobalKey<FormState>();
  //
  String email = "";
  String password = "";
  bool _isLoading = false;
  bool _obscureText = true;
  //
  @override
  void initState() {
    //
    contEmail = TextEditingController();
    contPassword = TextEditingController();
    //
    // funcGetDeviceToken();
    super.initState();
  }

  @override
  void dispose() {
    //
    contEmail.dispose();
    contPassword.dispose();
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 164, 215),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getTopBackgroundImageWidget(),
            Container(
              padding: const EdgeInsets.all(14.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextFormField(
                        controller: contEmail,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(18.0),
                          hintText: 'Email...',
                          prefixIcon: Icon(Icons.email_outlined),
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Comfortaa',
                              fontSize: 14),
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
                    getPasswordInputFieldWidget(),
                    const SizedBox(height: 10.0),
                    // sign in button
                    getSignInButtonWidget(context),
                    //
                    const SizedBox(
                      height: 10.0,
                    ),
                    //
                    GestureDetector(
                      onTap: () {
                        //
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // builder: (context) => const HomeFeedScreen(),
                            builder: (context) => const RegisterScreeen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(254, 226, 202, 1),
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                        ),
                        child: Center(
                          child: text_bold_roboto(
                            'Sign up',
                            Colors.black,
                            16.0,
                          ),
                        ),
                      ),
                    ),
                    //
                    // ui : forgot password button
                    // getForgotPasswordButtonWidgetUI(context),
                    // ui : create an account
                    // getCreateAnAccountButtonWidgetUI(context),

                    //
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // getForgotPasswordButtonWidget(),
                        getLoginbuttonWidget(),
                      ],
                    ),*/
                    const SizedBox(height: 30.0),
                    // getSignUpRedirectButtonWidget()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector getSignInButtonWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //
        // func_login_via_fib();
        loginViaFirebase();
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(254, 226, 202, 1),
          borderRadius: BorderRadius.circular(
            12.0,
          ),
        ),
        child: Center(
          child: text_bold_roboto(
            'Sign In',
            Colors.black,
            16.0,
          ),
        ),
      ),
    );
  }

  Widget getPasswordInputFieldWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
              _obscureText ? Icons.visibility_off : Icons.visibility,
              size: 23,
            ),
          ),
          hintStyle: const TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontFamily: 'Comfortaa',
              fontSize: 14),
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
    );
  }

//********************** LOGIN WITH FIREBASE **********************
//*****************************************************************

  loginViaFirebase() async {
    //
    showLoadingUI(context, str_alert_please_wait);
    //
    if (kDebugMode) {
      print(''' 
    ************************************************************
    ** START **
    Login Via Firebase
    ************************************************************
    ''');
    }

    // login_via_fib_model
    login_via_fib_model
        .signInUserFiB(contEmail.text.toString(), contPassword.text.toString())
        .then((value) {
      //
      if (kDebugMode) {
        print('=================================================');
        print('================ LOGIN FiB Response =============');
        print(value);
        print('=================================================');
        print('=================================================');
      }
      //
      if (value.toString() == '3') {
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
      } else {
        // dismiss popup
        Navigator.pop(context);
        if (kDebugMode) {
          print('**************************************');
          print('SUCCESSFULLY LOGGED IN ( FiB )');
          print('**************************************');
        }
        //
        // loginButtonClicked();
        saveLoginUserDataInFirebase();
      }
    });
  }

//*****************************************************************
//*****************************************************************

  //
  Widget getTopBackgroundImageWidget() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.625,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.asset(
              "assets/images/login_page.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  //
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //
  saveLoginUserDataInFirebase() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
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
          '$strFirebaseMode${FirestoreUtils.USERS}',
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
                'profileType': '',

                //
              },
            )
            .then(
              (value) => FirebaseFirestore.instance
                  .collection(
                    '$strFirebaseMode${FirestoreUtils.USERS}',
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
                  pushToHomePage();
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
          pushToHomePage();
          /*FirebaseFirestore.instance
              .collection(
                '$strFirebaseMode${FirestoreUtils.USERS}',
              )
              // .doc('India')
              //.collection('data')
              .doc(element.id)
              .set(
            {
              'documentId': element.id,
              'deviceToken': preferences.getString('deviceToken'),
            },
            SetOptions(merge: true),
          ).then(
            (value1) {
              // dismiss popup
              Navigator.push(
                context,
                MaterialPageRoute(
                  // builder: (context) => const HomeFeedScreen(),
                  builder: (context) => const BottomBarScreen(),
                ),
              );
            },
          );*/
        }
      }
    });
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
