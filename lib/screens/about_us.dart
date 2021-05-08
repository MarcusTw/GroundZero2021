import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class AboutUs extends StatelessWidget {
  final String aboutUs = 'Established in 2021, we aim to help employees achieve a better work-life balance!';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        Container(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Container(
          height: 243,
          width: 500,
          padding: const EdgeInsets.only(top: 10.0),
          child: PhotoView(
            imageProvider: AssetImage('assets/images/aboutus.png'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            aboutUs,
            style: Theme.of(context).primaryTextTheme.bodyText1,),
        )
      ],
    );
  }
}
