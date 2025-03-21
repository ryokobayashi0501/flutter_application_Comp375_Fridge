import 'package:flutter/material.dart';
import 'package:flutter_application/screens/welcom_screen.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // デフォルトの戻る動作を無効化
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          // 戻るボタンが押されたら WelcomeScreen に遷移
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => WelcomScreen()),
            (Route<dynamic> route) => false, // すべての前のページを削除
          );
        }
      },
      child: Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            "assets/images/bg1.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: child!,
          ),
        ],
      ),
    )
    );
  }
}