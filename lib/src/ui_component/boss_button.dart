import 'package:audio_text/src/app/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class BossButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool? isSingleBtn;
  final Color? bgColor;
  final bool? isDisabled;
  const BossButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isSingleBtn = false,
    this.isDisabled = false,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled! ? () {} : onPressed,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bgColor ?? CustomColors.primary,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 5,
              color: CustomColors.textFieldGreyColor.withOpacity(0.6),
              offset: const Offset(1, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 10.0),
          child: isSingleBtn!
              ? Center(
                  child: Text(
                    title.toUpperCase(),
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.keyboard_double_arrow_right,
                        color: CustomColors.primary,
                        size: 25,
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
