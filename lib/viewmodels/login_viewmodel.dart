import 'package:bongoai/locator.dart';
import 'package:bongoai/models/user_model.dart';
import 'package:bongoai/viewmodels/auth_view_model.dart';
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
    UserModel userModel;
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
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
          userModel = UserModel(
            uid: response['id'],
            email: response['email'],
            fullName: googleUser.displayName,
            shortName: response['name'],
            photo: googleUser.photoUrl,
            description: response['des'],
          );
          context.go(UserDetailsView.routeName, extra: userData);
        } else {
          appLogger.i(googleUser.email);
          appLogger.i(userData);
          userModel = UserModel(
            uid: userData['id'],
            email: userData['email'],
            fullName: googleUser.displayName,
            shortName: userData['name'],
            photo: googleUser.photoUrl,
            description: userData['des'],
          );
          if (userData['des'] != null) {
            context.go(ChatView.routeName);
            serviceLocator<AuthViewModel>().saveData(userData['id'], userModel);
          } else {
            context.go(UserDetailsView.routeName, extra: userData);
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
