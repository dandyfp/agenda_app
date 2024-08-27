import 'package:agenda_app/src/data/repositories/agenda_repository.dart';
import 'package:agenda_app/src/domain/entities/agenda.dart';
import 'package:dartz/dartz.dart';

class CreateAgenda {
  final AgendaRepository _agendaRepository;

  CreateAgenda({required AgendaRepository agendaRepository})
      : _agendaRepository = agendaRepository;

  Future<Either<String, Agenda>> execute(Agenda agenda) async {
    return await _agendaRepository.createAgenda(agenda);
  }
}
