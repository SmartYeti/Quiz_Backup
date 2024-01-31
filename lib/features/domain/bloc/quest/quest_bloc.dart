import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/enum/state_status.enum.dart';
import 'package:quiz_app/features/data/repository/quest_repository.dart';
import 'package:quiz_app/features/domain/model/quest/add_quest_model.dart';
import 'package:quiz_app/features/domain/model/quest/quest_model.dart';

part 'quest_event.dart';
part 'quest_state.dart';

class QuestBloc extends Bloc<QuestEvent, QuestState> {
  QuestBloc(QuestRepository questRepository) : super(QuestState.initial()) {
    on<AddQuestEvent>((event, emit) async {
      emit(state.copyWith(stateStatus: StateStatus.loading));
      final Either<String, String> result =
          await questRepository.addQuestRepo(event.addquestModel);
      result.fold((error) {
        emit(
          state.copyWith(stateStatus: StateStatus.error, errorMessage: error),
        );
        emit(state.copyWith(stateStatus: StateStatus.loaded));
      }, (questId) {
        final currentQuestList = state.questList;
        emit(state.copyWith(
          stateStatus: StateStatus.loaded,
          isEmpty: false,
          questList: [
            ...currentQuestList,
            QuestDataModel(
                id: questId,
                question: event.addquestModel.question,
                choice1: event.addquestModel.choice1,
                choice2: event.addquestModel.choice2,
                choice3: event.addquestModel.choice3,
                choice4: event.addquestModel.choice4)
          ],
          isAdded: true,
        ));
      });
    });
    on<GetQuestEvent>((evet, emit) async {
      emit(state.copyWith(stateStatus: StateStatus.loading));
      final Either<String, List<QuestDataModel>> result =
          await questRepository.getQuestRepo(evet.questId);
      result.fold((error) {
        print(result);
        print(error);
        emit(state.copyWith(
            stateStatus: StateStatus.error, errorMessage: error));
        emit(state.copyWith(stateStatus: StateStatus.loaded));
      }, (questList) {
        if (questList.isNotEmpty) {
          emit(state.copyWith(
              questList: questList,
              stateStatus: StateStatus.loaded,
              isUpdated: true,
              isEmpty: false));
        } else {
          emit(state.copyWith(isEmpty: true, stateStatus: StateStatus.loaded));
        }
        emit(state.copyWith(isUpdated: false));
      });
    });
  }
}
