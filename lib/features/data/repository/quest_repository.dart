import 'package:dartz/dartz.dart';
import 'package:quiz_app/features/data/datasource/quest/quest_remote.datasource.dart';
import 'package:quiz_app/features/domain/model/quest/add_quest_model.dart';
import 'package:quiz_app/features/domain/model/quest/quest_model.dart';

class QuestRepository {
  late QuestRemoteDatasource _questRemoteDatasource;

  QuestRepository(
    QuestRemoteDatasource remoteDatasource,
  ) {
    _questRemoteDatasource = remoteDatasource;
  }
  Future<Either<String, String>> addQuestRepo(
      AddQuestModel addquestModel) async {
    try {
      final result = await _questRemoteDatasource.addQuest(addquestModel);
      print(result);
      return Right(result);
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }

  Future<Either<String, List<QuestDataModel>>> getQuestRepo(
      String questId) async {
    try {
      final result = await _questRemoteDatasource.getTask(questId);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
