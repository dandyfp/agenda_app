import 'package:agenda_app/src/data/repositories/agenda_repository.dart';
import 'package:agenda_app/src/domain/entities/agenda.dart';
import 'package:dartz/dartz.dart';

class DeleteAgenda {
  final AgendaRepository _agendaRepository;

  DeleteAgenda({required AgendaRepository agendaRepository})
      : _agendaRepository = agendaRepository;

  Future<Either<String, Agenda>> execute(int id) async {
    return await _agendaRepository.removeAgenda(id);
  }
}
