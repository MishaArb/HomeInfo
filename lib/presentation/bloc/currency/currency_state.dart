part of 'currency_bloc.dart';

@immutable
class CurrencyState {
 final bool isInitialized;
 final String currency;
 const CurrencyState({this.isInitialized = false, this.currency = ''});
}

