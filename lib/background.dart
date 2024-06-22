import 'package:flutter/material.dart';

class Background extends StatelessWidget{
  final Widget child;
  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0, left: 0,
              child: Image.asset(
                "assets/topleft.png"
              )
            ),
            Positioned(
              top: 0, right: 0,
              child: Image.asset(
                "assets/topright.png"
              )
            ),
            Positioned(
              bottom: 0, left: 0,
              child: Image.asset(
                "assets/botleft.png"
              )
            ),
            Positioned(
              width: 200, height: 200,
              bottom: 525,
              child: Image.asset(
                "assets/logo.png",
              )
            ),
            child
          ]
        )
      )
    );
  }
}