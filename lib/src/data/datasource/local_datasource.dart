import 'package:agenda_app/src/data/datasource/db_helper.dart';
import 'package:agenda_app/src/data/repositories/user_repository.dart';
import 'package:agenda_app/src/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

class LocalDatasource implements UserRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Future<Either<String, User>> createUser(User user) async {
    try {
      await _databaseHelper.insertUser(user);
      var result = await _databaseHelper.getUsers();
      return right(User.fromJSON(result.first));
    } catch (e) {
      return left('Failed add user');
    }
  }

  @override
  Future<Either<String, User>> getUser() async {
    try {
      var result = await _databaseHelper.getUsers();
      return right(User.fromJSON(result.first));
    } catch (e) {
      return left('Failed get user');
    }
  }

  @override
  Future<Either<String, User>> updateUser(User user) async {
    try {
      await _databaseHelper.updateUser(user);
      var result = await _databaseHelper.getUsers();
      return right(User.fromJSON(result.first));
    } catch (e) {
      return left('Failed add user');
    }
  }
}
