import 'package:flutter/material.dart';
import 'package:flutter_app/screens/about_us.dart';
import 'package:flutter_app/screens/activities_page.dart';
import 'package:flutter_app/screens/daily_survey.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'file:///C:/Users/Marcus/Desktop/1GrZr/flutter_app/lib/screens/profile.dart';
import 'package:flutter_app/utils/database_helper.dart';
import 'package:google_fonts/google_fonts.dart';
class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final String appName = 'Navigation';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 10),
            child: Text(
              appName,
              style: GoogleFonts.montserrat(
                color: Colors.black45,
                fontSize: 25,
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/images/logo.png'),
                ),
                SizedBox(height:5.0),
                InkWell(
                    child: ListTile(
                        title: Text('Profile', style: Theme.of(context).primaryTextTheme.headline1)
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Scaffold(
                          body: ProfileWidget()
                      )));
                    }
                ),
                InkWell(
                  child: ListTile(
                      title: Text('Dashboard', style: Theme.of(context).primaryTextTheme.headline1)
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Scaffold(
                        body: Dashboard()
                    )));
                  },
                ),
                InkWell(
                  child: ListTile(
                      title: Text('Activities', style: Theme.of(context).primaryTextTheme.headline1)
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ActivitiesPage()));
                  },
                ),
                InkWell(
                  child: ListTile(
                      title: Text('Daily form', style: Theme.of(context).primaryTextTheme.headline1)
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0.0,
                            insetPadding: EdgeInsets.all(30.0),
                            child: DailySurvey()
                          )
                    );
                  },
                ),
                InkWell(
                  child: ListTile(
                      title: Text('About Us', style: Theme.of(context).primaryTextTheme.headline1)
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Scaffold(
                        body: AboutUs()
                    )));
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
