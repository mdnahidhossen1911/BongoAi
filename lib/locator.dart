import 'package:bongoai/services/chat_service.dart';
import 'package:get_it/get_it.dart';

import 'services/auth_service.dart';

final GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerSingleton(AuthService());
  serviceLocator.registerLazySingleton<ChatService>(() => ChatService());
}
