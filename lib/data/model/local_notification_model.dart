import 'package:equatable/equatable.dart';

class LocalNotificationModel extends Equatable {
  const LocalNotificationModel({
      required this.id,
      required this.title,
      required this.body,
      this.payLoad,
      required this.scheduleDateTime,
      required this.isRepeat
  });

  final int id;
  final String title;
  final String body;
  final String? payLoad;
  final String scheduleDateTime;
  final bool isRepeat;

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, body, payLoad, scheduleDateTime, isRepeat];
}
