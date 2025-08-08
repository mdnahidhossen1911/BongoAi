import 'package:bongoai/locator.dart';
import 'package:bongoai/viewmodels/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/assets_path.dart';
import '../utils/components/app_logo.dart';
import '../utils/components/google_sign_in_button.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, toolbarHeight: 0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const AppLogo(height: 30, width: 30),
                  const SizedBox(width: 8),
                  Text(
                    'BangoAI',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                'Welcome to BangoAI',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'No login needed to start chatting. Log in only if you\'d like to save your chat history.',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              ),
              const SizedBox(height: 40),
              Center(
                child: Lottie.asset(
                  AssetsPath.lottieAnimation,
                  height: 300,
                  fit: BoxFit.cover,
                  repeat: true,
                  animate: true,
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: GoogleSignInButton(
                  onPressed: () async {
                    serviceLocator<LoginViewmodel>().signInWithGoogle(context);
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
