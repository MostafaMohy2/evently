import 'package:evently/core/utils/build_context_extensions.dart';
import 'package:evently/core/utils/number_extensions.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  Future<void> showAlertDialog(
    BuildContext context, {
    String message = 'Loading',
    bool barierDismissable = true,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: barierDismissable,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              8.horizontalSpace,
              Text(message),
            ],
          ),
        );
      },
    );
  }

  Future<void> showActionDialog(
    BuildContext context, {
    String? message,
    String? title,
    String? postActionTitle,
    Future<void> Function()? postAction,
    Future<void> Function()? negativeAction,
    String? negativeActionTitle,
    bool barierDismissable = false,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: barierDismissable,
      builder: (context) => AlertDialog(
        title: title != null ? Text(title) : null,
        content: message != null ? Text(message) : null,
        actions: [
          if (postActionTitle != null)
            TextButton(
              onPressed: ()async {
                if (postAction != null) {
                context.pop();
                  await postAction();
                }
              },
              child: Text(postActionTitle),
            ),
          if (negativeActionTitle != null)
            TextButton(
              onPressed: ()async {
                 context.pop();
                if (negativeAction != null) {
                 await  negativeAction();
                }
              },
              child: Text(negativeActionTitle),
            ),
        ],
      ),
    );
  }
}
