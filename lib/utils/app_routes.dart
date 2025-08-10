import 'package:bongoai/models/user_model.dart';
import 'package:go_router/go_router.dart';

import '../views/chat_view.dart';
import '../views/splash_view.dart';
import '../views/user_details_view.dart';
import '../views/welcome_view.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: SplashView.routeName,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: WelcomeView.routeName,
        builder: (context, state) => WelcomeView(),
      ),
      GoRoute(
        path: UserDetailsView.routeName,
        builder: (context, state) {
          final info = state.extra as UserModel;
          return UserDetailsView(info: info);
        },
      ),
      GoRoute(
        path: ChatView.routeName,
        builder: (context, state) => ChatView(),
      ),
    ],
  );
}
