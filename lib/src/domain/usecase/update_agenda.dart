import 'package:agenda_app/src/data/repositories/agenda_repository.dart';
import 'package:agenda_app/src/domain/entities/agenda.dart';
import 'package:dartz/dartz.dart';

class UpdateAgenda {
  final AgendaRepository _agendaRepository;

  UpdateAgenda({required AgendaRepository agendaRepository})
      : _agendaRepository = agendaRepository;

  Future<Either<String, Agenda>> execute(Agenda agenda) async {
    return await _agendaRepository.updateAgenda(agenda);
  }
}
