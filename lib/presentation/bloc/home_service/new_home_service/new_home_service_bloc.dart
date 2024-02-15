import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:home_info/data/model/home_service_model.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/request_result/request_result.dart';
import '../../../../domain/usecase/save_home_service_usercase.dart';

part 'new_home_service_event.dart';

part 'new_home_service_state.dart';

class NewHomeServiceBloc
    extends Bloc<NewHomeServiceEvent, NewHomeServiceState> {
  NewHomeServiceBloc(this.saveHomeServiceUseCase)
      : super(const NewHomeServiceState()) {
    on<ServiceSaveEvent>(_onSaveService);
    on<NewHomeServiceSelectIconEvent>(_onSelectIcon);
    on<NewHomeServiceSelectIconColorEvent>(_onSelectIconColor);
  }

  final SaveHomeServiceUseCase saveHomeServiceUseCase;

  _onSelectIcon(
      NewHomeServiceSelectIconEvent event, Emitter<NewHomeServiceState> emit) {
    HapticFeedback.vibrate();
    emit(state.copyWith(icon: event.icon));
  }

  _onSelectIconColor(NewHomeServiceSelectIconColorEvent event,
      Emitter<NewHomeServiceState> emit) {
    HapticFeedback.vibrate();
    emit(state.copyWith(iconColor: event.iconColor));
  }

  _onSaveService(
      ServiceSaveEvent event, Emitter<NewHomeServiceState> emit) async {
    final service = HomeServiceModel(
      id: const Uuid().v4obj().toString(),
      title: event.title,
      icon: state.icon,
      iconColor: state.iconColor,
    );
    var requestResult = await saveHomeServiceUseCase(params: service);

    if (requestResult is RequestSuccess) {
      emit(NewHomeServiceSaveState());
      event.context.router.pop();
    } else if (requestResult is RequestError) {
      emit(NewHomeServiceErrorState(requestResult.errorMessage!));
    }
  }
}
