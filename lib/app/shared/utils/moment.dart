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
}
