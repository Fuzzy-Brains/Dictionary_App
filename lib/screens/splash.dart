import 'package:dictionary_app/screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'home.dart';

class Splash extends StatefulWidget{
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Container(
          child : Image.asset('assets/images/logo3.png',)
        ),
        Positioned(
          child:SplashScreen(
            seconds: 30,
            navigateAfterSeconds: new HomeScreen(),
            //imageBackground: AssetImage('assets/images/bgmain.jpeg'),
            backgroundColor: Color(0xff2c0834),
            title: new Text('FluentU',textScaleFactor: 3.5,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white,decorationColor:Colors.white),),
            image: new Image.asset('assets/images/main.gif'),
            loadingText: Text("Loading",style: TextStyle(color: Colors.white),),
            photoSize: 100.0,
            loaderColor: Colors.blue,
          ),
        )
      ]
    );
  }
}