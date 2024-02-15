part of 'new_home_service_bloc.dart';

class NewHomeServiceState extends Equatable {
  const NewHomeServiceState({this.title = '', this.icon = 2, this.iconColor = 0});

  final String title;
  final int icon;
  final int iconColor;

  NewHomeServiceState copyWith({
    String? title,
    int? icon,
    int? iconColor,
  }) {
    return NewHomeServiceState(
        title: title ?? this.title,
        icon: icon ?? this.icon,
        iconColor: iconColor ?? this.iconColor);
  }

  @override
  List<Object?> get props => [title, icon, iconColor];
}

class NewHomeServiceSaveState extends NewHomeServiceState {
  @override
  List<Object?> get props => [];
}

class NewHomeServiceErrorState extends NewHomeServiceState {
  const NewHomeServiceErrorState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
