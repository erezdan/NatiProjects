import 'package:audio_text/src/app/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialButton extends StatelessWidget {
  final String title;
  const SocialButton({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: CustomColors.primary.withOpacity(0.2),
          border: Border.all(width: 0.5, color: Colors.black12),
          borderRadius: BorderRadius.circular(10)),
      // width: 150,
      height: 50,
      child: Center(
        child: Text(
          "Google",
          style: GoogleFonts.poppins(fontSize: 15),
        ),
      ),
    );
  }
}
