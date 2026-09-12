import 'package:flutter/foundation.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/session_repository.dart';
import '../data/repositories/result.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final SessionRepository _sessionRepository = SessionRepository();

  bool isLoading = false;
  String? errorMessage;

  Future<bool> login(String username, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners(); // avisa a tela: "comecei a carregar"

    final result = await _authRepository.login(username, password);

    isLoading = false;

    if (result is Success) {
      final user = (result as Success).data;
      await _sessionRepository.saveSession(user.firstName, user.lastName);
      notifyListeners();
      return true;
    } else {
      errorMessage = (result as Failure).message;
      notifyListeners(); // avisa a tela: "deu erro, mostra a mensagem"
      return false;
    }
  }
}