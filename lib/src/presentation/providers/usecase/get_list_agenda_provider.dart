import 'package:agenda_app/src/domain/usecase/get_list_agenda.dart';
import 'package:agenda_app/src/presentation/providers/repositories/agenda_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_list_agenda_provider.g.dart';

@riverpod
GetListAgenda getListAgenda(GetListAgendaRef ref) =>
    GetListAgenda(agendaRepository: ref.watch(agendaRepositoryProvider));
