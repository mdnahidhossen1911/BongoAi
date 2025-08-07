import 'package:bongoai/services/chat_service.dart';
import 'package:bongoai/viewmodels/login_viewmodel.dart';
import 'package:get_it/get_it.dart';

final GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<ChatService>(() => ChatService());
  serviceLocator.registerLazySingleton<LoginViewmodel>(() => LoginViewmodel());
}
