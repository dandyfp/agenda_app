import 'package:agenda_app/src/domain/usecase/update_agenda.dart';
import 'package:agenda_app/src/presentation/providers/repositories/agenda_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_agenda_provider.g.dart';

@riverpod
UpdateAgenda updateAgenda(UpdateAgendaRef ref) =>
    UpdateAgenda(agendaRepository: ref.watch(agendaRepositoryProvider));
