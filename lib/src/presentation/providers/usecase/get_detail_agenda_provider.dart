import 'package:agenda_app/src/domain/usecase/get_detail_agenda.dart';
import 'package:agenda_app/src/presentation/providers/repositories/agenda_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_detail_agenda_provider.g.dart';

@riverpod
GetDetailAgenda getDetailAgenda(GetDetailAgendaRef ref) =>
    GetDetailAgenda(agendaRepository: ref.watch(agendaRepositoryProvider));
