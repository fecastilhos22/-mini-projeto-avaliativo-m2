import '../datasources/auth_datasource.dart';
import '../models/user_model.dart';
import 'result.dart';

class AuthRepository {
  final AuthDatasource _datasource = AuthDatasource();

  Future<Result<UserModel>> login(String username, String password) async {
    try {
      final json = await _datasource.login(username, password);
      final user = UserModel.fromJson(json);
      return Success(user);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}