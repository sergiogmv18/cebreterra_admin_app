import 'package:flutter/material.dart';

/*
 * circular progress indicator
 * @author  SGV - 20230216
 * @version 1.0 - 20230216 - initial release
 * @return  <widget> 
 */
Widget circularProgressIndicator(BuildContext context) {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

/*
 * Show icon circular for expect loading next step 
 * @author  SGV - 20230216
 * @version 1.0 - 20230216 - initial release
 * @return  <component> showDialog and redirect to previous page
 */
Future<void> showCircularLoadingDialog(BuildContext context)async {  
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopScope(
        onPopInvoked: (v) => Future.value(false),
        child: circularProgressIndicator(context)
      );
    }
  );
}