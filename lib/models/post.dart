import 'package:intl/intl.dart';

class Post {
  String photoUrl;
  int numItems;
  double latitude;
  double longitude;
  DateTime date;
  static final formatter = DateFormat('EEEE, MMM d, y');

  Post({this.photoUrl, this.numItems, this.latitude, this.longitude, this.date});

  String dateString() {
    return formatter.format(date);
  }

  Map<String, dynamic> toMap() {
    return {
      'photoUrl': photoUrl,
      'numItems': numItems,
      'latitude': latitude,
      'longitude': longitude,
      'date': date,
    };
  }
}