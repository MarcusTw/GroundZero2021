import 'package:flutter/material.dart';
import 'package:flutter_app/utils/event_adder.dart';
import 'package:photo_view/photo_view.dart';

class Activity {
  String name;
  String location;
  String imageUrl;
  double price;
  int duration;

  Activity(this.name, this.location, this.imageUrl, this.price, this.duration);

  Widget zoomablePhoto(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: [
              Container(
                child: PhotoView(
                    imageProvider: NetworkImage(imageUrl)
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 20),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ]
        )
    );
  }

  Widget activityTile(BuildContext context) {
    return Container(
      height: 90,
      child: Row(
        children: [
          Container(
            height: 200,
            width: 100.0,
            padding: EdgeInsets.all(5.0),
            child: GestureDetector(
              child: Image(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => zoomablePhoto(context)));
              },
            )
          ),
          Column(
            children: [
              Container(
                width: 250,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10, top: 7.0),
                child: GestureDetector(
                    child: Text(name, style: Theme.of(context).primaryTextTheme.bodyText1),
                    onDoubleTap: () {
                      showDialog(context: context, builder: (BuildContext context) => BreakAdder(name));
                    }
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft ,child: Text(location)
              ),
              Container(
                  alignment: Alignment.centerLeft, child: Text("Est. duration: " + duration.toString() + "mins",
                  style: Theme.of(context).primaryTextTheme.bodyText2))
            ]
          ),
          IconButton(
            icon: Icon(Icons.gps_fixed_outlined),
            onPressed: () {},
          )
          ]
        ),
    );
  }
}