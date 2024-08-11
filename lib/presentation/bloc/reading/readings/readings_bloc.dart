import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/reading.dart';
import '../../../../core/request_result/request_result.dart';
import '../../../../data/model/reading_model.dart';
import '../../../../domain/usecase/delete_reading_usercase.dart';
import '../../../../domain/usecase/fetch_readings_usercase.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../utils/drop_down_measure_lable.dart';

part 'readings_event.dart';

part 'readings_state.dart';

class ReadingsBloc extends Bloc<ReadingsEvent, ReadingsState> {
  ReadingsBloc(this.fetchReadingsUseCase, this.deleteReadingUseCase)
      : super(ReadingsLoadingState()) {
    on<ReadingsFetchEvent>(_onFetchReadings);
    on<ReadingsDeleteEvent>(_onDeleteReading);
    on<ReadingsShareAllDataEvent>(_onShareAllDataReading);
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

  _onShareAllDataReading(
      ReadingsShareAllDataEvent event, Emitter<ReadingsState> emit) async {
    final locale = AppLocalizations.of(event.context)!;
    String shareData = '';
    for(var i in event.reading.readingsItems){
      String getCurrentUnitMeasure(){
        final unitMeasure =
        i.unitMeasure == ReadingUnitsMeasure.undetectableUnits
            ? ''
            : getDropDownMeasureLabel(i.unitMeasure, event.context);
        return unitMeasure;
      }
      if(i.typeMeasure == ReadingTypeMeasure.areaType){
        shareData =  '$shareData${i.title}\n'
            '$shareData${locale.sum_inscription} ${i.sum.toStringAsFixed(2)} ${event.currency}\n\n';
      }  else if(i.typeMeasure == ReadingTypeMeasure.fixedType){
        shareData =   '$shareData${i.title}\n'
            '${locale.sum_inscription} ${i.sum.toStringAsFixed(2)} ${event.currency}\n\n';
      }  else if(i.typeMeasure == ReadingTypeMeasure.singleZoneMeterType){
        shareData =  '$shareData${i.title}\n'
            '${locale.current_readings_unit_hint_text}: ${i.currentReading} ${getCurrentUnitMeasure()}\n'
            '${locale.used_inscription} ${i.used} ${getCurrentUnitMeasure()}\n'
            '${locale.sum_inscription} ${i.sum.toStringAsFixed(2)} ${event.currency}\n\n';
      } else if(i.typeMeasure == ReadingTypeMeasure.twoZoneMeterType){
        shareData =  '$shareData${i.title}\n'
            '${locale.current_indicators_day_share}: ${i.currentReadingDay} ${getCurrentUnitMeasure()}\n'
            '${locale.current_indicators_night_share}: ${i.currentReadingNight} ${getCurrentUnitMeasure()}\n'
            '${locale.used_day_inscription} ${i.usedDay} ${getCurrentUnitMeasure()}\n'
            '${locale.used_night_inscription} ${i.usedNight} ${getCurrentUnitMeasure()}\n'
            '${locale.sum_inscription} ${i.sum.toStringAsFixed(2)} ${event.currency}\n\n';
      }else if(i.typeMeasure == ReadingTypeMeasure.threeZoneMeterType){
        shareData =  '$shareData${i.title}\n'
            '${locale.current_indicators_day_share}: ${i.currentReadingDay} ${getCurrentUnitMeasure()}\n'
            '${locale.current_indicators_half_pick_share}: ${i.currentReadingHalfPeak} ${getCurrentUnitMeasure()}\n'
            '${locale.current_indicators_night_share}: ${i.currentReadingNight} ${getCurrentUnitMeasure()}\n'
            '${locale.used_day_inscription} ${i.usedDay} ${getCurrentUnitMeasure()}\n'
            '${locale.used_half_peak_inscription} ${i.usedHalfPeak} ${getCurrentUnitMeasure()}\n'
            '${locale.used_night_inscription} ${i.usedNight} ${getCurrentUnitMeasure()}\n'
            '${locale.sum_inscription} ${i.sum.toStringAsFixed(2)} ${event.currency}\n\n';
      }

    }

    Share.share('$shareData\n${locale.total_sum_inscription}: ${event.reading.totalSum}');
  }
}
