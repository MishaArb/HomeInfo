import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/request_result/request_result.dart';
import '../../../../data/model/reminder_model.dart';
import '../../../../domain/usecase/reminder/new_reminder/save_reminder_usecase.dart';

part 'new_reminder_event.dart';

part 'new_reminder_state.dart';

class NewReminderBloc extends Bloc<NewReminderEvent, NewReminderState> {
  NewReminderBloc(this._saveRemindersUseCase)
      : super(NewReminderState(
            date: DateFormat('dd-MM-yyyy').format(DateTime.now()))) {
    on<NewReminderPickDateEvent>(_onPickDate);
    on<NewReminderRepeatEvent>(_onRepeat);
    on<NewReminderSaveEvent>(_onSave);
  }

  final SaveRemindersUseCase _saveRemindersUseCase;

  _onPickDate(
      NewReminderPickDateEvent event, Emitter<NewReminderState> emit) async {
    DateTime? pickedDate = await showDatePicker(
        context: event.ctx,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2110));

    if (pickedDate != null) {
      emit(state.copyWith(date: DateFormat('dd-MM-yyyy').format(pickedDate)));
    }
  }

  _onRepeat(NewReminderRepeatEvent event, Emitter<NewReminderState> emit) {
    emit(state.copyWith(isRepeat: event.isRepeat));
  }

  _onSave(NewReminderSaveEvent event, Emitter<NewReminderState> emit) async {
    final reminder = ReminderModel(
        id: const Uuid().v4obj().toString(),
        date: state.date,
        isRepeat: state.isRepeat,
        title: event.title,
        description: event.description,
    );

    final requestResult =
        await _saveRemindersUseCase(params: reminder);

    if (requestResult is RequestSuccess) {
      event.cxt.router.pop();
    } else if (requestResult is RequestError) {
      emit(NewReminderErrorState(requestResult.errorMessage!));
    }
  }
}
