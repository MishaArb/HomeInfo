import 'package:equatable/equatable.dart';

class ReminderEntity extends Equatable{
  const ReminderEntity({
    required this.id,
    required this.date,
    required this.isRepeat,
    required this.title,
    required this.description,
  });

  final String id;
  final String date;
  final bool isRepeat;
  final String title;
  final String description;


  @override
  List<Object?> get props =>[id, date, isRepeat,  title, description];

}




