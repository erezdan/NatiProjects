import 'dart:developer';

import 'package:audio_text/src/app/custom_colors.dart';
import 'package:audio_text/src/screens/billing_history_screen.dart';
import 'package:audio_text/src/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BossAppBar extends AppBar {
  final Widget? leadingIconButton;
  final BuildContext context;
  BossAppBar({
    Key? key,
    required String title,
    this.leadingIconButton,
    required this.context,
  }) : super(
          key: key,
          centerTitle: true,
          title: Text(
            title,
            style: GoogleFonts.poppins(
              color: CustomColors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
            overflow: TextOverflow.visible,
          ),
          leading: _buildDropDownMenu(context),
          toolbarHeight: kToolbarHeight + 10,
          elevation: 10,
          shadowColor: CustomColors.primary.withOpacity(0.1),
          foregroundColor: Colors.black,
          actions: _buildPopUpEndMenu(context),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
            ),
          ),
          backgroundColor: Colors.white,
        );
}

List<Widget> _buildPopUpEndMenu(BuildContext context) {
  return [
    PopupMenuButton<int>(
      offset: const Offset(0, 50),
      onSelected: (item) {
        switch (item) {
          case 0:
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const About(),
            //   ),
            // );
            break;
          case 1:
            //open link to external browswer
            break;
          case 3:
            //open website link to external browswer
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<int>(onTap: () {}, value: 0, child: const Text("About Boss")
            // _buildText(AppLocalization.of(context).translate("aboutQure"), context),
            ),
        PopupMenuItem<int>(onTap: () {}, value: 1, child: const Text("Help")
            // _buildText(AppLocalization.of(context).translate("help"), context),
            ),
        PopupMenuItem<int>(onTap: () {}, value: 2, child: const Text("Website")
            // _buildText(AppLocalization.of(context).translate("website"), context),
            ),
      ],
    ),
  ];
}

Widget _buildText(String text, context) {
  return Text(
    text,
    style: GoogleFonts.poppins(fontSize: 14),
  );
}

Widget _buildDropDownMenu(BuildContext context) {
  return PopupMenuButton(
    onSelected: (val) {
      if (val == 0) {
         Navigator.push(context, MaterialPageRoute(builder: (context) => const BillingHistoryScreen()));
       
        // pushNewScreen(
        //   context,
        //   screen: const BillingHistory(),
        //   withNavBar: true,
        //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
        // );
      } else if (val == 2) {
        log("navigate to profile page");
        Navigator.push(context, MaterialPageRoute(builder: (context) => const UserProfileScreen()));
        // Provider.of<AppStateVM>(context, listen: false).onStateChanged(AppState.InitializedOnboardedAndUnAuthenticated);
        // Provider.of<AuthViewModel>(context, listen: false).logout(context);
      }
    },
    elevation: 0,
    shape: const RoundedRectangleBorder(
      side: BorderSide(color: Colors.black, width: 1),
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    offset: const Offset(0, 55),
    itemBuilder: (contextx) => [
      const PopupMenuItem(
        value: 0,
        child: Row(
          children: [
            Icon(Icons.clean_hands_outlined),
            SizedBox(
              width: 20,
            ),
            Text("Billing History")
            // _buildText(AppLocalization.of(context).translate("billingHistory"), context)
          ],
        ),
      ),
      PopupMenuItem(
        value: 1,
        child: Row(
          children: [
            const Icon(Icons.g_translate_sharp),
            const SizedBox(
              width: 20,
            ),
            const Text("Language"),
            // _buildText(AppLocalization.of(context).translate("language"), context),
            const SizedBox(
              width: 20,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                // hint: Text(Provider.of<AppStateVM>(context, listen: false)
                //     .currentLang
                //     .toUpperCase()), //put here selected active language option
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                items: <String>['EN', 'HE'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.poppins(
                        color: CustomColors.black,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  // if (value != null && value.isNotEmpty) {
                  //   Provider.of<AppStateVM>(context, listen: false).onLanguageChanged(value.toLowerCase());
                  // }
                },
              ),
            )
          ],
        ),
      ),
      const PopupMenuItem(
        value: 2,
        child: Row(
          children: [
            Icon(Icons.account_circle_outlined),
            SizedBox(
              width: 20,
            ),
            Text("User Profile"),
            // _buildText(AppLocalization.of(context).translate("logout"), context),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      )
    ],
    child: SizedBox(
      width: 30,
      height: 45,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: CustomColors.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
