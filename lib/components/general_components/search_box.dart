import 'package:buzz_chat/theme/theme.dart';
import 'package:flutter/material.dart';

class MySearchBox extends StatelessWidget {
  final TextEditingController controller;
  const MySearchBox({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1),
      child: TextField(
        style: TextStyle(
          color: isDarkMode ? AppTheme.darkTextColor : AppTheme.textColor,
        ),
        controller: controller,
        enableSuggestions: false,
        textCapitalization: TextCapitalization.none,
        autocorrect: false,
        decoration: InputDecoration(
          fillColor: isDarkMode ? Colors.grey[300] : Colors.grey[100],
          filled: true,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey[700]),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
