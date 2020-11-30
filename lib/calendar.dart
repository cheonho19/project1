import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'main.dart';
import 'analysis.dart';

class Calendar extends StatefulWidget {
  @override
  _MyCalendar createState() => _MyCalendar();
}

class _MyCalendar extends State<Calendar> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Calendar")),
      ),
      body: Container(

      ),
    );
  }
}