part of 'new_reading_bloc.dart';

@immutable
abstract class NewReadingEvent extends Equatable {}

class NewReadingInitEvent extends NewReadingEvent {
  NewReadingInitEvent({
    required this.context,
    required this.readingActionType,
    this.readingIndex,
  });

  final BuildContext context;
  final ReadingActionType readingActionType;
  final int? readingIndex;

  @override
  List<Object?> get props => [context, readingActionType, readingIndex];
}

class NewReadingAddHomeServiceEvent extends NewReadingEvent {
  NewReadingAddHomeServiceEvent({
    required this.context,
    required this.icon,
    required this.iconColor,
    required this.title,
  });

  final BuildContext context;
  final int icon;
  final int iconColor;
  final String title;

  @override
  List<Object?> get props => [context, icon, iconColor, title];
}

class NewReadingPickTypeMeasureEvent extends NewReadingEvent {
  NewReadingPickTypeMeasureEvent(this.typeMeasure);

  final String typeMeasure;

  @override
  List<Object?> get props => [typeMeasure];
}

class NewReadingPickDateEvent extends NewReadingEvent {
  NewReadingPickDateEvent(this.ctx);

  final BuildContext ctx;

  @override
  List<Object?> get props => [ctx];
}

class NewReadingPickUnitMeasureEvent extends NewReadingEvent {
  NewReadingPickUnitMeasureEvent(this.uniteMeasure);

  final String uniteMeasure;

  @override
  List<Object?> get props => [uniteMeasure];
}

class NewReadingChangeServiceEvent extends NewReadingEvent {
  NewReadingChangeServiceEvent(this.indexService);

  final int indexService;

  @override
  List<Object?> get props => [indexService];
}

class NewReadingCalculateAreaEvent extends NewReadingEvent {
  NewReadingCalculateAreaEvent({
    required this.price,
    required this.area,
    required this.comment,
  });

  final String price;
  final String area;
  final String comment;

  NewReadingCalculateAreaEvent copyWith({
    String? price,
    String? area,
    String? comment,
  }) {
    return NewReadingCalculateAreaEvent(
      price: price ?? this.price,
      area: area ?? this.area,
      comment: comment ?? this.comment,
    );
  }

  @override
  List<Object?> get props => [price, area, comment];
}

class NewReadingCalculateFixedEvent extends NewReadingEvent {
  NewReadingCalculateFixedEvent({required this.price, required this.comment});

  final String price;
  final String comment;

  NewReadingCalculateFixedEvent copyWith({
    String? price,
    String? comment,
  }) {
    return NewReadingCalculateFixedEvent(
      price: price ?? this.price,
      comment: comment ?? this.comment,
    );
  }

  @override
  List<Object?> get props => [price, comment];
}

class NewReadingCalculateSingleZoneMeterEvent extends NewReadingEvent {
  NewReadingCalculateSingleZoneMeterEvent({
    required this.price,
    required this.previousReading,
    required this.currentReading,
    required this.comment,
  });

  final String price;
  final String previousReading;
  final String currentReading;
  final String comment;

  NewReadingCalculateSingleZoneMeterEvent copyWith({
    String? price,
    String? previousReading,
    String? currentReading,
    String? comment,
  }) {
    return NewReadingCalculateSingleZoneMeterEvent(
      price: price ?? this.price,
      previousReading: previousReading ?? this.previousReading,
      currentReading: currentReading ?? this.currentReading,
      comment: comment ?? this.comment,
    );
  }

  @override
  List<Object?> get props => [price, previousReading, currentReading, comment];
}

class NewReadingCalculateTwoZoneMeterEvent extends NewReadingEvent {
  NewReadingCalculateTwoZoneMeterEvent({
    required this.price,
    required this.previousReadingDay,
    required this.previousReadingNight,
    required this.currentReadingDay,
    required this.currentReadingNight,
    required this.dayZoneCoeff,
    required this.nightZoneCoeff,
    required this.comment,
  });

  final String price;
  final String previousReadingDay;
  final String previousReadingNight;
  final String currentReadingDay;
  final String currentReadingNight;
  final String dayZoneCoeff;
  final String nightZoneCoeff;
  final String comment;

  NewReadingCalculateTwoZoneMeterEvent copyWith({
    String? price,
    String? previousReadingDay,
    String? previousReadingNight,
    String? currentReadingDay,
    String? currentReadingNight,
    String? dayZoneCoeff,
    String? nightZoneCoeff,
    String? comment,
  }) {
    return NewReadingCalculateTwoZoneMeterEvent(
      price: price ?? this.price,
      previousReadingDay: previousReadingDay ?? this.previousReadingDay,
      previousReadingNight: previousReadingNight ?? this.previousReadingNight,
      currentReadingDay: currentReadingDay ?? this.currentReadingDay,
      currentReadingNight: currentReadingNight ?? this.currentReadingNight,
      dayZoneCoeff: dayZoneCoeff ?? this.dayZoneCoeff,
      nightZoneCoeff: nightZoneCoeff ?? this.nightZoneCoeff,
      comment: comment ?? this.comment,
    );
  }

  @override
  List<Object?> get props => [
        price,
        previousReadingDay,
        previousReadingNight,
        currentReadingDay,
        currentReadingNight,
        dayZoneCoeff,
        nightZoneCoeff,
        comment
      ];
}

class NewReadingCalculateThreeZoneMeterEvent extends NewReadingEvent {
  NewReadingCalculateThreeZoneMeterEvent({
    required this.price,
    required this.previousReadingDay,
    required this.previousReadingNight,
    required this.previousReadingHalfPeak,
    required this.currentReadingHalfPeak,
    required this.currentReadingDay,
    required this.currentReadingNight,
    required this.dayZoneCoeff,
    required this.nightZoneCoeff,
    required this.halfPeakZoneCoeff,
    required this.comment,
  });

  final String price;
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

  NewReadingCalculateThreeZoneMeterEvent copyWith({
    String? price,
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
  }) {
    return NewReadingCalculateThreeZoneMeterEvent(
      price: price ?? this.price,
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
    );
  }

  @override
  List<Object?> get props => [
        price,
        previousReadingDay,
        previousReadingNight,
        currentReadingDay,
        currentReadingNight,
        dayZoneCoeff,
        nightZoneCoeff,
        comment
      ];
}

class NewReadingDeleteServiceEvent extends NewReadingEvent {
  @override
  List<Object?> get props => [];
}

class NewReadingSaveEvent extends NewReadingEvent {
  NewReadingSaveEvent(this.context);

  final BuildContext context;

  @override
  List<Object?> get props => [];
}

class NewReadingShareEvent extends NewReadingEvent {
  NewReadingShareEvent(this.context, this.currency);

  final BuildContext context;
  final String currency;

  @override
  List<Object?> get props => [];
}
