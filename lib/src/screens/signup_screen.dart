import 'dart:developer';

import 'package:audio_text/src/app/custom_colors.dart';
import 'package:audio_text/src/screens/homepage.dart';
import 'package:audio_text/src/ui_component/boss_button.dart';
import 'package:audio_text/src/ui_component/password_text_field.dart';
import 'package:audio_text/src/ui_component/social_button.dart';
import 'package:audio_text/src/ui_component/text_field_shared.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFieldShared(
                controller: _emailController,
                onChanged: (email) {
                  log("changed $email");
                },
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 15,
              ),
              PasswordTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  onValueChange: (password) {
                    log("changed $password");
                  }),
              const SizedBox(
                height: 35,
              ),
              BossButton(
                  title: "Signup",
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                  }),
              const SizedBox(
                height: 45,
              ),
              Container(
                alignment: Alignment.center,
                child: const Text("Signup with"),
              ),
              const SizedBox(
                height: 10,
              ),
              const SocialButton(title: "Google"),
              const SocialButton(title: "Facebook"),
            ],
          ),
        ),
      ),
    );
  }
}
