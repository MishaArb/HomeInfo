import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:home_info/core/request_result/request_result.dart';
import 'package:home_info/domain/entities/reminder_entity.dart';
import 'package:meta/meta.dart';
import '../../../../domain/usecase/reminder/reminders/delete_reminder_usecase.dart';
import '../../../../domain/usecase/reminder/reminders/fetch_reminders_usecase.dart';

part 'reminders_event.dart';

part 'reminders_state.dart';

class RemindersBloc extends Bloc<RemindersEvent, RemindersState> {
  RemindersBloc(this._fetchRemindersUseCase, this._deleteRemindersUseCase)
      : super(RemindersLoadingState()) {
    on<RemindersFetchEvent>(_fetchReminders);
    on<RemindersDeleteEvent>(_onDeleteReminder);
  }

  final FetchRemindersUseCase _fetchRemindersUseCase;
  final DeleteRemindersUseCase _deleteRemindersUseCase;

  _fetchReminders(
      RemindersFetchEvent event, Emitter<RemindersState> emit) async {
    emit(RemindersLoadingState());
    final requestResult = await _fetchRemindersUseCase();

    if (requestResult is RequestSuccess) {
      emit(RemindersSuccessState(requestResult.data!));
    } else if (requestResult is RequestError) {
      emit(RemindersErrorState(requestResult.errorMessage!));
    }
  }

  _onDeleteReminder(
      RemindersDeleteEvent event, Emitter<RemindersState> emit) async {
    final requestResult = await _deleteRemindersUseCase(params: event.id);

    if (requestResult is RequestSuccess) {
      add(RemindersFetchEvent());
      event.context.router.pop();
    } else if (requestResult is RequestError) {
      emit(RemindersErrorState(requestResult.errorMessage!));
    }
  }
}
