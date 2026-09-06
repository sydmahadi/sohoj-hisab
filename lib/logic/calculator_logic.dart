class CalculatorLogic {
  /// মিনিটকে সুন্দরভাবে ঘণ্টা ও মিনিটে দেখায়।
  static String formatHoursAndMinutes(double totalMinutes) {
    int total = totalMinutes.round();

    if (total < 0) {
      total = 0;
    }

    final int hours = total ~/ 60;
    final int minutes = total % 60;

    if (hours == 0) {
      return '$minutes মিনিট';
    }

    if (minutes == 0) {
      return '$hours ঘণ্টা';
    }

    return '$hours ঘণ্টা $minutes মিনিট';
  }

  /// দৈনিক গড় - সংখ্যা
  static String dailyCount({
    required double days,
    required double value,
  }) {
    if (days <= 0) {
      return 'সঠিক দিন ইনপুট দিন';
    }

    if (value < 0) {
      return 'সঠিক সংখ্যা ইনপুট দিন';
    }

    final double result = value / days;

    return result.toStringAsFixed(2);
  }

  /// দৈনিক গড় - সময়
  static String dailyTimeInMinutes({
    required double days,
    required double totalMinutes,
  }) {
    if (days <= 0) {
      return 'সঠিক দিন ইনপুট দিন';
    }

    if (totalMinutes < 0) {
      return 'সঠিক সময় ইনপুট দিন';
    }

    final double result = totalMinutes / days;

    return formatHoursAndMinutes(result);
  }

  /// মাসিক গড় - সংখ্যা
  ///
  /// মাসকে নির্দিষ্টভাবে ৩০ দিন ধরা হয়েছে।
  static String monthlyCount({
    required double days,
    required double value,
  }) {
    if (days <= 0) {
      return 'সঠিক দিন ইনপুট দিন';
    }

    if (value < 0) {
      return 'সঠিক সংখ্যা ইনপুট দিন';
    }

    const double monthDays = 30.0;

    final double dailyAverage = value / days;
    final double monthlyAverage =
        dailyAverage * monthDays;

    return monthlyAverage.toStringAsFixed(2);
  }

  /// মাসিক গড় - সময়
  ///
  /// মাসকে নির্দিষ্টভাবে ৩০ দিন ধরা হয়েছে।
  static String monthlyTime({
    required double days,
    required double totalMinutes,
  }) {
    if (days <= 0) {
      return 'সঠিক দিন ইনপুট দিন';
    }

    if (totalMinutes < 0) {
      return 'সঠিক সময় ইনপুট দিন';
    }

    const double monthDays = 30.0;

    final double dailyAverage =
        totalMinutes / days;

    final double monthlyAverage =
        dailyAverage * monthDays;

    return formatHoursAndMinutes(
      monthlyAverage,
    );
  }
}
