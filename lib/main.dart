import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'utils/locator.dart';
import 'viewmodels/chat_viewmodel.dart';
import 'views/chat_screen.dart';
import 'views/welcome_screen.dart';

void main() {
  setupLocator();
  runApp(BongoAIApp());
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const WelcomeScreen()),
    GoRoute(path: '/chat', builder: (context, state) => ChatScreen()),
  ],
);

class BongoAIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ChatViewModel())],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'BongoAI',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: const TextStyle(color: Color(0xA6386365), fontSize: 14),
            filled: true,
            fillColor: const Color(0x0F1CCAD1),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Color(0x401CCAD1), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Color(0x401CCAD1), width: 1),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
          ),
          useMaterial3: true,
          fontFamily: 'Roboto',
        ),
        routerConfig: _router,
      ),
    );
  }
}
