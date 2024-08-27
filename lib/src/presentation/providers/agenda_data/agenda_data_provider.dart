import 'package:agenda_app/src/domain/entities/agenda.dart';
import 'package:agenda_app/src/domain/usecase/create_agenda.dart';
import 'package:agenda_app/src/domain/usecase/delete_agenda.dart';
import 'package:agenda_app/src/domain/usecase/get_detail_agenda.dart';
import 'package:agenda_app/src/domain/usecase/update_agenda.dart';
import 'package:agenda_app/src/presentation/providers/agenda_data/get_list_agenda_data_provider.dart';
import 'package:agenda_app/src/presentation/providers/usecase/create_agenda_provider.dart';
import 'package:agenda_app/src/presentation/providers/usecase/delete_agenda_provider.dart';
import 'package:agenda_app/src/presentation/providers/usecase/get_detail_agenda_provider.dart';
import 'package:agenda_app/src/presentation/providers/usecase/update_agenda_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agenda_data_provider.g.dart';

@Riverpod(keepAlive: true)
class AgendaData extends _$AgendaData {
  @override
  Future<Agenda?> build() async {
    return null;
  }

  Future createAgenda(Agenda agenda) async {
    CreateAgenda createAgenda = ref.read(createAgendaProvider);
    state = const AsyncLoading();
    var result = await createAgenda.execute(agenda);
    return result.fold(
      (l) {
        state = const AsyncData(null);
        ref.read(getListAgendaDataProvider.notifier).build();
        return l;
      },
      (r) {
        ref.read(getListAgendaDataProvider.notifier).build();
        state = AsyncData(r);
        return r;
      },
    );
  }

  Future deleteAgenda(int id) async {
    DeleteAgenda deleteAgenda = ref.read(deleteAgendaProvider);
    state = const AsyncLoading();
    var result = await deleteAgenda.execute(id);
    return result.fold(
      (l) {
        state = const AsyncData(null);
        ref.read(getListAgendaDataProvider.notifier).build();
        return l;
      },
      (r) {
        ref.read(getListAgendaDataProvider.notifier).build();
        state = AsyncData(r);
        return r;
      },
    );
  }

  Future updateAgenda(Agenda agenda) async {
    UpdateAgenda updateData = ref.read(updateAgendaProvider);
    var result = await updateData.execute(agenda);
    return result.fold(
      (l) {
        state = const AsyncData(null);
        ref.read(getListAgendaDataProvider.notifier).build();
        return l;
      },
      (r) {
        state = AsyncData(r);
        ref.read(getListAgendaDataProvider.notifier).build();
        return r;
      },
    );
  }

  Future getDetailAgenda(int id) async {
    GetDetailAgenda getDetail = ref.read(getDetailAgendaProvider);
    state = const AsyncLoading();
    var result = await getDetail.execute(id);
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
