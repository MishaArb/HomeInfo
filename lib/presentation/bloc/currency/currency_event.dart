part of 'currency_bloc.dart';

class CurrencyEvent {}
class CurrencyInitEvent extends CurrencyEvent{}
class SetCurrencyEvent extends CurrencyEvent{
  final String currencyValue;
  SetCurrencyEvent(this.currencyValue);
}
