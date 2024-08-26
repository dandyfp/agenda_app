import 'package:agenda_app/src/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<String, User>> createUser(User user);
  Future<Either<String, User>> updateUser(User user);
  Future<Either<String, User>> getUser();
}
