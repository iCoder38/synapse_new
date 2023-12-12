// import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../common/alert/app_color/app_color.dart';
import '../utils/utils.dart';
import 'package:http/http.dart' as http;

import 'ai_utils/ai_utils.dart';

class SynapseAIScreen extends StatefulWidget {
  const SynapseAIScreen({super.key});

  @override
  State<SynapseAIScreen> createState() => _SynapseAIScreenState();
}

class _SynapseAIScreenState extends State<SynapseAIScreen> {
  //
  var strLoader = '0';
  var strSaveAnswer = '0';
  TextEditingController contQuestion = TextEditingController();
  //
  @override
  void initState() {
    //
    contQuestion = TextEditingController();
    //
    // check();
    super.initState();
  }

  @override
  void dispose() {
    contQuestion.dispose();
    super.dispose();
  }

  check() async {
    //
    if (kDebugMode) {
      print('=====> POST : SYNAPSE - AI <===== ');
    }

    final resposne = await http.post(
      Uri.parse(
        aiBaseURL,
      ),
      headers: <String, String>{
        'content-type': 'application/json',
        'X-RapidAPI-Key': aiRapidApiKey,
        'X-RapidAPI-Host': aihost,
      },
      body: jsonEncode(
        <String, dynamic>{
          'query': contQuestion.text.toString(),
        },
      ),
    );

    // convert data to dict
    var data = jsonDecode(resposne.body);
    if (kDebugMode) {
      print(data);
    }
    strSaveAnswer = data['response'];
    setState(() {});
    /*if (resposne.statusCode == 200) {
      if (data['status'].toString().toLowerCase() == 'success') {
        //
        // join();
        strSaveAnswer = data;
        //
      } else {
        if (kDebugMode) {
          print(
            '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
          );
        }
      }
    } else {
      // return postList;
    }*/
  }

  //
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: text_bold_comforta(
          'Ask me anything',
          Colors.black,
          20.0,
        ),
        //
        backgroundColor: home_page_bottom_tab_color(),
        //
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: contQuestion,
                obscureText: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ask me anything',
                    hintText: 'Ask me anything...'),
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                //
                check();
              },
              child: Container(
                height: 50,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: text_bold_comforta(
                      'Search',
                      Colors.black,
                      16.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              // Added
              child: Container(
                width: size.width,
                color: Colors.transparent,
                child: Column(
                  children: [
                    Expanded(
                      // Added
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: text_bold_comforta(
                            //
                            strSaveAnswer,
                            Colors.black,
                            14.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      /*Column(
        children: [
          
          //
          
          
 
        ],
      ),*/
    );
  }
}
