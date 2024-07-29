import 'package:flutter/material.dart';

void customAlertDialog({
  required BuildContext context,
  required String msg,
  bool ok = true,
  void Function()? onPressed,
  void Function()? onPressedCancel,
}) async {
  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          content: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  msg,
                  style: const TextStyle(fontSize: 17),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: (ok)
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          side: WidgetStateProperty.all<BorderSide>(
                            const BorderSide(
                              width: 2.0,
                            ),
                          ),
                          elevation: WidgetStateProperty.all<double>(0),
                        ),
                        onPressed: () {
                          if (onPressedCancel != null) {
                            onPressedCancel();
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          (ok) ? 'CANCEL' : 'OK',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      (ok)
                          ? ElevatedButton(
                              style: ButtonStyle(
                                side: WidgetStateProperty.all<BorderSide>(
                                  const BorderSide(
                                    width: 2.0,
                                  ),
                                ),
                                elevation: WidgetStateProperty.all<double>(0),
                              ),
                              onPressed: onPressed,
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
}
