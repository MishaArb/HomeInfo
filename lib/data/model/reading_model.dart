import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/ReadingEntity.dart';

class ReadingModel extends ReadingEntity {
  const ReadingModel({
   required String id,
    required String date,
    required double totalSum,
    required  List<ReadingItem> readingsItems,
  }) : super(id: id, date: date, totalSum: totalSum, readingsItems: readingsItems);

  ReadingModel copyWith({
    String? id,
    String? date,
    double? totalSum,
    List<ReadingItem>? readingsItems,
  }) {
    return ReadingModel(
      id: id ?? this.id,
      date: date ?? this.date,
      totalSum: totalSum ?? this.totalSum,
      readingsItems: readingsItems ?? this.readingsItems,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date,
        'totalSum': totalSum,
        'readingsItems':
            jsonEncode(readingsItems.map((item) => item.toMap()).toList())
      };

  factory ReadingModel.fromMap(Map<String, dynamic> map) => ReadingModel(
        id: map['id'],
        date: map['date'],
        totalSum: map['totalSum'],
        readingsItems: (jsonDecode(map['readingsItems']) as List<dynamic>)
            .map((itemMap) => ReadingItem.fromMap(itemMap))
            .toList(),
      );

  @override
  List<Object?> get props => [id, date, totalSum, readingsItems];

  @override
  String toString() =>
      'Reading { id: $id, date: $date, totalSum: $totalSum, readingsItems: $readingsItems }';
}

class ReadingItem extends Equatable {
  const ReadingItem({
    this.icon = 0,
    this.typeMeasure = '',
    this.iconColor = 0,
    this.title = '',
    this.unitMeasure = '',
    this.price = '',
    this.area = '',
    this.previousReading = '',
    this.currentReading = '',
    this.previousReadingDay = '',
    this.previousReadingNight = '',
    this.previousReadingHalfPeak = '',
    this.currentReadingHalfPeak = '',
    this.currentReadingDay = '',
    this.currentReadingNight = '',
    this.dayZoneCoeff = '',
    this.nightZoneCoeff = '',
    this.halfPeakZoneCoeff = '',
    this.comment = '',
    this.sum = 0,
    this.used = 0,
    this.usedDay = 0,
    this.usedNight = 0,
    this.usedHalfPeak = 0,
  });

  final int icon;
  final int iconColor;
  final String title;
  final String typeMeasure;
  final String unitMeasure;
  final String price;
  final String area;
  final String previousReading;
  final String currentReading;
  final String previousReadingDay;
  final String previousReadingNight;
  final String previousReadingHalfPeak;
  final String currentReadingHalfPeak;
  final String currentReadingDay;
  final String currentReadingNight;
  final String dayZoneCoeff;
  final String nightZoneCoeff;
  final String halfPeakZoneCoeff;
  final String comment;
  final double sum;
  final double used;
  final double usedDay;
  final double usedNight;
  final double usedHalfPeak;

  Map<String, dynamic> toMap() => {
        'icon': icon,
        'iconColor': iconColor,
        'title': title,
        'typeMeasure': typeMeasure,
        'unitMeasure': unitMeasure,
        'price': price,
        'area': area,
        'previousReading': previousReading,
        'currentReading': currentReading,
        'previousReadingDay': previousReadingDay,
        'previousReadingNight': previousReadingNight,
        'previousReadingHalfPeak': previousReadingHalfPeak,
        'currentReadingHalfPeak': currentReadingHalfPeak,
        'currentReadingDay': currentReadingDay,
        'currentReadingNight': currentReadingNight,
        'dayZoneCoeff': dayZoneCoeff,
        'nightZoneCoeff': nightZoneCoeff,
        'halfPeakZoneCoeff': halfPeakZoneCoeff,
        'comment': comment,
        'sum': sum,
        'used': used,
        'usedDay': usedDay,
        'usedNight': usedNight,
        'usedHalfPeak': usedHalfPeak,
      };

  factory ReadingItem.fromMap(Map<String, dynamic> map) => ReadingItem(
        icon: map['icon'],
        iconColor: map['iconColor'],
        title: map['title'],
        typeMeasure: map['typeMeasure'],
        unitMeasure: map['unitMeasure'],
        price: map['price'],
        area: map['area'],
        previousReading: map['previousReading'],
        currentReading: map['currentReading'],
        previousReadingDay: map['previousReadingDay'],
        previousReadingNight: map['previousReadingNight'],
        previousReadingHalfPeak: map['previousReadingHalfPeak'],
        currentReadingHalfPeak: map['currentReadingHalfPeak'],
        currentReadingDay: map['currentReadingDay'],
        currentReadingNight: map['currentReadingNight'],
        dayZoneCoeff: map['dayZoneCoeff'],
        nightZoneCoeff: map['nightZoneCoeff'],
        halfPeakZoneCoeff: map['halfPeakZoneCoeff'],
        comment: map['comment'],
        sum: map['sum'],
        used: map['used'],
        usedDay: map['usedDay'],
        usedNight: map['usedNight'],
        usedHalfPeak: map['usedHalfPeak'],
      );

  ReadingItem copyWith({
    int? icon,
    int? iconColor,
    String? title,
    String? typeMeasure,
    String? unitMeasure,
    String? price,
    String? area,
    String? previousReading,
    String? currentReading,
    String? previousReadingDay,
    String? previousReadingNight,
    String? previousReadingHalfPeak,
    String? currentReadingHalfPeak,
    String? currentReadingDay,
    String? currentReadingNight,
    String? dayZoneCoeff,
    String? nightZoneCoeff,
    String? halfPeakZoneCoeff,
    String? comment,
    double? sum,
    double? used,
    double? usedDay,
    double? usedNight,
    double? usedHalfPeak,
  }) {
    return ReadingItem(
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
      title: title ?? this.title,
      typeMeasure: typeMeasure ?? this.typeMeasure,
      unitMeasure: unitMeasure ?? this.unitMeasure,
      price: price ?? this.price,
      area: area ?? this.area,
      previousReading: previousReading ?? this.previousReading,
      currentReading: currentReading ?? this.currentReading,
      previousReadingDay: previousReadingDay ?? this.previousReadingDay,
      previousReadingNight: previousReadingNight ?? this.previousReadingNight,
      previousReadingHalfPeak:
          previousReadingHalfPeak ?? this.previousReadingHalfPeak,
      currentReadingHalfPeak:
          currentReadingHalfPeak ?? this.currentReadingHalfPeak,
      currentReadingDay: currentReadingDay ?? this.currentReadingDay,
      currentReadingNight: currentReadingNight ?? this.currentReadingNight,
      dayZoneCoeff: dayZoneCoeff ?? this.dayZoneCoeff,
      nightZoneCoeff: nightZoneCoeff ?? this.nightZoneCoeff,
      halfPeakZoneCoeff: halfPeakZoneCoeff ?? this.halfPeakZoneCoeff,
      comment: comment ?? this.comment,
      sum: sum ?? this.sum,
      used: used ?? this.used,
      usedDay: usedDay ?? this.usedDay,
      usedNight: usedNight ?? this.usedNight,
      usedHalfPeak: usedHalfPeak ?? this.usedHalfPeak,
    );
  }

  @override
  List<Object?> get props => [
        icon,
        iconColor,
        typeMeasure,
        title,
        unitMeasure,
        price,
        area,
        previousReading,
        currentReading,
        previousReadingDay,
        previousReadingNight,
        previousReadingHalfPeak,
        currentReadingHalfPeak,
        currentReadingDay,
        currentReadingNight,
        dayZoneCoeff,
        nightZoneCoeff,
        halfPeakZoneCoeff,
        comment,
        sum,
        used,
        usedDay,
        usedNight,
        usedHalfPeak
      ];

  @override
  String toString() =>
      '\nReadingItem{\nicon: $icon\niconColor: $iconColor\ntitle: $title\ntypeMeasure: $typeMeasure\nunitMeasure: $unitMeasure\nprice: $price\narea: $area\npreviousReadings: $previousReading\ncurrentReadings: $currentReading\npreviousReadingDay: $previousReadingDay\npreviousReadingNight: $previousReadingNight\npreviousReadingHalfPeak: $previousReadingHalfPeak\ncurrentReadingHalfPeak: $currentReadingHalfPeak\ncurrentReadingDay: $currentReadingDay\ncurrentReadingNight: $currentReadingNight\ndayZoneCoeff: $dayZoneCoeff\nnightZoneCoeff: $nightZoneCoeff\nhalfPeakZoneCoeff: $halfPeakZoneCoeff\ncomment: $comment\nsum: $sum\nused: $used\nusedDay: $usedDay\nusedNight: $usedNight\nusedHalfPeak: $usedHalfPeak\n}\n';
}
