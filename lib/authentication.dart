import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'main.dart';
import 'analysis.dart';
import 'inputForm.dart';
import 'root.dart';

class Auth extends StatefulWidget {
  @override
  _MyAuth createState() => _MyAuth();
}

class _MyAuth extends State<Auth> {

  String newUserEmail = "";// 入力されたメールアドレス
  String newUserPassword = "";// 入力されたパスワード
  String loginUserEmail = "";  // 入力されたメールアドレス（ログイン）
  String loginUserPassword = "";  // 入力されたパスワード（ログイン）
  String infoText = "";// 登録・ログインに関する情報を表示

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Authentication")),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              TextFormField(// テキスト入力のラベルを設定
                decoration: const InputDecoration(
                    labelText: "メールアドレス",
                ),
                onChanged: (String value) {
                  setState(() {
                    newUserEmail = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: "パスワード（６文字以上）",
                ),
                obscureText: true,// パスワードが見えないようにする
                onChanged: (String value) {
                  setState(() {
                    newUserPassword = value;
                  });
                },
              ),
              RaisedButton(
                child: Text("登録"),
                onPressed: () async {
                  try {
                    // メール/パスワードでユーザー登録
                    final FirebaseAuth _auth = FirebaseAuth.instance;
                    final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                      email: newUserEmail,
                      password: newUserPassword,
                    );
                    // 登録したユーザー情報
                    final user = userCredential.user;
                    setState(() {
                      infoText = "登録OK：${user.email}";
                    });
                  } catch (e) {
                    // 登録に失敗した場合
                    setState(() {
                      infoText = "登録NG：${e.message}";
                    });
                  }
                },
              ),
              Text(infoText),

              Container(height: 32),
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
              ),
              RaisedButton(
                child: Text("ログイン"),
                onPressed: () async {
                  try {
                    // メール/パスワードでログイン
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final UserCredential userCredential = await auth.signInWithEmailAndPassword(
                      email: loginUserEmail,
                      password: loginUserPassword,
                    );
                    // ログインに成功した場合
                    final user = userCredential.user;
                    setState(() {
                      infoText = "ログインOK：${user.email}";
                    });
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


class AuthForm extends StatefulWidget{
  @override
  _MyAuthForm createState() => _MyAuthForm();
}

class _MyAuthForm extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {

  }
}
