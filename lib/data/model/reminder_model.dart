import '../../domain/entities/reminder_entity.dart';

class ReminderModel extends ReminderEntity {
  const ReminderModel({
    required String id,
    required String date,
    required bool isRepeat,
    required String title,
    required String description,
  }) : super(
            id: id,
            date: date,
            isRepeat: isRepeat,
            title: title,
            description: description);

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'isRepeat': isRepeat ? 1 : 0,
        'title': title,
        'description': description ?? ''
      };

  factory ReminderModel.fromJson(Map<String, dynamic> json) => ReminderModel(
        id: json['id'],
        date: json['date'],
        isRepeat: json['isRepeat'] == 1 ? true : false,
        title: json['title'],
        description: json['description'],
      );

  factory ReminderModel.fromEntity(ReminderEntity entity) => ReminderModel(
        id:  entity.id,
        date: entity.date,
        isRepeat: entity.isRepeat,
        title: entity.title,
        description: entity.description,
      );

}
