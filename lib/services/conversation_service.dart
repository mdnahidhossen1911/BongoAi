import 'package:bongoai/locator.dart';
import 'package:bongoai/utils/app_logger.dart';
import 'package:bongoai/viewmodels/auth_view_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ConversationService {
  final SupabaseClient supaBase = Supabase.instance.client;
  final String _table = 'conversations';
  final String _messagesTable = 'messages';

  Future<void> addConversation(String id, String title) async {
    try {
      final res = await supaBase.from(_table).insert({
        'id': id,
        'uid': serviceLocator<AuthViewModel>().getUid,
        'title': title,
      });
      appLogger.i(res);
    } catch (e) {
      appLogger.e('Error adding conversation: $e');
      throw Exception('Failed to add conversation: $e');
    }
  }

  Future<void> addMessage(
    String id,
    String cid,
    String role,
    String content,
  ) async {
    try {
      final res = await supaBase.from(_messagesTable).insert({
        'id': id,
        'cid': cid,
        'role': role,
        'content': content,
      });
      appLogger.i(res);
    } catch (e) {
      appLogger.e('Error adding message: $e');
      throw Exception('Failed to add message: $e');
    }
  }
}
