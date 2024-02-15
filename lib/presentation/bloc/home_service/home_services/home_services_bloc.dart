import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/request_result/request_result.dart';
import '../../../../data/model/home_service_model.dart';
import '../../../../domain/entities/service_entity.dart';
import '../../../../domain/repository/home_services_db_repository.dart';
import '../../../../domain/usecase/delete_home_service_usercase.dart';
import '../../../../domain/usecase/fetch_home_service_usercase.dart';

part 'home_services_event.dart';

part 'home_services_state.dart';

class HomeServicesBloc extends Bloc<HomeServicesEvent, HomeServicesState> {
  HomeServicesBloc(
      this.deleteHomeServiceRemindersUseCase, this.fetchHomeServicesUseCase)
      : super(ServicesLoadingState()) {
    on<HomeServicesFetchEvent>(_onFetchServices);
    on<HomeServicesDeleteEvent>(_onDeleteService);
  }

  final DeleteHomeServiceUseCase deleteHomeServiceRemindersUseCase;
  final FetchHomeServicesUseCase fetchHomeServicesUseCase;

  _onFetchServices(
      HomeServicesFetchEvent event, Emitter<HomeServicesState> emit) async {
    emit(ServicesLoadingState());
    final requestResult = await fetchHomeServicesUseCase();
    if (requestResult is RequestSuccess) {
      emit(HomeServicesSuccessState(requestResult.data!));
    } else if (requestResult is RequestError) {
      emit(HomeServicesErrorState(requestResult.errorMessage!));
    }
  }

  _onDeleteService(
      HomeServicesDeleteEvent event, Emitter<HomeServicesState> emit) async {
    final requestResult =
        await deleteHomeServiceRemindersUseCase(params: event.id);
    if (requestResult is RequestSuccess) {
      add(HomeServicesFetchEvent());
      event.context.router.pop();
    } else if (requestResult is RequestError) {
      emit(HomeServicesErrorState(requestResult.errorMessage!));
    }
  }
}
