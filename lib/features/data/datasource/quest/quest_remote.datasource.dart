import 'package:appwrite/appwrite.dart';
import 'package:quiz_app/config.dart';
import 'package:quiz_app/features/domain/model/quest/add_quest_model.dart';
import 'package:quiz_app/features/domain/model/quest/quest_model.dart';

class QuestRemoteDatasource {
  late Databases _databases;

  QuestRemoteDatasource(Databases databases) {
    _databases = databases;
  }

  Future<String> addQuest(AddQuestModel addquestModel) async {
    final String questId = ID.unique();
    final docs = await _databases.createDocument(
        databaseId: Config.userdbId,
        collectionId: Config.questDetailsId,
        documentId: questId,
        data: {
          'id': questId,
          'question': addquestModel.question,
          'choice1': addquestModel.choice1,
          'choice2': addquestModel.choice2,
          'choice3': addquestModel.choice3,
          'questId' : addquestModel.questId,
          'choice4': addquestModel.choice4,
          'createdAt': DateTime.now().toIso8601String(),
          'updatedAt': DateTime.now().toIso8601String()
        });

    return docs.$id;
  }

  Future<List<QuestDataModel>> getTask(String questId) async {
    final docs = await _databases.listDocuments(
        databaseId: Config.userdbId,
        collectionId: Config.questDetailsId,
        queries: [Query.equal('questId', questId)]);

    return docs.documents
        .map((e) => QuestDataModel.fromJson({...e.data, 'id': e.$id}))
        .toList();
  }
}
