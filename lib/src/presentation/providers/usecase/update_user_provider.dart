import 'package:agenda_app/src/domain/usecase/update_user.dart';
import 'package:agenda_app/src/presentation/providers/repositories/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_user_provider.g.dart';

@riverpod
UpdateUser updateUser(UpdateUserRef ref) =>
    UpdateUser(userRepository: ref.watch(userRepositoryProvider));
