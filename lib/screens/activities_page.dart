import 'package:flutter/material.dart';
import 'package:flutter_app/utils/recommendation.dart';

class ActivitiesPage extends StatefulWidget {
  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  Recommendation recommendation = Recommendation();


  @override
  Widget build(BuildContext context) {
    List<Widget> tiles = [
      Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.only(top: 20),
        child: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        )
    ),];
    tiles.addAll(recommendation.getActivities(DateTime.now()).map((a) => a.activityTile(context)).toList());
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommendations for your break', style: Theme.of(context).primaryTextTheme.headline6,)
      ),
      body: Stack(
        children: [
           ListView(
              children: recommendation.getActivities(DateTime.now()).map((a) => a.activityTile(context)).toList()
            )
        ],
      )
    );
  }

}
