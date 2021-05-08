import 'file:///C:/Users/Marcus/Desktop/1GrZr/flutter_app/lib/activity.dart';

class Recommendation {
  //Machine Learning - to gather activities for user
  Recommendation();

  List<Activity> getActivities(DateTime startDate) {
    // returns all activities nearby that can be done from startDate to endDate (7 days after startDate)
    return [
      Activity(
        "Walk in Jurong West Park Connector",
        "Jurong West St 93",
        "https://www.nparks.gov.sg/-/media/nparks-real-content/gardens-parks-and-nature/park-connector-network/jurong-west-pc/wal-14--wal-jurong-west-pc20120228-133921.jpg",
        0.00,
        30
      ),
      Activity(
        "Gym @ Hockey Village",
        "Boon Lay",
        "https://www.myactivesg.com/-/media/SSC/Consumer/Images/Facilities/ActiveSG-Hockey-Village-Gym/Hockey-Gym2.jpg",
        2.50,
        45
      ),
      Activity(
        "Family zumba dance session",
        "BLK 216 Boon Lay Avenue",
        "https://ntuchealth.sg/wp-content/uploads/2018/04/IMG_7518-1.jpg",
        0.00,
        30
      ),
      Activity(
        "ActiveSG Yoga Class",
        "Jurong East Swimming Complex",
        "https://www.myactivesg.com/-/media/SSC/Consumer/Images/Sports/Fitness-and-Wellness/GC204_yogaclasses.jpg?la=en&hash=4542BA406587D73A19FB52414D1B5CA88E87FB5A",
        4.00,
        45
      ),
    ];
  }
}