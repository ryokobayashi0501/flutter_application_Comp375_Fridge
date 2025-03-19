import 'package:flutter/material.dart';
import 'package:flutter_application/screens/signup_screen.dart';

class WelcomeButton extends StatelessWidget{
  const WelcomeButton({super.key, this.buttonTetxt, this.onTap, this.color, this.textColor});
  final String? buttonTetxt;
  final Widget? onTap;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (e) => onTap!,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: color!,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          )
        ),
        child: Text(
          buttonTetxt!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: textColor!,
          ),
        )
      ),
    );
  }
}