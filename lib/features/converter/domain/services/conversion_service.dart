abstract class ConversionService {
  double convertLength(double value, String from, String to);
  double convertWeight(double value, String from, String to);
  double convertTemperature(double value, String from, String to);
}

class ConversionServiceImpl implements ConversionService {
  @override
  double convertLength(double value, String from, String to) {
    const conversions = {
      'm': 1.0,
      'km': 0.001,
      'cm': 100.0,
      'mm': 1000.0,
      'in': 39.3701,
      'ft': 3.28084,
      'yd': 1.09361,
      'mi': 0.000621371,
    };

    final fromFactor = conversions[from] ?? 1.0;
    final toFactor = conversions[to] ?? 1.0;

    return value * (toFactor / fromFactor);
  }

  @override
  double convertWeight(double value, String from, String to) {
    const conversions = {
      'kg': 1.0,
      'g': 1000.0,
      'mg': 1000000.0,
      'lb': 2.20462,
      'oz': 35.274,
    };

    final fromFactor = conversions[from] ?? 1.0;
    final toFactor = conversions[to] ?? 1.0;

    return value * (toFactor / fromFactor);
  }

  @override
  double convertTemperature(double value, String from, String to) {
    if (from == to) return value;

    double celsius = value;
    if (from == '°F') {
      celsius = (value - 32) * 5 / 9;
    } else if (from == 'K') {
      celsius = value - 273.15;
    }

    if (to == '°C') {
      return celsius;
    } else if (to == '°F') {
      return celsius * 9 / 5 + 32;
    } else if (to == 'K') {
      return celsius + 273.15;
    }

    return celsius;
  }
}

