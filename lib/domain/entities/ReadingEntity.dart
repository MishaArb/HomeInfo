import 'package:equatable/equatable.dart';

import '../../data/model/reading_model.dart';

class ReadingEntity extends Equatable {
  const ReadingEntity({
    required this.id,
    required this.date,
    required this.totalSum,
    required this.readingsItems,
  });

  final String id;
  final String date;
  final double totalSum;
  final List<ReadingItem> readingsItems;

  @override
  List<Object?> get props => [id, date, totalSum, totalSum, readingsItems];
}
