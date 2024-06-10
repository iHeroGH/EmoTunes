import 'package:emotunes/constants.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String hintText;
  final IconData? preIcon;
  final IconData? postIcon;
  final IconData? postIconOpt;
  final int maxLength;
  final bool visibility;

  const CustomInputField({
    super.key,
    required this.hintText,
    this.preIcon,
    this.postIcon,
    this.postIconOpt,
    this.maxLength = 100,
    this.visibility = true,
  });

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _isVisible = true;
  int _maxLength = 100;

  @override
  void initState() {
    _isVisible = widget.visibility;
    _maxLength = widget.maxLength;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: !_isVisible,
      maxLength: _maxLength,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(inputFieldRounding)),
        filled: true,
        counterText: "",
        prefixIcon: widget.preIcon != null ? Icon(widget.preIcon, color: primaryColor) : null,
        suffixIcon: widget.postIcon != null
            ? IconButton(
                icon: _isVisible ?
                  Icon(widget.postIcon, color: primaryColor)
                  : Icon(widget.postIconOpt, color: primaryColor),
                onPressed: () {
                  setState(() {
                    _isVisible = !_isVisible;
                  });
                },
              )
            : null,
        hintStyle: const TextStyle(color: textColor),
        hintText: widget.hintText,
        fillColor: primaryLightColor,
      ),
    );
  }
}
