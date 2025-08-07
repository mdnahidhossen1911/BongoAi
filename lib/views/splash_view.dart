import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bongoai/utils/components/app_logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    moveNextScreen();
    super.initState();
  }

  Future<void> moveNextScreen() async {
    final user = FirebaseAuth.instance.currentUser;
    await Future.delayed(Duration(seconds: 4));
    if (user != null) {
      context.go('/chat');
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              AppLogo(height: 110, width: 100),
              const Spacer(),
              AnimatedTextKit(
                totalRepeatCount: 1,
                animatedTexts: [
                  TypewriterAnimatedText(
                    'BangoAI',
                    speed: Duration(milliseconds: 300),
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
