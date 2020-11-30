import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'main.dart';
import 'home.dart';
import 'inputForm.dart';
import 'root.dart';


class Analysis extends StatefulWidget {
  @override
  _MyAnalysis createState() => _MyAnalysis();
}

class _AnalysisData {
  var list = ['月間合計 :','年間合計 :'];
  String name;
  String payment;
  DateTime date = DateTime.now();
}


class _MyAnalysis extends State<Analysis> {
  final GlobalKey<FormState> _analysisKey = GlobalKey<FormState>();
  final _AnalysisData _analysisData = _AnalysisData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Analysis")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('subscription').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              return ListView.builder(
                itemCount: _analysisData.list.length,
                padding: const EdgeInsets.only(top: 10.0),
                itemBuilder: (context, index) => _buildListItem(context, index, snapshot.data.docs[index]),
              );
            }
        ),
      ),
    );
  }
  Widget _buildListItem(BuildContext context, int index, DocumentSnapshot document) {
    return Card(
      child: ListTile(
        title: Text(_analysisData.list[index]),
        trailing: Text(document.data()['payment'].toString()),
      ),
    );
  }
}
/*class Calculate{
  Calculate(this.document);
  var sum;
  sum = sum + document.data()['payment'];
  return sum;
}*/
/*return Column(
  mainAxisSize: MainAxisSize.min,
  children: <Widget>[
  　Text('月合計　：　　'),
  　Text('年合計　：　　'),
  ],
);*/
