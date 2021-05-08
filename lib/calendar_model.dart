import 'package:flutter/material.dart';

class CalendarItem {
  static String table = "events";

  int id;
  String name;
  String date;
  String startTime;
  String endTime;

  CalendarItem({this.id, this.name, this.date, this.startTime, this.endTime});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'date': date,
      'startTime' : startTime,
      'endTime' : endTime
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static CalendarItem fromMap(Map<String, dynamic> map) {
    return CalendarItem(
        id: map['id'],
        name: map['name'],
        date: map['date'],
        startTime: map['startTime'],
        endTime: map['endTime']);
  }
}