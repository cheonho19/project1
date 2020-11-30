import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main.dart';
import 'analysis.dart';
import 'inputForm.dart';
import 'root.dart';

class Home extends StatefulWidget {
  //final User user;
  //Home(this.user);
  @override
  _MyHome createState() => _MyHome();
}

class _MyHome extends State<Home> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Home")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('subscription').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (!snapshot.hasData) return const Text('Loading...');
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                padding: const EdgeInsets.only(top: 8.0),
                itemBuilder: (context, index) => _buildListItem(context, snapshot.data.docs[index]),
              );
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            print("新規作成ボタンを押しました");
            Navigator.push(
              context,
              MaterialPageRoute(
                  settings: const RouteSettings(name: "/new"),
                  builder: (BuildContext context) => InputForm(null)
              ),
            );
          }
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    return Card(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.android),
              title: Text(document.data()['name']),
              subtitle: Text('支払日：' + document.data()['date'].toDate().toString().substring(0,10)
                  + "\n料金："+ document.data()['payment'].toString()),
            ),
            ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                        child: const Text("編集"),
                        onPressed: () {
                          print("編集ボタンを押しました");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                settings: const RouteSettings(name: "/edit"),
                                builder: (BuildContext context) => InputForm(document)
                            ),
                          );
                        }
                    ),
                  ],
                )
            ),
          ]
      ),
    );
  }
}
