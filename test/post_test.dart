import 'package:test/test.dart';
import 'package:wasteagram/models/post.dart';

void main() {
  test('Post has correct values', () {

    final photoUrl = 'url';
    final numItems = 5;
    final latitude = 37.87404;
    final longitude = -122.2836682;
    final date = DateTime.parse('2020-03-14');
    
    final post = Post(
      photoUrl: photoUrl,
      numItems: numItems,
      latitude: latitude,
      longitude: longitude,
      date: date
    );

    expect(post.photoUrl, photoUrl);
    expect(post.numItems, numItems);
    expect(post.latitude, latitude);
    expect(post.longitude, longitude);
    expect(post.date, date);

  });

  test('toMap function returns map of post values', () {

    final photoUrl = 'url';
    final numItems = 5;
    final latitude = 37.87404;
    final longitude = -122.2836682;
    final date = DateTime.parse('2020-03-14');
    
    final post = Post(
      photoUrl: photoUrl,
      numItems: numItems,
      latitude: latitude,
      longitude: longitude,
      date: date
    );

    final postMap = post.toMap();

    expect(postMap, isMap);
    expect(postMap['photoUrl'], photoUrl);
    expect(postMap['numItems'], numItems);
    expect(postMap['latitude'], latitude);
    expect(postMap['longitude'], longitude);
    expect(postMap['date'], date);

  });

  test('dateString function returns formatted date', () {
    final photoUrl = 'url';
    final numItems = 5;
    final latitude = 37.87404;
    final longitude = -122.2836682;
    final date = DateTime.parse('2020-03-14');
    
    final post = Post(
      photoUrl: photoUrl,
      numItems: numItems,
      latitude: latitude,
      longitude: longitude,
      date: date
    );

    expect(post.dateString(), 'Saturday, Mar 14, 2020');

  });

  
}