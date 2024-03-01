import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../core/request_result/request_result.dart';
import '../../../../data/model/reading_model.dart';
import '../../../../domain/usecase/delete_reading_usercase.dart';
import '../../../../domain/usecase/fetch_readings_usercase.dart';

part 'readings_event.dart';

part 'readings_state.dart';

class ReadingsBloc extends Bloc<ReadingsEvent, ReadingsState> {
  ReadingsBloc(this.fetchReadingsUseCase, this.deleteReadingUseCase)
      : super(ReadingsLoadingState()) {
    on<ReadingsFetchEvent>(_onFetchReadings);
    on<ReadingsDeleteEvent>(_onDeleteReading);
  }

  final FetchReadingsUseCase fetchReadingsUseCase;
  final DeleteReadingUseCase deleteReadingUseCase;

  _onFetchReadings(
      ReadingsFetchEvent event, Emitter<ReadingsState> emit) async {
    final requestResult = await fetchReadingsUseCase();
    if (requestResult is RequestSuccess) {
      emit(ReadingsSuccessState(requestResult.data!));
    } else if (requestResult is RequestError) {
      emit(ReadingsErrorState(requestResult.errorMessage!));
    }
  }

  _onDeleteReading(
      ReadingsDeleteEvent event, Emitter<ReadingsState> emit) async {
    final requestResult = await deleteReadingUseCase(params: event.id);

    if (requestResult is RequestSuccess) {
      add(ReadingsFetchEvent());
      event.context.router.pop();
    } else if (requestResult is RequestError) {
      emit(ReadingsErrorState(requestResult.errorMessage!));
      event.context.router.pop();
    }
  }
}
