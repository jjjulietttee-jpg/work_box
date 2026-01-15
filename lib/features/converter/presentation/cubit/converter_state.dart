part of 'converter_cubit.dart';

class ConverterState extends Equatable {
  final ConverterType converterType;
  final List<String> availableUnits;
  final String fromUnit;
  final String toUnit;
  final double fromValue;
  final String toValue;

  const ConverterState({
    this.converterType = ConverterType.length,
    this.availableUnits = const ['m', 'km', 'cm', 'mm', 'in', 'ft', 'yd', 'mi'],
    this.fromUnit = 'm',
    this.toUnit = 'km',
    this.fromValue = 0,
    this.toValue = '0',
  });

  ConverterState copyWith({
    ConverterType? converterType,
    List<String>? availableUnits,
    String? fromUnit,
    String? toUnit,
    double? fromValue,
    String? toValue,
  }) {
    return ConverterState(
      converterType: converterType ?? this.converterType,
      availableUnits: availableUnits ?? this.availableUnits,
      fromUnit: fromUnit ?? this.fromUnit,
      toUnit: toUnit ?? this.toUnit,
      fromValue: fromValue ?? this.fromValue,
      toValue: toValue ?? this.toValue,
    );
  }

  @override
  List<Object> get props => [
        converterType,
        availableUnits,
        fromUnit,
        toUnit,
        fromValue,
        toValue,
      ];
}

