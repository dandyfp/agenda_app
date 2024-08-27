import 'package:agenda_app/src/data/datasource/db_helper.dart';
import 'package:agenda_app/src/data/repositories/agenda_repository.dart';
import 'package:agenda_app/src/domain/entities/agenda.dart';
import 'package:dartz/dartz.dart';

class AgendaLocalDatasource implements AgendaRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  @override
  Future<Either<String, Agenda>> createAgenda(Agenda agenda) async {
    try {
      await _databaseHelper.insertAgenda(agenda);
      var result = await _databaseHelper.getDetailAgenda(agenda.id ?? 0);
      return right(Agenda.fromJSON(result.first));
    } catch (e) {
      return left('Failed add agenda');
    }
  }

  @override
  Future<Either<String, Agenda>> getDetail(int id) async {
    try {
      var result = await _databaseHelper.getDetailAgenda(id);
      return right(Agenda.fromJSON(result.first));
    } catch (e) {
      return left('Failed get agenda');
    }
  }

  @override
  Future<Either<String, List<Agenda>>> getListAgenda() async {
    try {
      var result = await _databaseHelper.getListAgenda();
      return right(result.map((e) => Agenda.fromJSON(e)).toList());
    } catch (e) {
      return left('Failed get list agenda');
    }
  }

  @override
  Future<Either<String, Agenda>> updateAgenda(Agenda agenda) async {
    try {
      await _databaseHelper.updateAgenda(agenda);
      var result = await _databaseHelper.getDetailAgenda(agenda.id ?? 0);
      return right(Agenda.fromJSON(result.first));
    } catch (e) {
      return left('Failed add agenda');
    }
  }
}
