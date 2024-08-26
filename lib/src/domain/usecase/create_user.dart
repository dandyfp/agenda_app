import 'package:agenda_app/src/data/repositories/user_repository.dart';
import 'package:agenda_app/src/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

class CreateUser {
  final UserRepository _userRepository;

  CreateUser({required UserRepository userRepository})
      : _userRepository = userRepository;

  Future<Either<String, User>> execute(User user) async {
    return await _userRepository.createUser(user);
  }
}
