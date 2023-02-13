import 'dart:collection';
import 'package:flutter_auth/models/task_model.dart';
import 'package:table_calendar/table_calendar.dart';

List<Task> tasks = [];

class Event {
  final Task task;

  const Event(this.task);
}

LinkedHashMap<DateTime, List<Event>> kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

 Map<DateTime, List<Event>> _kEventSource = Map.fromIterable(List.generate(tasks.length, (index) => index),
    key: (item) => DateTime.parse(tasks[item].date),
    value: (item) => List.generate(
      tasks.lastIndexWhere((element) => element.date.contains(tasks[item].date)) - tasks.indexWhere((element) => element.date.contains(tasks[item].date)) + 1, (index) => Event(tasks[tasks.indexWhere((element) => element.date.contains(tasks[item].date)) + index])));

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year - 1, 01, 01);
final kLastDay = DateTime(kToday.year + 1, 12, 31);
