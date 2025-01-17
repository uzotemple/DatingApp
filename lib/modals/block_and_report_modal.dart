import 'package:flutter/material.dart';

import 'package:love_bird/homeScreen/notification.dart';

void showSmallPopup(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true, // Dismiss when tapped outside
    barrierLabel: 'Dismiss',
    barrierColor: Colors.transparent, // Add a background overlay
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation1, animation2) {
      return Align(
        alignment: Alignment.topRight, // Align the dialog to the right
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.13,
              horizontal: MediaQuery.of(context).size.width * .07,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width *
                  0.4, // Set the width of your popup

              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () {
                          showBlockPopup(context);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.block,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            const SizedBox(width: 5),
                            Text('Block',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ))
                          ],
                        )),
                    Divider(
                        thickness: 2,
                        color: Theme.of(context).textTheme.bodyMedium?.color),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/reportPage');
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.report,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            const SizedBox(width: 5),
                            Text('Report',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ))
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation1, animation2, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: const Offset(0, 0),
        ).animate(animation1),
        child: child,
      );
    },
  );
}
