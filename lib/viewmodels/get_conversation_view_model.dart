import 'package:bongoai/locator.dart';
import 'package:bongoai/utils/app_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/conversation.dart';
import 'auth_view_model.dart';

class GetConversationViewModel {
  late final List<Conversation> _conversations = [];
  List<Conversation> get conversations => _conversations;

  final SupabaseClient supaBase = Supabase.instance.client;
  final String _table = 'conversations';

  Future<List<Conversation>> fetchConversations() async {
    try {
      final response = await supaBase
          .from(_table)
          .select("* , messages(*)")
          .eq('uid', serviceLocator<AuthViewModel>().getUid)
          .order('created_at', ascending: true);

      print(response);
      appLogger.i('Fetched conversations: $response');
      _conversations.clear();

      _conversations.addAll(
        (response as List).map((item) => Conversation.fromJson(item)).toList(),
      );

      return _conversations;
    } catch (e) {
      print('Error fetching conversations: $e');
      return [];
    }
  }
}
