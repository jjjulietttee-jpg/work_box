import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/services/conversion_service.dart';

part 'converter_state.dart';

class ConverterCubit extends Cubit<ConverterState> {
  final ConversionService conversionService;

  ConverterCubit({ConversionService? conversionService})
      : conversionService = conversionService ?? ConversionServiceImpl(),
        super(ConverterState());

  void setFromUnit(String unit) {
    emit(state.copyWith(fromUnit: unit));
    _convert();
  }

  void setToUnit(String unit) {
    emit(state.copyWith(toUnit: unit));
    _convert();
  }

  void setFromValue(String value) {
    final numValue = double.tryParse(value) ?? 0.0;
    emit(state.copyWith(fromValue: numValue));
    _convert();
  }

  void _convert() {
    final fromValue = state.fromValue;
    final fromUnit = state.fromUnit;
    final toUnit = state.toUnit;

    double result = 0;

    if (state.converterType == ConverterType.length) {
      result = conversionService.convertLength(fromValue, fromUnit, toUnit);
    } else if (state.converterType == ConverterType.weight) {
      result = conversionService.convertWeight(fromValue, fromUnit, toUnit);
    } else if (state.converterType == ConverterType.temperature) {
      result = conversionService.convertTemperature(fromValue, fromUnit, toUnit);
    }

    final resultString = result % 1 == 0
        ? result.toInt().toString()
        : result.toStringAsFixed(6).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');

    emit(state.copyWith(toValue: resultString));
  }

  void swapUnits() {
    final fromUnit = state.fromUnit;
    final toUnit = state.toUnit;
    emit(state.copyWith(
      fromUnit: toUnit,
      toUnit: fromUnit,
    ));
    _convert();
  }

  void setConverterType(ConverterType type) {
    List<String> units;
    if (type == ConverterType.length) {
      units = ['m', 'km', 'cm', 'mm', 'in', 'ft', 'yd', 'mi'];
    } else if (type == ConverterType.weight) {
      units = ['kg', 'g', 'mg', 'lb', 'oz'];
    } else {
      units = ['°C', '°F', 'K'];
    }

    emit(state.copyWith(
      converterType: type,
      availableUnits: units,
      fromUnit: units[0],
      toUnit: units[1],
    ));
    _convert();
  }
}

enum ConverterType { length, weight, temperature }

