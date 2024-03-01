class ReadingTypeMeasure{
  static const undetectableType = 'undetectable_type';
  static const areaType = 'area_type';
  static const fixedType = 'fixed_type';
  static const singleZoneMeterType = 'single_zone_meter_type';
  static const twoZoneMeterType = 'two_zone_meter_type';
  static const threeZoneMeterType = 'three_zone_meter_type';

  static const List<String> dropdownTypeMeasure = [
    ReadingTypeMeasure.undetectableType,
    ReadingTypeMeasure.areaType,
    ReadingTypeMeasure.fixedType,
    ReadingTypeMeasure.singleZoneMeterType,
    ReadingTypeMeasure.twoZoneMeterType,
    ReadingTypeMeasure.threeZoneMeterType,
  ];

}

class ReadingUnitsMeasure{
  static const undetectableUnits = 'undetectable_unit';
  static const kWUnit = 'kW_unit';
  static const m2Unit = 'm2_unit';
  static const m3Unit = 'm3_unit';
  static const gCalUnit = 'gCal_unit';

  static const List<String> dropdownUnitsMeasure = [
    ReadingUnitsMeasure.undetectableUnits,
    ReadingUnitsMeasure.kWUnit,
    ReadingUnitsMeasure.m2Unit,
    ReadingUnitsMeasure.m3Unit,
    ReadingUnitsMeasure.gCalUnit,
  ];

}
