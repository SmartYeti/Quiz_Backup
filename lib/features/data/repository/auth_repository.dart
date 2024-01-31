import 'package:appwrite/models.dart';
import 'package:dartz/dartz.dart';
import 'package:quiz_app/features/data/datasource/auth/auth_local.datasource.dart';
import 'package:quiz_app/features/data/datasource/auth/auth_remote.datasource.dart';
import 'package:quiz_app/features/domain/model/auth/auth_user.model.dart';
import 'package:quiz_app/features/domain/model/auth/login_model.dart';
import 'package:quiz_app/features/domain/model/register_model.dart';

class AuthRepository {
  late AuthRemoteDatasource _remoteDatasource;
  late AuthLocalDatasource _authLocalDatasource;

  AuthRepository(
    AuthRemoteDatasource remoteDatasource,
    AuthLocalDatasource localDatasource,
  ) {
    _remoteDatasource = remoteDatasource;
    _authLocalDatasource = localDatasource;
  }

  Future<Either<String, AuthUserModel>> login(LoginModel loginModel) async {
    try {
      final Session session = await _remoteDatasource.login(loginModel);

      _authLocalDatasource.saveSessionId(session.$id);

      final AuthUserModel authUserModel =
          await _remoteDatasource.getAuthUser(session.userId);
      // print(session);
      return Right(authUserModel);
    } catch (e) {
      
      // print(e);
      return Left(e.toString());
    }
  }

  Future<Either<String, AuthUserModel>> register(
      RegisterModel registerModel) async {
    try {
      await _remoteDatasource.createAccount(registerModel);

      final Session session = await _remoteDatasource.login(LoginModel(
          email: registerModel.email, password: registerModel.password));

      _authLocalDatasource.saveSessionId(session.$id);

      await _remoteDatasource.saveAccount(session.userId, registerModel);

      final AuthUserModel authUserModel =
          await _remoteDatasource.getAuthUser(session.userId);
      // print(session);
      return Right(authUserModel);
    } catch (e) {
      // print(e);
      return Left(e.toString());
    }
  }

  Future<Either<String, AuthUserModel?>> autoLogin() async {
    try {
      final String? sessionId = await _authLocalDatasource.getSessionId();

      if (sessionId == null) return const Right(null);

      final Session session = await _remoteDatasource.getSessionId(sessionId);

      final AuthUserModel authUserModel =
          await _remoteDatasource.getAuthUser(session.userId);

      return Right(authUserModel);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Unit>> logout() async {
    try {
      final String? sessionId = await _authLocalDatasource.getSessionId();

      if (sessionId != null) {
        await _remoteDatasource.deleteSession(sessionId);
        await _authLocalDatasource.deleteSession();
      }
      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
