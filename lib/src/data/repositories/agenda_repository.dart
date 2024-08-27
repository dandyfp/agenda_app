import 'package:agenda_app/src/domain/entities/agenda.dart';
import 'package:dartz/dartz.dart';

abstract class AgendaRepository {
  Future<Either<String, Agenda>> createAgenda(Agenda agenda);
  Future<Either<String, Agenda>> updateAgenda(Agenda agenda);
  Future<Either<String, Agenda>> getDetail(int id);
  Future<Either<String, List<Agenda>>> getListAgenda();
}
