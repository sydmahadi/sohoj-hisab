class CalculatorLogic {
  /// ঘণ্টা.মিনিট ফরম্যাটকে মোট মিনিটে রূপান্তর করে।
  ///
  /// যেমন:
  /// 200.20 = 200 ঘণ্টা 20 মিনিট
  /// 345.10 = 345 ঘণ্টা 10 মিনিট
  static int parseTimeToMinutes(String value) {
    value = value.trim();

    if (value.isEmpty) {
      return 0;
    }

    final parts = value.split('.');

    if (parts.length != 2) {
      return -1;
    }

    final hours = int.tryParse(parts[0]);
    final minutes = int.tryParse(parts[1]);

    if (hours == null || minutes == null) {
      return -1;
    }

    if (hours < 0 || minutes < 0 || minutes > 59) {
      return -1;
    }

    return (hours * 60) + minutes;
  }

  /// মোট মিনিটকে ঘণ্টা ও মিনিটে দেখায়।
  static String formatHoursAndMinutes(double totalMinutes) {
    int total = totalMinutes.round();

    if (total < 0) {
      total = 0;
    }

    final hours = total ~/ 60;
    final minutes = total % 60;

    if (hours == 0 && minutes == 0) {
      return '০ ঘণ্টা ০ মিনিট';
    }

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

    final result = value / days;

    return result.toStringAsFixed(2);
  }

  /// দৈনিক গড় - সময়
  ///
  /// সময় অবশ্যই ঘণ্টা.মিনিট ফরম্যাটে হবে।
  static String dailyTime({
    required double days,
    required String time,
  }) {
    if (days <= 0) {
      return 'সঠিক দিন ইনপুট দিন';
    }

    final totalMinutes = parseTimeToMinutes(time);

    if (totalMinutes < 0) {
      return 'সময় সঠিকভাবে লিখুন';
    }

    final dailyAverage = totalMinutes / days;

    return formatHoursAndMinutes(dailyAverage);
  }

  /// মাসিক গড় - সংখ্যা
  ///
  /// মাসকে ৩০ দিন ধরা হয়েছে।
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

    const monthDays = 30.0;

    final dailyAverage = value / days;
    final monthlyAverage = dailyAverage * monthDays;

    return monthlyAverage.toStringAsFixed(2);
  }

  /// মাসিক গড় - সময়
  ///
  /// সময় অবশ্যই ঘণ্টা.মিনিট ফরম্যাটে হবে।
  /// যেমন 200.20 = ২০০ ঘণ্টা ২০ মিনিট।
  static String monthlyTime({
    required double days,
    required String time,
  }) {
    if (days <= 0) {
      return 'সঠিক দিন ইনপুট দিন';
    }

    final totalMinutes = parseTimeToMinutes(time);

    if (totalMinutes < 0) {
      return 'সময় সঠিকভাবে লিখুন';
    }

    const monthDays = 30.0;

    final dailyAverage = totalMinutes / days;
    final monthlyAverage = dailyAverage * monthDays;

    return formatHoursAndMinutes(monthlyAverage);
  }
}
