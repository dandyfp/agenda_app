import 'package:agenda_app/src/domain/entities/agenda.dart';
import 'package:agenda_app/src/domain/usecase/get_list_agenda.dart';
import 'package:agenda_app/src/presentation/providers/usecase/get_list_agenda_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_list_agenda_data_provider.g.dart';

@Riverpod(keepAlive: true)
class GetListAgendaData extends _$GetListAgendaData {
  @override
  Future<List<Agenda>> build() async {
    GetListAgenda getList = ref.read(getListAgendaProvider);
    state = const AsyncLoading();
    var result = await getList.execute();
    return result.fold(
      (l) {
        state = const AsyncData([]);
        return [];
      },
      (r) {
        state = AsyncData(r);
        return r;
      },
    );
  }
}
