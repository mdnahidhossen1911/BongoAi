import 'package:bongoai/views/chat_view.dart';
import 'package:bongoai/views/user_details_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/app_logger.dart';

class LoginViewmodel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final _googleSignIn = GoogleSignIn();
  final SupabaseClient supaBase = Supabase.instance.client;

  final String _table = 'user_info';

  Future<void> signInWithGoogle(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final userInfo;
      if (googleUser != null) {
        final userData =
            await supaBase
                .from(_table)
                .select()
                .eq('email', googleUser.email)
                .limit(1)
                .maybeSingle();

        if (userData == null) {
          final response =
              await supaBase
                  .from(_table)
                  .insert({
                    'name': googleUser.displayName,
                    'email': googleUser.email,
                  })
                  .select()
                  .single();
          appLogger.i('new user added');
          appLogger.i(response);
          userInfo = response;
          context.go(
            UserDetailsView.routeName,
            extra: {'uuid': response['id'], 'name': response['name']},
          );
        } else {
          appLogger.i(googleUser.email);
          appLogger.i(userData);
          userInfo = userData;
          if (userData['des'] != null) {
            context.go(ChatView.routeName);
          } else {
            context.go(
              UserDetailsView.routeName,
              extra: {'uuid': userData['id'], 'name': userData['name']},
            );
          }
        }

        signOut();
        _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
      }
    } catch (error, stack) {
      appLogger.e("$error");
      appLogger.w("network error : $stack");
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
