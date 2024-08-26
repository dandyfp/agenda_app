import 'package:agenda_app/src/domain/entities/user.dart';
import 'package:agenda_app/src/domain/usecase/create_user.dart';
import 'package:agenda_app/src/domain/usecase/get_user.dart';
import 'package:agenda_app/src/domain/usecase/update_user.dart';
import 'package:agenda_app/src/presentation/providers/usecase/create_user_provider.dart';
import 'package:agenda_app/src/presentation/providers/usecase/get_user_provider.dart';
import 'package:agenda_app/src/presentation/providers/usecase/update_user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserDataProvider extends _$UserDataProvider {
  @override
  Future<User?> build() async {
    GetUser getUser = await ref.read(getUserProvider);
    state = const AsyncLoading();
    var result = await getUser.execute();
    return result.fold(
      (l) {
        state = const AsyncData(null);
        return null;
      },
      (r) {
        state = AsyncData(r);
        return r;
      },
    );
  }

  Future<void> create(User user) async {
    CreateUser createUser = ref.read(createUserProvider);
    var result = await createUser.execute(user);
    return result.fold(
      (l) => null,
      (r) => r,
    );
  }

  Future updateData(User user) async {
    UpdateUser updateUser = ref.read(updateUserProvider);
    var result = await updateUser.execute(user);
    return result.fold(
      (l) {
        state = const AsyncData(null);
        return l;
      },
      (r) {
        state = AsyncData(r);
        return r;
      },
    );
  }
}
