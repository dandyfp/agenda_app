import 'package:agenda_app/src/data/repositories/agenda_repository.dart';
import 'package:agenda_app/src/domain/entities/agenda.dart';
import 'package:dartz/dartz.dart';

class GetListAgenda {
  final AgendaRepository _agendaRepository;

  GetListAgenda({required AgendaRepository agendaRepository})
      : _agendaRepository = agendaRepository;

  Future<Either<String, List<Agenda>>> execute() async {
    return await _agendaRepository.getListAgenda();
  }
}
