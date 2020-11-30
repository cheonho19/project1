import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'home.dart';
import 'analysis.dart';
import 'inputForm.dart';
import 'root.dart';
import 'login.dart';

User firebaseUser;
final FirebaseAuth _auth = FirebaseAuth.instance;

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _getUser(context);
    return Scaffold(
      body: Center(
        child: const Text("スプラッシュ画面"),
      ),
      //home: RootWidget(),
    );
  }
}

void _getUser(BuildContext context) async {
  try {
    firebaseUser = await _auth.currentUser;
    if (firebaseUser == null) { //まだログインしていない時は
      await _auth.signInAnonymously(); //匿名ログインをする
      firebaseUser = await _auth.currentUser; //ユーザーは匿名ログイン者になる
      //Navigator.pushReplacementNamed(context, "/login"); //ログイン画面に移動する
    }else{
      //Navigator.pushReplacementNamed(context, "/root");
      Navigator.pushReplacementNamed(context, "/login");
    } //ログイン画面に移動する
  }catch(e) {
    Fluttertoast.showToast(msg: "Firebaseとの接続に失敗しました。");
  }
}