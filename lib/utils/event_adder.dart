import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/calendar_model.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/utils/database_helper.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EventAdder extends StatefulWidget {
  final String eventName;

  EventAdder(this.eventName);

  @override
  _EventAdderState createState() => _EventAdderState();
}

class _EventAdderState extends State<EventAdder> {
  static List<String> exercises = ['jumping jacks', 'high knees', 'high jumps', 'squats', 'counts of side stretches'];

  DatabaseHelper databaseHelper = DatabaseHelper();
  DateTime _selectedDay = DateTime.now();

  Map<DateTime, List<CalendarItem>> _events = {};
  List<CalendarItem> _data = [];

  List<dynamic> _selectedEvents = [];

  TimeOfDay _startTime = TimeOfDay(hour: 08, minute: 00);
  TimeOfDay _endTime = TimeOfDay(hour: 09, minute: 00);
  String _errorMsg = "";
  String _name = "";

  static List times = [
    TimeOfDay(hour: 06, minute: 00),
    TimeOfDay(hour: 07, minute: 00),
    TimeOfDay(hour: 08, minute: 00),
    TimeOfDay(hour: 09, minute: 00),
    TimeOfDay(hour: 10, minute: 00),
    TimeOfDay(hour: 11, minute: 00),
    TimeOfDay(hour: 12, minute: 00),
    TimeOfDay(hour: 13, minute: 00),
    TimeOfDay(hour: 14, minute: 00),
    TimeOfDay(hour: 15, minute: 00),
    TimeOfDay(hour: 16, minute: 00),
    TimeOfDay(hour: 17, minute: 00),
    TimeOfDay(hour: 18, minute: 00),
    TimeOfDay(hour: 19, minute: 00),
    TimeOfDay(hour: 20, minute: 00),
    TimeOfDay(hour: 21, minute: 00),
    TimeOfDay(hour: 22, minute: 00),
    TimeOfDay(hour: 23, minute: 00),
    TimeOfDay(hour: 00, minute: 00),
    TimeOfDay(hour: 01, minute: 00),
    TimeOfDay(hour: 02, minute: 00),
    TimeOfDay(hour: 03, minute: 00),
    TimeOfDay(hour: 04, minute: 00),
    TimeOfDay(hour: 05, minute: 00),
  ];

  static List<DropdownMenuItem> _dropDownTime(BuildContext context) {
    return times.map((i) {
      return DropdownMenuItem(
          value: TimeOfDay(hour: i.hour, minute: i.minute),//TimeOfDay(hour: i.hour, minute: i.minute),
          child: Text(i.format(context))
      );
    }).toList();
  }


  void _addEvent(DateTime date, String event, String startTime, String endTime) async{
    CalendarItem item = CalendarItem(
        date: _selectedDay.toString(),
        name: event,
        startTime: startTime,
        endTime: endTime
    );
    await databaseHelper.database;
    await databaseHelper.insert(CalendarItem.table, item);
    _selectedEvents.add(item);
    //TODO: Schedule notification //Done...
    int start = int.parse(startTime.substring(10, 12));
    int end = int.parse(endTime.substring(10, 12));
    for (int i = start+1; i <= end; i++) {
      scheduleAlarm(date, i);
    }
    _fetchEvents();

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home()));
  }

  void _fetchEvents() async{
    _events = {};
    await databaseHelper.database;
    List<Map<String, dynamic>> _results = await databaseHelper.query(CalendarItem.table);
    _data = _results.map((item) => CalendarItem.fromMap(item)).toList();
    _data.forEach((element) {
      DateTime formattedDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(element.date.toString())));
      if(_events.containsKey(formattedDate)){
        _events[formattedDate].add(element);
      }
      else{
        _events[formattedDate] = [element];
      }
    }
    );
    setState(() {});
  }



  void scheduleAlarm(DateTime day, int time) async {
    var scheduledNotificationDateTime = DateTime(day.year, day.month, day.day, time);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails('alarm_notif', 'alarm_notif', 'Channel for Alarm notification');

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(presentAlert: true, presentBadge: true, presentSound: false);

    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    String chosenExercise = exercises[new Random().nextInt(exercises.length - 1)];
    await flutterLocalNotificationsPlugin.schedule(0, 'Time to exercise!', 'Do 10 ' + chosenExercise,
        scheduledNotificationDateTime, platformChannelSpecifics);
  }


  @override
  Widget build(BuildContext context) {
    _name = widget.eventName;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                SizedBox(height: 16.0),
                Text("Add Break", style: GoogleFonts.montserrat(
                    color: Color.fromRGBO(59, 57, 60, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
                Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Text("Break: " + _name),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
                    child: DropdownButton(
                        hint: Text("Select Start Time: "),
                        icon: Icon(Icons.arrow_drop_down_circle),
                        iconSize: 36,
                        isExpanded: true,
                        value: _startTime,
                        onChanged: (val) {
                          setState(() {
                            _startTime = val;
                          });
                        },
                        items: _dropDownTime(context)
                    )
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
                    child: DropdownButton(
                        hint: Text("Select End Time: "),
                        icon: Icon(Icons.arrow_drop_down_circle),
                        iconSize: 36,
                        isExpanded: true,
                        value: _endTime,
                        onChanged: (val) {
                          setState(() {
                            _endTime = val;
                            _errorMsg = "";
                          });
                          if (_endTime.hour <= _startTime.hour) {
                            setState(() {
                              _endTime = TimeOfDay(hour: _startTime.hour + 1, minute: 00);
                              _errorMsg = "Invalid start time, please choose again";
                            });
                          }
                        },
                        items: _dropDownTime(context))
                ),
                Container(
                  // padding: EdgeInsets.all(5),
                    child: Text(
                      _errorMsg,
                      style: GoogleFonts.montserrat(
                        color: Colors.red,
                        fontSize: 10,
                      ),)
                ),
                Container(
                    child: TextButton(
                      child: Text('Select Date'),
                      onPressed: () {
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime.now(),
                          maxTime: DateTime(DateTime.now().year + 1),
                          theme: DatePickerTheme(
                              headerColor: Colors.orange,
                              backgroundColor: Colors.blue,
                              itemStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              doneStyle:
                              TextStyle(color: Colors.white, fontSize: 16)),
                          onChanged: (date) {
                            setState(() {
                              _selectedDay = date;
                            });
                          },
                        );
                      },
                    )
                ),
                Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextButton(
                        child: Text('Save',
                            style: GoogleFonts.montserrat(
                                color: Color.fromRGBO(59, 57, 60, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        onPressed: () => {
                          _addEvent(_selectedDay, _name, _startTime.toString(), _endTime.toString())
                        },
                      ),
                      TextButton(
                          child: Text('Cancel',
                              style: GoogleFonts.montserrat(
                                  color: Color.fromRGBO(59, 57, 60, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () { return Navigator.of(context).pop(true); }
                      )
                    ]
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
