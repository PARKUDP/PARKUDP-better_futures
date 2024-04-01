import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'todolist.dart';
import 'signin.dart';

class Loginpage extends StatelessWidget {
  const Loginpage({super.key});

  // Firebaseの初期化を行う非同期関数
  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('はい'),
              onPressed: () {
                Navigator.of(context).pop(); // ダイアログを閉じる
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeFirebase();

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 229, 255, 0),
        title: const Text('To Do List'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'メールアドレスを入力してください',
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true, // パスワードを隠す
              decoration: const InputDecoration(
                hintText: 'パースワードを入力してください',
              ),
            ),
            ElevatedButton(
              child: const Text('ログイン'),
              onPressed: () async {
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  showAlertDialog(context, "エラー", "メールアドレスとパースワードを入力してください");
                  return; // メールアドレスかパスワードが空の場合は処理を中断
                }

                try {
                  // ユーザーのログイン処理
                  UserCredential userCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  // ログイン成功時の処理
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Todopage()));
                } catch (e) {
                  // エラー処理
                  if (e is FirebaseAuthException) {
                    String errorMessage;
                    switch (e.code) {
                      case 'user-not-found':
                      case 'wrong-password':
                        errorMessage = "メールアドレスかパスワードが間違っています。";
                        break;
                      default:
                        errorMessage = "メールアドレスかパスワードが間違っています。";
                    }
                    showAlertDialog(context, "ログイン失敗", errorMessage);
                  } else {
                    // 予期しない例外の場合
                    print(e); // 実際のアプリではユーザーにわかりやすいエラーメッセージを表示する
                  }
                }
              },
            ),
            ElevatedButton(
              child: const Text('会員登録'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SigninPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
