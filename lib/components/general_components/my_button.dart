import 'package:buzz_chat/theme/theme.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String msg;
  final Function()? onTap;
  final EdgeInsets? padding;
  const MyButton(
      {super.key, required this.onTap, required this.msg, this.padding});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: (padding == null)
              ? const EdgeInsets.symmetric(vertical: 20, horizontal: 40)
              : padding,
          // margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: isDarkMode ? AppTheme.darkButtonColor : AppTheme.buttonColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(msg,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  )),
            ],
          )),
    );
  }
}
