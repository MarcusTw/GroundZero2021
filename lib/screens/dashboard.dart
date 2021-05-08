import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: Theme.of(context).primaryTextTheme.headline6,)
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
                image: AssetImage('assets/images/dashboard.png')
            ),
            SizedBox(height: 2.0),
            Image(
              image: AssetImage('assets/images/dashboard2.png')
            )
          ]
        )
      )
    );
  }
}
