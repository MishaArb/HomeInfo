import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../core/constants/chart.dart';
import '../../../data/data_sources/sqflite_db.dart';
import '../../../domain/repository/storage_repository.dart';

part 'chart_event.dart';

part 'chart_state.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  ChartBloc(this.storageRepository, this.db) : super(const ChartState()) {
    on<ChartInitEvent>(_onInit);
    on<ChartGetDropDownsItemsEvent>(_onGetDropDownsItems);
    on<ChartPickDropDownValueEvent>(_onPickDropDownValue);
    on<ChartBuildChartForServicesEvent>(_onBuildChartForServices);
    on<ChartBuildTotalChartEvent>(_onBuildTotalChart);
    on<ChartChangePeriodEvent>(_onChangePeriod);
  }

  final SQfliteDB db;

  final StorageRepository storageRepository;

  _onInit(ChartInitEvent event, Emitter<ChartState> emit) async {
    String chartPeriod = await storageRepository.loadStorageData(
      ChartPeriod.periodKey,
      defaultValue: ChartPeriod.monthsPeriod,
    );

    emit(state.copyWith(chartPeriod: chartPeriod));
    add(ChartPickDropDownValueEvent());
  }

  _onGetDropDownsItems(
      ChartGetDropDownsItemsEvent event, Emitter<ChartState> emit) async {
    final readings = await db.getAllReadings();
    List<String> dropDownsItems = [DropDownValue.totalValue];
    for (var item in readings.reversed) {
      for (var item in item.readingsItems) {
        if (!dropDownsItems.contains(item.title)) {
          dropDownsItems.add(item.title);
        }
      }
    }

    emit(state.copyWith(dropDownsItems: dropDownsItems));
  }

  _onPickDropDownValue(
      ChartPickDropDownValueEvent event, Emitter<ChartState> emit) async {
    add(ChartGetDropDownsItemsEvent());

    emit(state.copyWith(dropDownsValue: event.dropDownValue));
    if (event.dropDownValue == DropDownValue.totalValue) {
      add(ChartBuildTotalChartEvent());
    } else {
      add(ChartBuildChartForServicesEvent());
    }
  }

  _onBuildChartForServices(
      ChartBuildChartForServicesEvent event, Emitter<ChartState> emit) async {
    final readings = await db.getAllReadings();
    final Map<String, double> chartColumnMap = {};
    String date = '';
    for (var item in readings.reversed) {
      if (state.chartPeriod == ChartPeriod.monthsPeriod) {
        date = DateFormat('MM.yy').format(DateTime.parse(item.date));
      } else {
        date = DateFormat('yyyy').format(DateTime.parse(item.date));
      }

      for (var item in item.readingsItems) {
        if (item.title == state.dropDownsValue) {
          if (!chartColumnMap.containsKey(date)) {
            chartColumnMap.addAll({date: item.sum});
          } else {
            chartColumnMap[date] =
                (chartColumnMap[date] ?? 0) + (item.sum ?? 0);
          }
        }
      }
    }

    final double maxValue = chartColumnMap.isEmpty
        ? 0
        : chartColumnMap.values
            .reduce((value, element) => value > element ? value : element);
    emit(
      state.copyWith(
        maxValue: maxValue,
        chartColumn: chartColumnMap,
      ),
    );
  }

  _onBuildTotalChart(
      ChartBuildTotalChartEvent event, Emitter<ChartState> emit) async {
    final readings = await db.getAllReadings();
    final Map<String, double> chartColumnMap = {};
    String date = '';
    for (var item in readings.reversed) {
      if (state.chartPeriod == ChartPeriod.monthsPeriod) {
        date = DateFormat('MM.yy').format(DateTime.parse(item.date));
      } else {
        date = DateFormat('yyyy').format(DateTime.parse(item.date));
      }

      if (!chartColumnMap.containsKey(date)) {
        chartColumnMap.addAll({date: item.totalSum});
      } else {
        chartColumnMap[date] =
            (chartColumnMap[date] ?? 0) + (item.totalSum ?? 0);
      }
    }
    final double maxValue = chartColumnMap.isEmpty
        ? 0
        : chartColumnMap.values
            .reduce((value, element) => value > element ? value : element);
    emit(
      state.copyWith(
        maxValue: maxValue,
        chartColumn: chartColumnMap,
      ),
    );
  }

  _onChangePeriod(
      ChartChangePeriodEvent event, Emitter<ChartState> emit) async {
    await storageRepository.saveStorageData(
      ChartPeriod.periodKey,
      event.period,
    );
    emit(state.copyWith(chartPeriod: event.period));
    add(ChartPickDropDownValueEvent(state.dropDownsValue));
  }
}
