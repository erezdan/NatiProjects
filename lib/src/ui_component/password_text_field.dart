import 'package:audio_text/src/app/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String val) onValueChange;
  final String hintText;
  const PasswordTextField({
    Key? key,
    required this.controller,
    required this.onValueChange,
    required this.hintText,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isShowing = false;
  _handleTap() {
    setState(() {
      isShowing = !isShowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onValueChange,
      obscureText: !isShowing,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: _handleTap,
          child: Icon(
            isShowing ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
            color: CustomColors.textFieldGreyColor,
          ),
        ),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.poppins(color: CustomColors.textFieldGreyColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: CustomColors.textFieldGreyColor,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: CustomColors.textFieldGreyColor,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: CustomColors.textFieldGreyColor,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
      ),
    );
  }
}
