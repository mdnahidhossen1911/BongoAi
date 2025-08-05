import 'package:bongoai/services/chat_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<ChatService>(() => ChatService());
}
