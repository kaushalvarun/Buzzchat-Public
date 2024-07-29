import 'package:buzz_chat/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Icon? icon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool hasError;

  const MyTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.validator,
    this.icon,
    this.suffixIcon,
    required this.hasError,
  });

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  Color labelColor = Colors.black54;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: TextFormField(
        validator: widget.validator,
        inputFormatters: [LengthLimitingTextInputFormatter(64)],
        style: TextStyle(
          color: AppTheme.isDarkMode(context)
              ? AppTheme.darkTextColor
              : AppTheme.textColor,
        ),
        controller: widget.controller,
        obscureText: widget.obscureText,
        enableSuggestions: false,
        textCapitalization: TextCapitalization.none,
        autocorrect: false,
        decoration: InputDecoration(
          label: Text(widget.hintText,
              style: TextStyle(
                color: (widget.hasError)
                    ? AppTheme.isDarkMode(context)
                        ? Colors.red[600]!
                        : Colors.red[800]!
                    : Colors.black54,
              )),
          prefixIcon: widget.icon,
          suffixIcon: widget.suffixIcon,
          fillColor: Colors.white,
          filled: true,
          errorMaxLines: 3,
          errorStyle: TextStyle(
            color: AppTheme.isDarkMode(context)
                ? Colors.red[600]!
                : Colors.red[800]!,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.isDarkMode(context)
                  ? Colors.red[600]!
                  : Colors.red[800]!,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.isDarkMode(context)
                  ? Colors.red[600]!
                  : Colors.red[800]!,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.isDarkMode(context)
                  ? Colors.grey[100]!
                  : Colors.grey[500]!,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.5),
          ),
        ),
      ),
    );
  }
}
