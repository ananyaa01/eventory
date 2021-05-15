import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';
import 'welcome_screen.dart';



class SplashScreen extends StatefulWidget {
  static String id ='splash_screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();

    _mockCheckForSession().then(
            (status) {
          _navigateToHome();
        }
    );
  }


  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 6000), () {});

    return true;
  }

  void _navigateToHome(){
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => WelcomeScreen(),
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Opacity(
            //     opacity: 0.5,
            //     child: Image.asset('assets/img/splash screen bg.png')
            // ),}

            Shimmer.fromColors(
              period: Duration(milliseconds: 1500),
              baseColor: Color(0xffeeecec),
              highlightColor: Color(0xff525050),
              child: Container(
                padding: EdgeInsets.only(left:35.0,top: 250.0),
                child: Text(
                  "Eventory",
                  style: TextStyle(
                      fontSize: 90.0,
                      fontFamily: 'Mystical Snow',
                      shadows: <Shadow>[
                        Shadow(
                            blurRadius: 18.0,
                            color: Colors.black87,
                            offset: Offset.fromDirection(120, 12)
                        )
                      ]
                  ),
                ),
              ),
            )
          ],
        ),
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/img/splash screen bg.png'),
        //   ),
        // ),
      ),
    );
  }


}