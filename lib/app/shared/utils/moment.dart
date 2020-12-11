import 'package:intl/intl.dart';

class Moment {
  static List<DateTime> nextDates(DateTime startDate, int weekDayId,
      [int amountOfDates = 5]) {
    List<DateTime> listOfDates = <DateTime>[];

    DateTime currentDate = startDate;

    for (int index = 0; index <= amountOfDates; index++) {
      while (currentDate.weekday != weekDayId) {
        currentDate = currentDate.add(Duration(days: 1));
      }
      listOfDates.add(currentDate);
      currentDate = currentDate.add(
        Duration(days: 7),
      );
    }
    return listOfDates;
  }



  static String nextWeekDayString(DateTime dateTime) {
    DateTime comparable = DateTime(dateTime.year, dateTime.month, dateTime.day);

    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    if (comparable == yesterday) {
      return "Ontem";
    } else if (comparable == today) {
      return "Hoje";
    } else if (comparable == tomorrow) {
      return "Amanhã";
    } else {
      return 'Próxim${dateTime.weekday < 6 ? 'a' : 'o'} ${DateFormat('EEEE', 'pt_Br').format(dateTime).toString().split('-').first}';
    }
  }



}
