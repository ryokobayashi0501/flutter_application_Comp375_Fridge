import 'package:flutter/material.dart';
import 'package:flutter_application/apis/user_auth.dart';
import 'package:flutter_application/screens/forget_password_screen.dart';
import 'package:flutter_application/screens/home_screen.dart';
import 'package:flutter_application/screens/signup_screen.dart';
import 'package:flutter_application/theme/theme.dart';
import 'package:flutter_application/widgets/custom_scaffold.dart';
import 'package:icons_plus/icons_plus.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool rememberPassword = true;
  bool savePassword = false;
  bool isLoading = false;
  bool _isPasswordVisible = false;
  String? errorMessage;

  /// **📌 ログイン処理**
  Future<void> _handleSignIn() async {
    if (_formSignInKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final token = await UserAuth.signin(
        _emailController.text,
        _passwordController.text,
      );

      setState(() {
        isLoading = false;
      });

      if (token != null) {
        // ログイン成功 → `HomeScreen` に遷移
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } else {
        // ログイン失敗
        setState(() {
          errorMessage = "Invalid email or password.";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(height: 10),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignInKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome back',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 40.0),

                      // **メールアドレス入力**
                      TextFormField(
                        controller: _emailController,
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Please enter Email' : null,
                        decoration: InputDecoration(
                          label: const Text('Email'),
                          hintText: 'Enter Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),

                      // **パスワード入力**
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Please enter Password' : null,
                        decoration: InputDecoration(
                          label: const Text('Password'),
                          hintText: 'Enter Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),

                      // **Remember me / Save password / Forget password**
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: rememberPassword,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        rememberPassword = value!;
                                      });
                                    },
                                    activeColor: lightColorScheme.primary,
                                  ),
                                  const Text(
                                    'Remember me',
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                ],
                              ),
                              // Row(
                              //   children: [
                              //     Checkbox(
                              //       value: savePassword,
                              //       onChanged: (bool? value) {
                              //         setState(() {
                              //           savePassword = value!;
                              //         });
                              //       },
                              //       activeColor: lightColorScheme.primary,
                              //     ),
                              //     const Text(
                              //       'Save password',
                              //       style: TextStyle(color: Colors.black45),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              // ✅ Forget password 画面に遷移
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgetPasswordScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Forget password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: lightColorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25.0),

                      // **エラーメッセージ**
                      if (errorMessage != null)
                        Text(
                          errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 10.0),

                      // **ログインボタン**
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _handleSignIn,
                          child: isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text('Sign in'),
                        ),
                      ),
                      const SizedBox(height: 25.0),

                      // **SNSログイン**
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(thickness: 0.7, color: Colors.grey.withOpacity(0.5)),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Sign in with',
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),
                          Expanded(
                            child: Divider(thickness: 0.7, color: Colors.grey.withOpacity(0.5)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25.0),

                      // **SNSボタン**
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Brand(Brands.facebook),
                          Brand(Brands.twitter),
                          Brand(Brands.google),
                          Icon(Icons.apple, size: 40.0),
                        ],
                      ),
                      const SizedBox(height: 25.0),

                      // **サインアップ画面へ**
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account? ',
                            style: TextStyle(color: Colors.black45),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignUpScreen()),
                              );
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(fontWeight: FontWeight.bold, color: lightColorScheme.primary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
