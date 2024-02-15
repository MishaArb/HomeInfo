import '../../domain/entities/reminder_entity.dart';

class ReminderModel extends ReminderEntity {
  const ReminderModel({
    required String id,
    required int notificationId,
    required String date,
    required bool isRepeat,
    required String title,
    required String description,
  }) : super(
            id: id,
            notificationId : notificationId,
            date: date,
            isRepeat: isRepeat,
            title: title,
            description: description,
  );

  Map<String, dynamic> toJson() => {
        'id': id,
        'notificationId' : notificationId,
        'date': date,
        'isRepeat': isRepeat ? 1 : 0,
        'title': title,
        'description': description
      };

  factory ReminderModel.fromJson(Map<String, dynamic> json) => ReminderModel(
        id: json['id'],
        notificationId: json['notificationId'],
        date: json['date'],
        isRepeat: json['isRepeat'] == 1 ? true : false,
        title: json['title'],
        description: json['description'],
      );

  factory ReminderModel.fromEntity(ReminderEntity entity) => ReminderModel(
        id:  entity.id,
        notificationId:  entity.notificationId,
        date: entity.date,
        isRepeat: entity.isRepeat,
        title: entity.title,
        description: entity.description,
      );

}
