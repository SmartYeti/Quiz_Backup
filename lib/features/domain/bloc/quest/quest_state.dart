// ignore_for_file: must_be_immutable

part of 'quest_bloc.dart';

@immutable
class QuestState {
  final List<QuestDataModel> questList;
  final StateStatus stateStatus;
  final String? errorMessage;
  bool isEmpty;
  final bool isUpdated;
  final bool isAdded;

  QuestState(
      {required this.questList, 
      required this.stateStatus, 
      required this.isUpdated,
      this.errorMessage,
      required this.isAdded,
      required this.isEmpty,});

  factory QuestState.initial() => QuestState(
        questList: const [],
        stateStatus: StateStatus.initial,
        isUpdated: false,
        isEmpty: false,
        isAdded: false,
      );

  QuestState copyWith(
      {List<QuestDataModel>? questList,
      StateStatus? stateStatus,
      bool? isEmpty,
      bool? isUpdated,
      bool? isAdded,
      String? errorMessage}) {
    return QuestState(
      questList: questList ?? this.questList,
      stateStatus: stateStatus ?? this.stateStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      isEmpty: isEmpty ?? this.isEmpty,
      isUpdated: isUpdated ?? this.isUpdated,
      isAdded: isAdded ?? this.isAdded,
    );
  }
}
