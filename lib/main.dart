import 'package:bongoai/utils/app_routes.dart';
import 'package:bongoai/utils/app_theme_data.dart';
import 'package:bongoai/viewmodels/login_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'locator.dart';
import 'viewmodels/chat_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASEURL'] ?? 'NO URL',
    anonKey: dotenv.env['ANOKEY'] ?? 'NO API KEY',
  );

  setupServiceLocator();
  runApp(BongoAIApp());
}

class BongoAIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatViewModel()),
        ChangeNotifierProvider(create: (_) => serviceLocator<LoginViewmodel>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'BongoAI',
        theme: appThemeData(),
        routerConfig: AppRoutes.router,
      ),
    );
  }
}
