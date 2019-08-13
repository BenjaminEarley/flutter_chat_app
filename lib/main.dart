import 'package:chat/blocs/auth/auth_bloc.dart';
import 'package:chat/pages/chat/chat.dart';
import 'package:chat/pages/profile/profile.dart';
import 'package:chat/pages/registration/registration.dart';
import 'package:chat/pages/splash.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChatApp());

class ChatApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return Provider<AuthBloc>(
      builder: (context) => AuthBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      child: MaterialApp(
        title: "Chat",
        theme: defaultTheme,
        navigatorObservers: <NavigatorObserver>[ChatApp.observer],
        initialRoute: splashPage,
        routes: {
          splashPage: (context) => SplashPage(),
          registrationPage: (context) => RegistrationPage(),
          chatPage: (context) => ChatPage(),
          profilePage: (context) => ProfilePage(),
        },
      ),
    );
  }
}

final ThemeData iOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData defaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
  brightness: Brightness.light,
);

final ThemeData defaultDarkTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[700],
  brightness: Brightness.dark,
);
