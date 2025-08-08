import 'package:bongoai/views/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/app_logger.dart';

class UserDetailsViewModel {
  Future<void> saveUserDetails(
    String uuid,
    String name,
    String traits,
    BuildContext context,
  ) async {
    final supaBase = Supabase.instance.client;

    try {
      final resource =
          await supaBase
              .from('user_info')
              .update({'name': name, 'des': traits})
              .eq('id', uuid)
              .select();
      appLogger.i("User details saved successfully: $resource");
      if (resource[0]['des'] != null) {
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
