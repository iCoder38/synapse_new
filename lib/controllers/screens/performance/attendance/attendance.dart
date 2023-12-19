import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:synapse_new/controllers/screens/utils/utils.dart';

import '../../../common/app_bar/app_bar.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  //
  int segmentedControlGroupValue = 0;
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("Today"),
    1: Text("Week"),
    2: Text("Month"),
    3: Text("Year"),
  };
  var strStaus = '1';
  //
  var arrToday = [
    {
      'subject': 'Maths',
      'total_classes': '2',
      'total_attend': '1',
    },
    {
      'subject': 'English',
      'total_classes': '1',
      'total_attend': '1',
    },
    {
      'subject': 'Chemistry',
      'total_classes': '1',
      'total_attend': '1',
    },
    {
      'subject': 'Physics',
      'total_classes': '2',
      'total_attend': '1',
    }
  ];
  @override
  Widget build(BuildContext context) {
    //
    Size size = MediaQuery.of(context).size;
    //
    return Scaffold(
      appBar: const AppBarScreen(
        navigationTitle: 'Attendance',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CupertinoSlidingSegmentedControl(
                  groupValue: segmentedControlGroupValue,
                  children: myTabs,
                  onValueChanged: (i) {
                    setState(() {
                      segmentedControlGroupValue = i!;
                    });
                  }),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text_bold_comforta(
                    'Total Classes : ',
                    Colors.black,
                    14.0,
                  ),
                  //
                  text_bold_comforta(
                    '120',
                    Colors.black,
                    18.0,
                  ),
                  //
                  text_bold_comforta(
                    ' || Class Attend : ',
                    Colors.black,
                    14.0,
                  ),
                  //
                  text_bold_comforta(
                    '65',
                    Colors.black,
                    18.0,
                  ),
                  //
                ],
              ),
            ),

            Expanded(
              // Added
              child: Container(
                width: size.width,
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      for (int i = 0; i < arrToday.length; i++) ...[
                        ListTile(
                          title: text_bold_roboto(
                            arrToday[i]['subject'].toString(),
                            Colors.black,
                            20.0,
                          ),
                          subtitle: Row(
                            children: [
                              text_bold_comforta(
                                arrToday[i]['total_attend'].toString(),
                                Colors.black,
                                16.0,
                              ),
                              text_bold_comforta(
                                ' out of ',
                                Colors.black,
                                16.0,
                              ),
                              text_bold_roboto(
                                arrToday[i]['total_classes'].toString(),
                                Colors.black,
                                18.0,
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                      ],
                      //

                      //
                      /*ListTile(
                        title: text_bold_roboto(
                          'English',
                          Colors.black,
                          20.0,
                        ),
                        subtitle: Row(
                          children: [
                            text_bold_comforta(
                              '15',
                              Colors.black,
                              16.0,
                            ),
                            text_bold_comforta(
                              ' out of ',
                              Colors.black,
                              16.0,
                            ),
                            text_bold_roboto(
                              ' 24',
                              Colors.black,
                              18.0,
                            ),
                          ],
                        ),
                      ),
                      //
                      const Divider(),
                      //
                      ListTile(
                        title: text_bold_roboto(
                          'Science',
                          Colors.black,
                          20.0,
                        ),
                        subtitle: Row(
                          children: [
                            text_bold_comforta(
                              '6',
                              Colors.black,
                              16.0,
                            ),
                            text_bold_comforta(
                              ' out of ',
                              Colors.black,
                              16.0,
                            ),
                            text_bold_roboto(
                              ' 24',
                              Colors.black,
                              18.0,
                            ),
                          ],
                        ),
                      ),
                      //
                      const Divider(),
                      //
                      ListTile(
                        title: text_bold_roboto(
                          'Computer',
                          Colors.black,
                          20.0,
                        ),
                        subtitle: Row(
                          children: [
                            text_bold_comforta(
                              '11',
                              Colors.black,
                              16.0,
                            ),
                            text_bold_comforta(
                              ' out of ',
                              Colors.black,
                              16.0,
                            ),
                            text_bold_roboto(
                              ' 24',
                              Colors.black,
                              18.0,
                            ),
                          ],
                        ),
                      ),
                      //
                      const Divider(),
                      //
                      ListTile(
                        title: text_bold_roboto(
                          'Chemistry',
                          Colors.black,
                          20.0,
                        ),
                        subtitle: Row(
                          children: [
                            text_bold_comforta(
                              '19',
                              Colors.black,
                              16.0,
                            ),
                            text_bold_comforta(
                              ' out of ',
                              Colors.black,
                              16.0,
                            ),
                            text_bold_roboto(
                              ' 24',
                              Colors.black,
                              18.0,
                            ),
                          ],
                        ),
                      ),*/
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    /**/
  }
}
