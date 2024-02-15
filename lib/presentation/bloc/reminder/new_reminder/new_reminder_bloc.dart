import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/request_result/request_result.dart';
import '../../../../data/model/local_notification_model.dart';
import '../../../../data/model/reminder_model.dart';
import '../../../../domain/usecase/set_local_notification_usecase.dart';
import '../../../../domain/usecase/save_reminder_usecase.dart';
import '../../../widgets/date_time/date_picker.dart';

part 'new_reminder_event.dart';

part 'new_reminder_state.dart';

class NewReminderBloc extends Bloc<NewReminderEvent, NewReminderState> {
  NewReminderBloc(this._saveReminderUseCase, this._setLocalNotificationUseCase)
      : super(NewReminderState(
            date: DateFormat('yyyy-MM-dd')
                .format(DateTime.now().add(const Duration(days: 1))))) {
    on<NewReminderPickDateEvent>(_onPickDate);
    on<NewReminderRepeatEvent>(_onRepeat);
    on<NewReminderSaveEvent>(_onSave);
  }

  final SaveReminderUseCase _saveReminderUseCase;
  final SetLocalNotificationUseCase _setLocalNotificationUseCase;

  _onPickDate(
      NewReminderPickDateEvent event, Emitter<NewReminderState> emit) async {
    DateTime? pickedDate = await datePicker(event.ctx);
    if (pickedDate != null) {
      emit(state.copyWith(date: DateFormat('yyyy-MM-dd').format(pickedDate)));
    }
  }

  _onRepeat(NewReminderRepeatEvent event, Emitter<NewReminderState> emit) {
    emit(state.copyWith(isRepeat: event.isRepeat));
  }

  _onSave(NewReminderSaveEvent event, Emitter<NewReminderState> emit) async {
    final int notificationId = Random().nextInt(100000);
    final reminder = ReminderModel(
      id: const Uuid().v4obj().toString(),
      notificationId: notificationId,
      date: state.date,
      isRepeat: state.isRepeat,
      title: event.title,
      description: event.description,
    );
    final localNotification = LocalNotificationModel(
      id: notificationId,
      title: event.title,
      body: event.description,
      scheduleDateTime: '${state.date} 09:00:00.00',
      isRepeat: state.isRepeat,
    );

    final requestResult = await _saveReminderUseCase(params: reminder);

    if (requestResult is RequestSuccess) {
      _setLocalNotificationUseCase(params: localNotification);
      event.cxt.router.pop();
    } else if (requestResult is RequestError) {
      emit(NewReminderErrorState(requestResult.errorMessage!));
    }
  }
}


