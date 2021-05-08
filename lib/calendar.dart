import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_app/calendar_model.dart';
import 'package:flutter_app/database.dart';
import 'package:flutter_app/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  DateTime _selectedDay = DateTime.now();

  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events = {};
  List<CalendarItem> _data = [];

  List<dynamic> _selectedEvents = [];
  List<Widget> get _eventWidgets => _selectedEvents.map((e) => events(e)).toList();

  TimeOfDay _startTime = TimeOfDay(hour: 08, minute: 00);
  TimeOfDay _endTime = TimeOfDay(hour: 09, minute: 00);
  String _errorMsg = "";
  String _name = "";

  void initState() {
    super.initState();
    DB.init().then((value) => _fetchEvents());
    _calendarController = CalendarController();
  }

  void dispose(){
    _calendarController.dispose();
    super.dispose();
  }

  Widget events(var d){
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
          decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Theme.of(context).dividerColor),
              )),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[Text(d,
                  style: Theme.of(context).primaryTextTheme.bodyText1),
                IconButton(icon: FaIcon(FontAwesomeIcons.trashAlt, color: Colors.redAccent, size: 15,), onPressed: ()=> _deleteEvent(d))
              ]) ),
    );  }

  void _onDaySelected(DateTime day, List events, List list) {
    setState(() {
      _selectedDay = day;
      _selectedEvents = events;
    });
  }

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

  void _create(BuildContext context) {
    _name = "";
    _errorMsg = "";
    _startTime = TimeOfDay(hour: 08, minute: 00);
    _endTime = TimeOfDay(hour: 09, minute: 00);
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
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
                  Text("Add Event", style: GoogleFonts.montserrat(
                      color: Color.fromRGBO(59, 57, 60, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
                  Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: TextField(
                        style: GoogleFonts.montserrat(
                            color: Color.fromRGBO(105, 105, 108, 1), fontSize: 16),
                        autofocus: true,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.montserrat(
                              color: Color.fromRGBO(59, 57, 60, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                          labelText: 'Meeting Name',
                        ),
                        onChanged: (value) {
                          _name = value;
                        },
                      )
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
                            _addEvent(_name)
                          },
                        ),
                        TextButton(
                            child: Text('Cancel',
                                style: GoogleFonts.montserrat(
                                    color: Color.fromRGBO(59, 57, 60, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () => Navigator.of(context).pop(false)
                        )
                      ]
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchEvents() async{
    _events = {};
    List<Map<String, dynamic>> _results = await DB.query(CalendarItem.table);
    _data = _results.map((item) => CalendarItem.fromMap(item)).toList();
    _data.forEach((element) {
      DateTime formattedDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(element.date.toString())));
      if(_events.containsKey(formattedDate)){
        _events[formattedDate].add(element.name.toString());
      }
      else{
        _events[formattedDate] = [element.name.toString()];
      }
    }
    );
    setState(() {});
  }

  void _addEvent(String event) async{
    CalendarItem item = CalendarItem(
        date: _selectedDay.toString(),
        name: event
    );
    await DB.insert(CalendarItem.table, item);
    _selectedEvents.add(event);
    _fetchEvents();

    Navigator.pop(context);
  }
  
  void _deleteEvent(String s){
    List<CalendarItem> d = _data.where((element) => element.name == s).toList();
    if(d.length == 1){
      DB.delete(CalendarItem.table, d[0]);
      _selectedEvents.removeWhere((e) => e == s);
      _fetchEvents();
    }
  }

  Widget calendar(){
    return Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            gradient: LinearGradient(colors: [Colors.red[600], Colors.red[400]]),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: new Offset(0.0, 5)
              )
            ]
        ),
        child: TableCalendar(
          calendarStyle: CalendarStyle(
            canEventMarkersOverflow: true,
            markersColor: Colors.white,
            weekdayStyle: TextStyle(color: Colors.white),

            todayColor: Colors.white54,
            todayStyle: TextStyle(color: Colors.redAccent, fontSize: 15, fontWeight: FontWeight.bold),
            selectedColor: Colors.red[900],
            outsideWeekendStyle: TextStyle(color: Colors.white60),
            outsideStyle: TextStyle(color: Colors.white60),
            weekendStyle: TextStyle(color: Colors.white),
            renderDaysOfWeek: false,
          ),
          onDaySelected: _onDaySelected,
          calendarController: _calendarController,
          events: _events,

          headerStyle: HeaderStyle(
            leftChevronIcon: Icon(Icons.arrow_back_ios, size: 15, color: Colors.white),
            rightChevronIcon: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.white),
            titleTextStyle: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 16)
            ,
            formatButtonDecoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(20),
            ),
            formatButtonTextStyle: GoogleFonts.montserrat(
                color: Colors.red,
                fontSize: 13,
                fontWeight: FontWeight.bold),
          ),

        )
    );
  }

  Widget eventTitle(){
    if(_selectedEvents.length == 0){
      return Container(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
        child:Text("No events", style: Theme.of(context).primaryTextTheme.headline1),
      );
    }
    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
      child:Text("Events", style: Theme.of(context).primaryTextTheme.headline1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar", style: Theme.of(context).primaryTextTheme.headline1),
        actions: [
          Consumer<ThemeNotifier>(
              builder: (context, notifier, child) => IconButton(icon: notifier.isDarkTheme
                  ? FaIcon(FontAwesomeIcons.moon, size: 20, color: Colors.white,)
                  : Icon(Icons.wb_sunny), onPressed: () => {notifier.toggleTheme()}))
        ],
      ),
      drawer: Drawer(),
      backgroundColor: Theme.of(context).primaryColor,
      body:  ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              
            ],),
          ),

          calendar(),
          eventTitle(),
          Column(children:_eventWidgets),
          SizedBox(height:60)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () => _create(context),
        child: Icon(Icons.add, color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}