import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry/sentry.dart' as Sentry;
import 'app.dart';

const DSN_PATH = 'assets/key.txt';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String dsn = await rootBundle.loadString(DSN_PATH);
  final Sentry.SentryClient sentry = Sentry.SentryClient(dsn: dsn);

  FlutterError.onError = (FlutterErrorDetails details) {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  runZoned(() {
    runApp(App());
  }, onError: (error, stackTrace) {
    App.reportError(sentry, error, stackTrace);
  });

}