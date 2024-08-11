import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/constants/reading.dart';
import '../../../../core/enum/reading_enum.dart';
import '../../../../core/request_result/request_result.dart';
import '../../../../data/model/reading_model.dart';
import '../../../../domain/usecase/fetch_readings_usercase.dart';
import '../../../../domain/usecase/save_reading_usercase.dart';
import '../../../../domain/usecase/update_reading_usercase.dart';
import '../../../../utils/drop_down_measure_lable.dart';
import '../../../widgets/date_time/date_picker.dart';

part 'new_reading_event.dart';

part 'new_reading_state.dart';

class NewReadingBloc extends Bloc<NewReadingEvent, NewReadingCreateState> {
  NewReadingBloc(
    this.fetchReadingsUseCase,
    this.createReadingUseCase,
    this.updateReadingUseCase,
  ) : super(
          NewReadingCreateState(),
        ) {
    on<NewReadingInitEvent>(_onInitReading);
    on<NewReadingAddHomeServiceEvent>(_onAddHomeService);
    on<NewReadingPickDateEvent>(_onPickDate);
    on<NewReadingPickTypeMeasureEvent>(_onPickTypeMeasure);
    on<NewReadingPickUnitMeasureEvent>(_onPickUnitMeasure);
    on<NewReadingCalculateAreaEvent>(_onCalculateArea);
    on<NewReadingCalculateFixedEvent>(_onCalculateFixed);
    on<NewReadingCalculateSingleZoneMeterEvent>(_onCalculateSingleZoneMeter);
    on<NewReadingCalculateTwoZoneMeterEvent>(_onCalculateTwoZoneMeter);
    on<NewReadingCalculateThreeZoneMeterEvent>(_onCalculateThreeZoneMeter);
    on<NewReadingChangeServiceEvent>(_onChangeService);
    on<NewReadingDeleteServiceEvent>(_onDeleteService);
    on<NewReadingSaveEvent>(_onSaveReading);
    on<NewReadingShareEvent>(_onShareData);
  }

  final FetchReadingsUseCase fetchReadingsUseCase;
  final CreateReadingUseCase createReadingUseCase;
  final UpdateReadingUseCase updateReadingUseCase;

  List<ReadingItem> readingItems = [];
  List<ReadingModel> allReadings = [];
  late final BuildContext ctx;
  _onInitReading(
      NewReadingInitEvent event, Emitter<NewReadingCreateState> emit) async {
    readingItems.clear();
    ctx = event.context;
    event.context.router.pushNamed('/createOrEditReadingsScreen');
    final requestResult = await fetchReadingsUseCase();
    if (requestResult is RequestSuccess) {
      allReadings = requestResult.data!;
      if (event.readingActionType == ReadingActionType.editReading) {
        readingItems = requestResult.data![event.readingIndex!].readingsItems;
        emit(
          state.copyWith(
            readingActionType: ReadingActionType.editReading,
            readingId: requestResult.data![event.readingIndex!].id,
            date: requestResult.data![event.readingIndex!].date,
            indexService: 0,
            readingItems: readingItems,
          ),
        );
      } else if (event.readingActionType == ReadingActionType.newReading) {
        emit(
          state.copyWith(
              readingActionType: ReadingActionType.newReading,
              date: DateTime.now().toString()),
        );
      }
    }
  }

  _onAddHomeService(NewReadingAddHomeServiceEvent event,
      Emitter<NewReadingCreateState> emitter) {
    bool itemAdded = false;
    outerLoop:
    for (var itemReadings in allReadings) {
      for (var item in itemReadings.readingsItems) {
        if (item.title == event.title) {
          double calculateSum = item.typeMeasure ==
                  ReadingTypeMeasure.dropdownTypeMeasure[1]
              ? double.parse(item.price) * double.parse(item.area)
              : item.typeMeasure == ReadingTypeMeasure.dropdownTypeMeasure[2]
                  ? double.parse(item.price)
                  : 0;
          final reading = ReadingItem(
              icon: event.icon,
              iconColor: event.iconColor,
              title: event.title,
              typeMeasure: item.typeMeasure,
              unitMeasure: item.unitMeasure,
              price: item.price,
              area: item.area,
              previousReading: item.currentReading,
              previousReadingDay: item.currentReadingDay,
              previousReadingNight: item.currentReadingNight,
              previousReadingHalfPeak: item.currentReadingHalfPeak,
              dayZoneCoeff: item.dayZoneCoeff,
              nightZoneCoeff: item.nightZoneCoeff,
              halfPeakZoneCoeff: item.halfPeakZoneCoeff,
              sum: calculateSum);
          readingItems.add(reading);
          itemAdded = true;
          break outerLoop;
        }
      }
    }
    if (!itemAdded) {
      final reading = ReadingItem(
        icon: event.icon,
        iconColor: event.iconColor,
        title: event.title,
        typeMeasure: ReadingTypeMeasure.dropdownTypeMeasure[0],
        unitMeasure: ReadingUnitsMeasure.dropdownUnitsMeasure[0],
      );
      readingItems.add(reading);
    }
    emit(
      state.copyWith(
        readingItems: readingItems,
        indexService: state.readingItems.length - 1,
      ),
    );
    add(NewReadingChangeServiceEvent(state.readingItems.length - 1));

    event.context.router.pop();
  }

  _onPickDate(NewReadingPickDateEvent event,
      Emitter<NewReadingCreateState> emit) async {
    DateTime? pickedDate = await datePicker(event.ctx);
    if (pickedDate != null) {
      emit(state.copyWith(date: pickedDate.toString()));
    }
  }

  _onPickTypeMeasure(NewReadingPickTypeMeasureEvent event,
      Emitter<NewReadingCreateState> emit) {
    final List<ReadingItem> updatedReadings = state.readingItems;
    updatedReadings[state.indexService] =
        updatedReadings[state.indexService].copyWith(
      typeMeasure: event.typeMeasure,
      unitMeasure: ReadingUnitsMeasure.dropdownUnitsMeasure[0],
      price: '',
      area: '',
      previousReading: '',
      currentReading: '',
      previousReadingDay: '',
      previousReadingNight: '',
      previousReadingHalfPeak: '',
      currentReadingHalfPeak: '',
      currentReadingDay: '',
      currentReadingNight: '',
      dayZoneCoeff: '',
      nightZoneCoeff: '',
      halfPeakZoneCoeff: '',
      comment: '',
      sum: 0,
      used: 0,
      usedDay: 0,
      usedNight: 0,
      usedHalfPeak: 0,
    );
    emit(state.copyWith(readingItems: updatedReadings));
  }

  _onPickUnitMeasure(NewReadingPickUnitMeasureEvent event,
      Emitter<NewReadingCreateState> emit) {
    final List<ReadingItem> updatedReadings = state.readingItems;
    updatedReadings[state.indexService] = updatedReadings[state.indexService]
        .copyWith(unitMeasure: event.uniteMeasure);
    emit(state.copyWith(readingItems: updatedReadings));
  }

  _onChangeService(
      NewReadingChangeServiceEvent event, Emitter<NewReadingCreateState> emit) {
    emit(state.copyWith(indexService: event.indexService));
  }

  _onCalculateArea(
      NewReadingCalculateAreaEvent event, Emitter<NewReadingCreateState> emit) {
    final List<ReadingItem> updatedReading = state.readingItems;
    final double totalSum =
        (event.price.isEmpty ? 0.0 : double.parse(event.price)) *
            (event.area.isEmpty ? 0.0 : double.parse(event.area));
    updatedReading[state.indexService] =
        updatedReading[state.indexService].copyWith(
      price: event.price,
      area: event.area,
      sum: totalSum,
      comment: event.comment,
    );
    emit(state.copyWith(readingItems: updatedReading));
  }

  _onCalculateFixed(NewReadingCalculateFixedEvent event,
      Emitter<NewReadingCreateState> emit) {
    final List<ReadingItem> updatedReading = state.readingItems;
    final double totalSum =
        event.price.isEmpty ? 0.0 : double.parse(event.price);
    updatedReading[state.indexService] =
        updatedReading[state.indexService].copyWith(
      price: event.price,
      sum: totalSum,
      comment: event.comment,
    );
    emit(state.copyWith(readingItems: updatedReading));
  }

  _onCalculateSingleZoneMeter(NewReadingCalculateSingleZoneMeterEvent event,
      Emitter<NewReadingCreateState> emit) {
    final List<ReadingItem> updatedReading = state.readingItems;
    final double price = event.price.isEmpty ? 0.0 : double.parse(event.price);
    final double previousReading = event.previousReading.isEmpty
        ? 0.0
        : double.parse(event.previousReading);
    final double currentReading =
        event.currentReading.isEmpty ? 0.0 : double.parse(event.currentReading);
    final double totalUsed = currentReading - previousReading;
    final double totalSum = price * totalUsed;
    updatedReading[state.indexService] =
        updatedReading[state.indexService].copyWith(
      price: event.price,
      previousReading: event.previousReading,
      currentReading: event.currentReading,
      used: totalUsed,
      sum: totalSum,
      comment: event.comment,
    );
    emit(state.copyWith(readingItems: updatedReading));
  }

  _onCalculateTwoZoneMeter(NewReadingCalculateTwoZoneMeterEvent event,
      Emitter<NewReadingCreateState> emit) {
    final List<ReadingItem> updatedReading = state.readingItems;
    final double price = event.price.isEmpty ? 0.0 : double.parse(event.price);
    final double previousReadingDay = event.previousReadingDay.isEmpty
        ? 0.0
        : double.parse(event.previousReadingDay);
    final double previousReadingNight = event.previousReadingNight.isEmpty
        ? 0.0
        : double.parse(event.previousReadingNight);
    final double currentReadingDay = event.currentReadingDay.isEmpty
        ? 0.0
        : double.parse(event.currentReadingDay);
    final double currentReadingNight = event.currentReadingNight.isEmpty
        ? 0.0
        : double.parse(event.currentReadingNight);
    final double dayZoneCoeff =
        event.dayZoneCoeff.isEmpty ? 0.0 : double.parse(event.dayZoneCoeff);
    final double nightZoneCoeff =
        event.nightZoneCoeff.isEmpty ? 0.0 : double.parse(event.nightZoneCoeff);
    final double totalUsedDay = currentReadingDay - previousReadingDay;
    final double totalUsedNight = currentReadingNight - previousReadingNight;
    final double totalSum = (totalUsedDay * price * dayZoneCoeff) +
        (totalUsedNight * price * nightZoneCoeff);
    updatedReading[state.indexService] =
        updatedReading[state.indexService].copyWith(
      price: event.price,
      previousReadingDay: event.previousReadingDay,
      previousReadingNight: event.previousReadingNight,
      currentReadingDay: event.currentReadingDay,
      currentReadingNight: event.currentReadingNight,
      dayZoneCoeff: event.dayZoneCoeff,
      nightZoneCoeff: event.nightZoneCoeff,
      usedDay: totalUsedDay,
      usedNight: totalUsedNight,
      sum: totalSum,
      comment: event.comment,
    );
    emit(state.copyWith(readingItems: updatedReading));
  }

  _onCalculateThreeZoneMeter(NewReadingCalculateThreeZoneMeterEvent event,
      Emitter<NewReadingCreateState> emit) {
    final List<ReadingItem> updatedReading = state.readingItems;
    final double price = event.price.isEmpty ? 0.0 : double.parse(event.price);
    final double previousReadingDay = event.previousReadingDay.isEmpty
        ? 0.0
        : double.parse(event.previousReadingDay);
    final double previousReadingHalfPeak = event.previousReadingHalfPeak.isEmpty
        ? 0.0
        : double.parse(event.previousReadingHalfPeak);
    final double previousReadingNight = event.previousReadingNight.isEmpty
        ? 0.0
        : double.parse(event.previousReadingNight);
    final double currentReadingDay = event.currentReadingDay.isEmpty
        ? 0.0
        : double.parse(event.currentReadingDay);
    final double currentReadingHalfPeak = event.currentReadingHalfPeak.isEmpty
        ? 0.0
        : double.parse(event.currentReadingHalfPeak);
    final double currentReadingNight = event.currentReadingNight.isEmpty
        ? 0.0
        : double.parse(event.currentReadingNight);
    final double dayZoneCoeff =
        event.dayZoneCoeff.isEmpty ? 0.0 : double.parse(event.dayZoneCoeff);
    final double halfPeakZoneCoeff = event.halfPeakZoneCoeff.isEmpty
        ? 0.0
        : double.parse(event.halfPeakZoneCoeff);
    final double nightZoneCoeff =
        event.nightZoneCoeff.isEmpty ? 0.0 : double.parse(event.nightZoneCoeff);
    final double totalUsedDay = currentReadingDay - previousReadingDay;
    final double totalUsedHalfPeak =
        currentReadingHalfPeak - previousReadingHalfPeak;
    final double totalUsedNight = currentReadingNight - previousReadingNight;
    final double totalSum = (totalUsedDay * price * dayZoneCoeff) +
        (totalUsedNight * price * nightZoneCoeff) +
        (totalUsedHalfPeak * price * halfPeakZoneCoeff);
    updatedReading[state.indexService] =
        updatedReading[state.indexService].copyWith(
      price: event.price,
      previousReadingDay: event.previousReadingDay,
      previousReadingNight: event.previousReadingNight,
      previousReadingHalfPeak: event.previousReadingHalfPeak,
      currentReadingHalfPeak: event.currentReadingHalfPeak,
      currentReadingDay: event.currentReadingDay,
      currentReadingNight: event.currentReadingNight,
      dayZoneCoeff: event.dayZoneCoeff,
      nightZoneCoeff: event.nightZoneCoeff,
      halfPeakZoneCoeff: event.halfPeakZoneCoeff,
      usedDay: totalUsedDay,
      usedHalfPeak: totalUsedHalfPeak,
      usedNight: totalUsedNight,
      sum: totalSum,
      comment: event.comment,
    );
    emit(state.copyWith(readingItems: updatedReading));
  }

  _onDeleteService(
      NewReadingDeleteServiceEvent event, Emitter<NewReadingCreateState> emit) {
    final List<ReadingItem> updatedReading = state.readingItems;
    updatedReading.removeAt(state.indexService);
    add(NewReadingChangeServiceEvent(state.readingItems.length - 1));
    emit(state.copyWith(readingItems: updatedReading));
  }

  _onSaveReading(
      NewReadingSaveEvent event, Emitter<NewReadingCreateState> emit) async {
    final List<ReadingItem> updatedReading = state.readingItems;
    double totalSum = 0;
    for (var item in updatedReading) {
      totalSum += item.sum;
    }
    if (state.readingActionType == ReadingActionType.newReading) {
      final ReadingModel reading = ReadingModel(
        id: const Uuid().v4obj().toString(),
        date: state.date,
        totalSum: totalSum,
        readingsItems: state.readingItems,
      );
      final RequestResult<ReadingModel> requestResult =
          await createReadingUseCase(params: reading);
      if (requestResult is RequestSuccess) {
        emit(NewReadingSuccessState());
        event.context.router.pop();
      } else if (requestResult is RequestError) {
        emit(NewReadingErrorState(requestResult.errorMessage!));
      }
    } else if (state.readingActionType == ReadingActionType.editReading) {
      final ReadingModel reading = ReadingModel(
        id: state.readingId,
        date: state.date,
        totalSum: totalSum,
        readingsItems: state.readingItems,
      );
      final RequestResult<ReadingModel> requestResult =
          await updateReadingUseCase(params: reading);
      if (requestResult is RequestSuccess) {
        emit(NewReadingSuccessState());
        event.context.router.pop();
      } else if (requestResult is RequestError) {
        emit(NewReadingErrorState(requestResult.errorMessage!));
      }
    }
  }
  _onShareData(NewReadingShareEvent event, Emitter<NewReadingCreateState> emit){
    final List<ReadingItem> shareData = state.readingItems;
    final locale = AppLocalizations.of(event.context)!;
    shareData[state.indexService].typeMeasure == ReadingTypeMeasure.undetectableType
        ? Share.share('')
        : shareData[state.indexService].typeMeasure == ReadingTypeMeasure.areaType
        ? Share.share(
        '${shareData[state.indexService].title}\n'
            '${locale.sum_inscription} ${shareData[state.indexService].sum.toStringAsFixed(2)} ${event.currency}')
        : shareData[state.indexService].typeMeasure == ReadingTypeMeasure.fixedType
        ? Share.share(
        '${shareData[state.indexService].title}\n'
            '${locale.sum_inscription} ${shareData[state.indexService].sum.toStringAsFixed(2)} ${event.currency}')
        : shareData[state.indexService].typeMeasure == ReadingTypeMeasure.singleZoneMeterType
        ? Share.share('${shareData[state.indexService].title}\n'
        '${locale.current_readings_unit_hint_text}: ${shareData[state.indexService].currentReading}\n'
        '${locale.used_inscription} ${shareData[state.indexService].used} ${getCurrentUnitMeasure()}'
        '\n${locale.sum_inscription} ${shareData[state.indexService].sum.toStringAsFixed(2)} ${event.currency}')
        : shareData[state.indexService].typeMeasure == ReadingTypeMeasure.twoZoneMeterType
        ?  Share.share('${shareData[state.indexService].title}\n'
           '${locale.current_indicators_day_share}: ${shareData[state.indexService].currentReadingDay} ${getCurrentUnitMeasure()}\n'
           '${locale.current_indicators_night_share}: ${shareData[state.indexService].currentReadingNight} ${getCurrentUnitMeasure()}\n'
           '${locale.used_day_inscription} ${shareData[state.indexService].usedDay} ${getCurrentUnitMeasure()}\n'
           '${locale.used_night_inscription} ${shareData[state.indexService].usedNight} ${getCurrentUnitMeasure()}\n'
           '${locale.sum_inscription} ${shareData[state.indexService].sum.toStringAsFixed(2)} ${event.currency}')
        : shareData[state.indexService].typeMeasure == ReadingTypeMeasure.threeZoneMeterType
        ? Share.share('${shareData[state.indexService].title}\n'
        '${locale.current_indicators_day_share}: ${shareData[state.indexService].currentReadingDay} ${getCurrentUnitMeasure()}\n'
        '${locale.current_indicators_half_pick_share}: ${shareData[state.indexService].currentReadingHalfPeak} ${getCurrentUnitMeasure()}\n'
        '${locale.current_indicators_night_share}: ${shareData[state.indexService].currentReadingNight} ${getCurrentUnitMeasure()}\n'
        '${locale.used_day_inscription} ${shareData[state.indexService].usedDay}  ${getCurrentUnitMeasure()} ${getCurrentUnitMeasure()}\n'
        '${locale.used_half_peak_inscription} ${shareData[state.indexService].usedHalfPeak} ${getCurrentUnitMeasure()}\n'
        '${locale.used_night_inscription} ${shareData[state.indexService].usedNight} ${getCurrentUnitMeasure()}\n'
        '${locale.sum_inscription} ${shareData[state.indexService].sum.toStringAsFixed(2)} ${event.currency}')
         : Share.share('');
  }

  String getCurrentUnitMeasure(){
    final unitMeasure =
    state.readingItems[state.indexService].unitMeasure == ReadingUnitsMeasure.undetectableUnits
        ? ''
        : getDropDownMeasureLabel(state.readingItems[state.indexService].unitMeasure, ctx);
    return unitMeasure;
  }


}
