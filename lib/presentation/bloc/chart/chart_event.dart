part of 'chart_bloc.dart';

@immutable
abstract class ChartEvent extends Equatable {}

class ChartInitEvent extends ChartEvent {
  @override
  List<Object?> get props => [];
}

class ChartGetDropDownsItemsEvent extends ChartEvent {
  @override
  List<Object?> get props => [];
}

class ChartBuildChartForServicesEvent extends ChartEvent {
  @override
  List<Object?> get props => [];
}

class ChartBuildTotalChartEvent extends ChartEvent {
  @override
  List<Object?> get props => [];
}

class ChartPickDropDownValueEvent extends ChartEvent {
  ChartPickDropDownValueEvent([
    this.dropDownValue = DropDownValue.totalValue,
  ]);

  final String dropDownValue;

  @override
  List<Object?> get props => [dropDownValue];
}

class ChartChangePeriodEvent extends ChartEvent {
  ChartChangePeriodEvent(this.period);

  final String period;

  @override
  List<Object?> get props => [period];
}
