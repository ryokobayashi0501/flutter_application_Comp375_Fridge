import 'package:flutter/material.dart';
import 'package:flutter_application/screens/signin_screen.dart';
import 'package:flutter_application/screens/signup_screen.dart';
import 'package:flutter_application/widgets/custom_scaffold.dart';
import 'package:flutter_application/widgets/welcome_button.dart';
import 'package:flutter_application/theme/theme.dart';


class WelcomScreen extends StatelessWidget{
  const WelcomScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
            flex: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 40.0,
              ),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Welcome Back!\n',
                        style: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                        )
                      ),

                      TextSpan(
                        text:
                        '\nEnter personal details to your employee account',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        )
                      )
                    ]
                  )
                ) 
              ),
            )
          ),

          Flexible(
            flex: 1,
            child: Align(
              alignment:  Alignment.bottomRight,
              child: Row(
                children: [
                  Expanded(
                    child: WelcomeButton(
                      buttonTetxt: 'Sign in',
                      onTap: SignInScreen(),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white
                    ),
                  ),
              
                  Expanded(
                    child: WelcomeButton(
                      buttonTetxt: 'Sign up',
                      onTap: const SignUpScreen(),
                      color: Colors.white,
                      textColor: lightColorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}