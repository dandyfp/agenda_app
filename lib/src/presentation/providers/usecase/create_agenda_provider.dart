import 'package:agenda_app/src/domain/usecase/create_agenda.dart';
import 'package:agenda_app/src/presentation/providers/repositories/agenda_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_agenda_provider.g.dart';

@riverpod
CreateAgenda createAgenda(CreateAgendaRef ref) =>
    CreateAgenda(agendaRepository: ref.watch(agendaRepositoryProvider));
