part of 'quest_bloc.dart';

@immutable
sealed class QuestEvent {}

class AddQuestEvent extends QuestEvent {
  final AddQuestModel addquestModel;

  AddQuestEvent({
    required this.addquestModel,
  });
}

class GetQuestEvent extends QuestEvent {
  final String questId;

  GetQuestEvent({required this.questId});
}
