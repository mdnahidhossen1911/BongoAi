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
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueAccent,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          fontFamily: 'Roboto',
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.greenAccent,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          fontFamily: 'Roboto',
        ),
        themeMode: ThemeMode.system,
        routerConfig: _router,
      ),
    );
  }
}
