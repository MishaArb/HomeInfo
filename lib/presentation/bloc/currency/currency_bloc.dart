import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/constants/setting_currency.dart';
import '../../../core/router/router.dart';
import '../../../domain/repository/storage_repository.dart';
import '../../../injection_container.dart';

part 'currency_event.dart';

part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyBloc(this.storageRepository) : super(const CurrencyState()) {
    on<CurrencyInitEvent>(_onInitialized);
    on<SetCurrencyEvent>(_onSetCurrency);
  }

  final StorageRepository storageRepository;

  _onInitialized(CurrencyInitEvent event, Emitter<CurrencyState> emit) async {
    final String currencyValue = await await storageRepository.loadStorageData(
      SettingCurrency.currencyKey,
      defaultValue: '',
    );
    final initialRoute = currencyValue.isEmpty
        ? const CurrencyRoute()
        : const BottomNavigationBarRoute();
    getIt<AppRouter>().pushAndPopUntil(initialRoute, predicate: (_) => false);
    emit( CurrencyState(isInitialized: true, currency:  currencyValue));
  }

  _onSetCurrency(SetCurrencyEvent event, Emitter<CurrencyState> emit) async {
    await storageRepository.saveStorageData(
        SettingCurrency.currencyKey, event.currencyValue);
    if (event.currencyValue.trim().isNotEmpty) {
      add(CurrencyInitEvent());
    }
  }
}
