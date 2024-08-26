import 'package:agenda_app/src/domain/usecase/create_user.dart';
import 'package:agenda_app/src/presentation/providers/repositories/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_user_provider.g.dart';

@riverpod
CreateUser createUser(CreateUserRef ref) =>
    CreateUser(userRepository: ref.watch(userRepositoryProvider));
