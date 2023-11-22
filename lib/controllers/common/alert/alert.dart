// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../screens/utils/utils.dart';

void showLoadingUI(BuildContext context, String message) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Flexible(
                child: SingleChildScrollView(
                  child: text_regular_roboto(
                    //
                    message,
                    //
                    Colors.black,
                    14.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void popUpAlert(BuildContext context, String message) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Flexible(
                child: SingleChildScrollView(
                  child: text_regular_roboto(
                    //
                    message,
                    //
                    Colors.black,
                    14.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        color: Colors.white30,
                        child: Center(
                          child: text_bold_comforta(
                            'Add more skills',
                            Colors.pinkAccent,
                            14.0,
                          ),
                        ),
                      ),
                    ),
                    //
                    GestureDetector(
                      onTap: () {
                        //
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        color: Colors.white30,
                        child: Center(
                          child: text_bold_comforta(
                            'Dismiss',
                            Colors.redAccent,
                            14.0,
                          ),
                        ),
                      ),
                    ),
                    //
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

//
void show_error_pop_up(BuildContext context, String message) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Flexible(
                child: SingleChildScrollView(
                  child: text_regular_roboto(
                    //
                    message,
                    //
                    Colors.black,
                    14.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
