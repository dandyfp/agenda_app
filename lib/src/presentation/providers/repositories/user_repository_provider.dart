import 'package:agenda_app/src/data/datasource/local_datasource.dart';
import 'package:agenda_app/src/data/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_provider.g.dart';

@riverpod
UserRepository userRepository(UserRepositoryRef ref) => LocalDatasource();
