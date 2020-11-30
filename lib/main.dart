import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project1/root.dart';
import 'dart:async';
import 'home.dart';
import 'analysis.dart';
import 'inputForm.dart';
import 'login.dart';
import 'splash.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Subscription",
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: RootWidget(),
      routes: <String, WidgetBuilder>{
        '/': (_) => Splash(),
        '/login': (_) => Login(),
        //'/root': (_) => RootWidget(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/root'){
          return MaterialPageRoute(
            builder: (context) => RootWidget(settings.arguments),
          );
        }
        return null;
      },
    );
  }
}




