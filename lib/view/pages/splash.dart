import 'dart:async';
import 'package:cally/model/cacheHelper.dart';
import 'package:cally/utils/constant.dart';
import 'package:cally/view/pages/home.dart';
import 'package:cally/view/pages/intro_1.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  AnimationController? _controller;
  Animation<double>? animation1;
  late Widget _widget;

  Future<void> moveWidget() async {
    var introFinished = await CacheHelper.getData(key: 'introFinished');

    if (introFinished == true) {
      _widget = Home();
    } else {
      _widget = FirstIntro();
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) {
          return _widget;
        }),
      );
    }).then((value) {
      return moveWidget();
    });
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller!, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller?.forward();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryPurple,
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: _height / _fontSize),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: _textOpacity,
                child: Text(
                  'Make A Best Voice Call',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: animation1?.value,
                    fontFamily: 'Poppins Regular',
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.fastOutSlowIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.fastOutSlowIn,
                // height: _height * 0.50,
                // width: _width * 0.75,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Image.asset(
                  'assets/img/cally_logo.png',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class PageTransition extends PageRouteBuilder {
//   final Widget page;
//
//   PageTransition(this.page)
//       : super(
//           pageBuilder: (context, animation, anotherAnimation) => page,
//           transitionDuration: const Duration(milliseconds: 2000),
//           transitionsBuilder: (context, animation, anotherAnimation, child) {
//             animation = CurvedAnimation(
//               curve: Curves.fastLinearToSlowEaseIn,
//               parent: animation,
//             );
//             return Align(
//               alignment: Alignment.bottomCenter,
//               child: SizeTransition(
//                 sizeFactor: animation,
//                 child: page,
//                 axisAlignment: 0,
//               ),
//             );
//           },
//         );
// }
