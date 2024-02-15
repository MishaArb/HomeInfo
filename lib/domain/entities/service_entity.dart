import 'package:equatable/equatable.dart';

class HomeServiceEntity extends Equatable {
  const HomeServiceEntity({
    required this.id,
    required this.title,
    required this.icon,
    required this.iconColor,
  });

  final String id;
  final String title;
  final int icon;
  final int iconColor;

  @override
  List<Object?> get props => [id, title, icon, iconColor];
}
