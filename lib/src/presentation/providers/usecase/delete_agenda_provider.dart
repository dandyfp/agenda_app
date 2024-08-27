import 'package:agenda_app/src/domain/usecase/delete_agenda.dart';
import 'package:agenda_app/src/presentation/providers/repositories/agenda_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_agenda_provider.g.dart';

@riverpod
DeleteAgenda deleteAgenda(DeleteAgendaRef ref) =>
    DeleteAgenda(agendaRepository: ref.watch(agendaRepositoryProvider));
