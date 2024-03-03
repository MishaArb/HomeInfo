part of 'chart_bloc.dart';

class ChartState extends Equatable {
  const ChartState({
    this.maxValue = 0,
    this.dropDownsItems = const [],
    this.dropDownsValue = '',
    this.chartColumn = const {},
    this.chartPeriod = ChartPeriod.monthsPeriod,
  });

  final double maxValue;
  final List<String> dropDownsItems;
  final String dropDownsValue;
  final Map<String, double> chartColumn;
  final String chartPeriod;

  ChartState copyWith({
    double? maxValue,
    List<String>? dropDownsItems,
    String? dropDownsValue,
    Map<String, double>? chartColumn,
    String? chartPeriod,
  }) {
    return ChartState(
      maxValue: maxValue ?? this.maxValue,
      dropDownsItems: dropDownsItems ?? this.dropDownsItems,
      dropDownsValue: dropDownsValue ?? this.dropDownsValue,
      chartColumn: chartColumn ?? this.chartColumn,
      chartPeriod: chartPeriod ?? this.chartPeriod,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [maxValue, dropDownsItems, dropDownsValue, chartColumn, chartPeriod];
}
