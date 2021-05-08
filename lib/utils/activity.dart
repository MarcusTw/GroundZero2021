import 'package:flutter/material.dart';
import 'package:flutter_app/utils/event_adder.dart';
import 'package:photo_view/photo_view.dart';

class Activity {
  String name;
  String location;
  String imageUrl;
  double price;

  Activity(this.name, this.location, this.imageUrl, this.price);

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
    return ListTile(
      leading: Container(
        height: 80,
        width: 100.0,
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
      title: GestureDetector(
        child: Text(name, style: Theme.of(context).primaryTextTheme.bodyText1),
        onDoubleTap: () {
          showDialog(context: context, builder: (BuildContext context) => EventAdder(name));
        }
      ),
      subtitle: Text(location),
      trailing: IconButton(
        icon: Icon(Icons.gps_fixed_outlined),
        onPressed: () {},
      )
    );
  }
}