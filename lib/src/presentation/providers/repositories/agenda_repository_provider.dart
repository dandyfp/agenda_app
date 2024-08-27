import 'package:agenda_app/src/data/datasource/agenda_local_datasource.dart';
import 'package:agenda_app/src/data/repositories/agenda_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agenda_repository_provider.g.dart';

@riverpod
AgendaRepository agendaRepository(AgendaRepositoryRef ref) =>
    AgendaLocalDatasource();
