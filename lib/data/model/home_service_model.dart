import '../../domain/entities/service_entity.dart';

class HomeServiceModel extends HomeServiceEntity {
  const HomeServiceModel({
    required String id,
    required String title,
    required int icon,
    required int iconColor,
  }) : super(id: id, title: title, icon: icon, iconColor: iconColor);

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'icon': icon,
        'iconColor': iconColor,
      };

  factory HomeServiceModel.fomMap(Map<String, dynamic> map) => HomeServiceModel(
        id: map['id'],
        title: map['title'],
        icon: map['icon'],
        iconColor: map['iconColor'],
      );

  factory HomeServiceModel.fromEntity(HomeServiceEntity entity) =>
      HomeServiceModel(
        id: entity.id,
        title: entity.title,
        icon: entity.icon,
        iconColor: entity.iconColor,
      );
}
