import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:sentry/sentry.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'screens/posts_view.dart';
import 'screens/detail_view.dart';
import 'screens/add_post.dart';
import 'screens/crash.dart';
import 'widgets/firebase_analytics.dart';

class App extends StatelessWidget {

  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
  
  @override
  Widget build(BuildContext context) {

    final routes = {
      PostsView.routeName: (context) => PostsView(),
      DetailView.routeName: (context) => DetailView(),
      AddPost.routeName: (context) => AddPost(),
      Crash.routeName: (context) => Crash(),
    };
    
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      routes: routes
    );
  }

  static Future<void> reportError(SentryClient sentry, dynamic error, dynamic stackTrace) async {
    // NOTE: Uncomment out for production mode
    // if(Foundation.kDebugMode) {
    //   print(stackTrace);
    //   return;
    // }

    final SentryResponse response = await sentry.captureException(
      exception: error,
      stackTrace: stackTrace
    );
    
    if(response.isSuccessful) {
      print('Sentry ID: ${response.eventId}');
    } else {
      print('Failed to report to Sentry: ${response.error}');
    }
  }
}