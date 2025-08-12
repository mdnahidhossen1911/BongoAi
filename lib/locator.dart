import 'package:bongoai/services/chat_service.dart';
import 'package:bongoai/viewmodels/auth_view_model.dart';
import 'package:bongoai/viewmodels/chat_viewmodel.dart';
import 'package:bongoai/viewmodels/get_conversation_view_model.dart';
import 'package:bongoai/viewmodels/login_viewmodel.dart';
import 'package:get_it/get_it.dart';

final GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerSingleton(AuthViewModel());
  serviceLocator.registerLazySingleton<ChatService>(() => ChatService());
  serviceLocator.registerLazySingleton<ChatViewModel>(() => ChatViewModel());
  serviceLocator.registerLazySingleton<LoginViewmodel>(() => LoginViewmodel());
  serviceLocator.registerSingleton(GetConversationViewModel());
}
