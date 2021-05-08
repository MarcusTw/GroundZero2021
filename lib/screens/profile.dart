import 'package:flutter/material.dart';
import 'package:flutter_app/utils/database_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {

  @override
  Widget build(BuildContext context) {
    return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(top : 10),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        SizedBox(height: 80),
        CircleAvatar(
          radius: 85,
          backgroundImage: AssetImage('assets/images/user.png'),
        ),
        SizedBox(height: 5),
        Text("Name: " + DatabaseHelper.name, style: Theme.of(context).primaryTextTheme.headline4,),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text("Age: " + DatabaseHelper.getAge().toString(), style: Theme.of(context).primaryTextTheme.bodyText1),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text("D.O.B.: " + DateFormat('dd-MM-yyyy').format(DatabaseHelper.dob), style: Theme.of(context).primaryTextTheme.bodyText1),
        ),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text("Hobbies: " + DatabaseHelper.hobbies, style: Theme.of(context).primaryTextTheme.bodyText1),
        ),
        Spacer(),
        ElevatedButton(
          child: Icon(
            Icons.edit
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                        child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10.0,
                                  offset: const Offset(0.0, 10.0),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              // To make the card compact
                              children: <Widget>[
                                SizedBox(height: 16.0),
                                Text("Edit Profile",
                                    style: GoogleFonts.montserrat(
                                        color: Color.fromRGBO(59, 57, 60, 1),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)
                                ),
                                Container(
                                    padding: EdgeInsets.fromLTRB(
                                        20, 5, 20, 5),
                                    child: TextField(
                                      style: GoogleFonts.montserrat(
                                          color: Color.fromRGBO(
                                              105, 105, 108, 1),
                                          fontSize: 16),
                                      autofocus: true,
                                      decoration: InputDecoration(
                                        labelStyle: GoogleFonts.montserrat(
                                            color: Color.fromRGBO(
                                                59, 57, 60, 1),
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal),
                                        labelText: 'Name',
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          DatabaseHelper.name = value;
                                        });
                                      },
                                    )
                                ),
                                Container(
                                    child: TextButton(
                                      child: Text('Select Birth date'),
                                      onPressed: () {
                                        DatePicker.showDatePicker(
                                          context,
                                          showTitleActions: true,
                                          minTime: DateTime(1900),
                                          maxTime: DateTime.now(),
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
                                              DatabaseHelper.dob = date;
                                            });
                                          },
                                        );
                                      },
                                    )
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      child: Text('Save'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ]
                                )
                              ],
                            )
                        )
                    )
                );
              }
          ),
        ]
      )
    );
  }
}
