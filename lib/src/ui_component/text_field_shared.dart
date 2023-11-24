import 'package:audio_text/src/app/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


class TextFieldShared extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String val) onChanged;
  final List<TextInputFormatter>? formatters;
  final String? Function(String? val)? onValidation;
  final String hintText;
  final TextInputType? keyboardType;

  const TextFieldShared({
    Key? key,
    this.controller,
    required this.onChanged,
    this.formatters,
    this.onValidation,
    required this.hintText,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: formatters,
      keyboardType: keyboardType,
      controller: controller,
      onChanged: onChanged,
      validator: onValidation,
      
      decoration: InputDecoration(
        hintText: hintText,
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
