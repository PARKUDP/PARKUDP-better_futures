import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  String newUser = "";
  String newUserEmail = "";
  String newUserPassword = "";
  String infoText = "";
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // Firestoreに名前とメールアドレスを保存する関数
  Future<void> registerUserInFirestore(User? user) async {
    if (user != null) {
      return users.doc(user.uid).set({
        'name': newUser,
        'email': newUserEmail,
      });
    } else {
      throw Exception('ユーザー作成エラー');
    }
  }

  // ユーザー登録処理を統合
  Future<void> register() async {
    try {
      UserCredential result =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: newUserEmail,
        password: newUserPassword,
      );
      await registerUserInFirestore(result.user);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Loginpage()),
      );
    } catch (e) {
      setState(() {
        infoText = "登録失敗: ${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザー登録'),
        backgroundColor: const Color.fromARGB(255, 229, 255, 0),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: "ユーザー名"),
                  onChanged: (value) => setState(() => newUser = value),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "メールアドレス"),
                  onChanged: (value) => setState(() => newUserEmail = value),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "パスワード（6文字以上）"),
                  obscureText: true,
                  onChanged: (value) => setState(() => newUserPassword = value),
                ),
                ElevatedButton(
                  onPressed: register,
                  child: const Text("ユーザー登録"),
                ),
                Text(infoText)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
