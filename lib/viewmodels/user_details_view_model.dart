import 'package:bongoai/locator.dart';
import 'package:bongoai/models/user_model.dart';
import 'package:bongoai/viewmodels/auth_view_model.dart';
import 'package:bongoai/views/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/app_logger.dart';

class UserDetailsViewModel {
  Future<void> saveUserDetails(
    UserModel userModel,
    BuildContext context,
  ) async {
    final supaBase = Supabase.instance.client;

    try {
      final resource =
          await supaBase
              .from('user_info')
              .update({
                'name': userModel.shortName,
                'des': userModel.description,
              })
              .eq('id', userModel.uid)
              .select();
      appLogger.i("User details saved successfully: $resource");
      if (resource[0]['des'] != null) {
        serviceLocator<AuthViewModel>().saveData(userModel.uid, userModel);
        context.go(ChatView.routeName);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to save user details.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to save user details.')));
    }
  }
}
