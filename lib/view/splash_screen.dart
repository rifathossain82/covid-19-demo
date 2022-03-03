import 'dart:async';

import 'package:covid_19_demo/view/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as Math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late AnimationController animationController= AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  )..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 5), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const WorldStatesScreen()));
      animationController.dispose();
    });

  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: animationController,
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Center(
                        child: Image.asset('assets/virus.png'),
                    ),
                  ),
                  builder: (context, child){
                    return Transform.rotate(
                      angle: animationController.value * 2.0 * Math.pi,
                      child: child,
                    );
                  }
              ),
              SizedBox(height: size.height*0.08,),
              const Text(
                'Covid 19\nTracker App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
