import 'package:agenda_app/src/data/repositories/user_repository.dart';
import 'package:agenda_app/src/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

class GetUser {
  final UserRepository _userRepository;

  GetUser({required UserRepository userRepository})
      : _userRepository = userRepository;

  Future<Either<String, User>> execute() async {
    return await _userRepository.getUser();
  }
}
