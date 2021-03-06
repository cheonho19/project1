import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'main.dart';
import 'analysis.dart';
import 'inputForm.dart';
import 'root.dart';
import 'splash.dart';

class Login extends StatefulWidget {
  @override
  _MyLogin createState() => _MyLogin();
}

class _MyLogin extends State<Login> {

  String UserEmail = "";// 入力されたメールアドレス
  String UserPassword = "";// 入力されたパスワード
  String infoText = "";// 登録・ログインに関する情報を表示

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Login")),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              TextFormField(
                // テキスト入力のラベルを設定
                decoration: const InputDecoration(
                  labelText: "メールアドレス",
                ),
                onChanged: (String value) {
                  setState(() {
                    UserEmail = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "パスワード（６文字以上）",
                ),
                // パスワードが見えないようにする
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    UserPassword = value;
                  });
                },
              ),
              RaisedButton(
                color: Colors.amber,
                child: Text("登録"),
                onPressed: () async {
                  try {
                    // メール/パスワードでユーザー登録
                    final FirebaseAuth _auth = FirebaseAuth.instance;
                    final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                      email: UserEmail,
                      password: UserPassword,
                    );
                    //ユーザ登録に成功した場合
                    //チャット画面に遷移＋ログイン画面を破棄
                    final user = userCredential.user;
                    await Navigator.pushReplacementNamed(context, "/root", arguments: user);
                    // 登録したユーザー情報
                    /*setState(() {
                      infoText = "登録OK：${user.email}";
                    }); */
                  } catch (e) {
                    // 登録に失敗した場合
                    setState(() {
                      infoText = "登録NG：${e.message}";
                    });
                  }
                },
              ),
              Text(infoText),

              /*Container(height: 32),
              TextFormField(
                decoration: InputDecoration(labelText: "メールアドレス"),
                onChanged: (String value) {
                  setState(() {
                    loginUserEmail = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "パスワード"),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    loginUserPassword = value;
                  });
                },
              ), */
              OutlineButton(
                child: Text("ログイン"),
                onPressed: () async {
                  try {
                    // メール/パスワードでログイン
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final UserCredential userCredential = await auth.signInWithEmailAndPassword(
                      email: UserEmail,
                      password: UserPassword,
                    );
                    // ログインに成功した場合
                    //チャット画面に遷移＋ログイン画面を破棄
                    await Navigator.pushReplacementNamed(context, "/root");
                    /*final user = userCredential.user;
                    setState(() {
                      infoText = "ログインOK：${user.email}";
                    }); */
                  } catch (e) {
                    // ログインに失敗した場合
                    setState(() {
                      infoText = "ログインNG：${e.message}";
                    });
                  }
                },
              ),
              Text(infoText),
            ],
          ),
        ),
      ),
    );
  }
}

