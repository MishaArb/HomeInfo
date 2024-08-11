import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../core/constants/reading.dart';

getDropDownMeasureLabel(String value, BuildContext ctx) {
  switch (value) {
    case ReadingTypeMeasure.undetectableType:
      return AppLocalizations.of(ctx)!.select_measurement_type_dropdown;
    case ReadingTypeMeasure.areaType:
      return AppLocalizations.of(ctx)!.by_area_dropdown;
    case ReadingTypeMeasure.fixedType:
      return AppLocalizations.of(ctx)!.fixed_dropdown;
    case ReadingTypeMeasure.singleZoneMeterType:
      return AppLocalizations.of(ctx)!.single_zone_meter_dropdown;
    case ReadingTypeMeasure.twoZoneMeterType:
      return AppLocalizations.of(ctx)!.two_zone_meter_dropdown;
    case ReadingTypeMeasure.threeZoneMeterType:
      return AppLocalizations.of(ctx)!.three_zone_meter_dropdown;

    case ReadingUnitsMeasure.undetectableUnits:
      return AppLocalizations.of(ctx)!.select_measurement_unit_dropdown;
    case ReadingUnitsMeasure.kWUnit:
      return AppLocalizations.of(ctx)!.kW_dropdown;
    case ReadingUnitsMeasure.m2Unit:
      return AppLocalizations.of(ctx)!.m2_dropdown;
    case ReadingUnitsMeasure.m3Unit:
      return AppLocalizations.of(ctx)!.m3_dropdown;
    case ReadingUnitsMeasure.gCalUnit:
      return AppLocalizations.of(ctx)!.gcal_dropdown;
    default:
      return '';
  }
}