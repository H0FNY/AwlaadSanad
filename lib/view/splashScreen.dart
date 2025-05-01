import 'dart:async';
import 'package:awladsanaad_2/custom/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../custom/data.dart';
import 'auth/_login_cubit.dart';
import 'home/Home.dart';
import 'auth/logIn.dart';
import 'mainAdmin/mainAdmin.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, -3.83),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    _fadeController.forward().then((_) {
      _slideController.forward();
    });

    Timer(Duration(seconds: 2,milliseconds: 500), () {
      _checkValue();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Future<void> _checkValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('Username');
    String? password = prefs.getString('Password');


    if (username != null && password!=null) {
      await LoginCubit().login(username, password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Userdata['role']=="Admin" ? const MainAdmin():Home()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Image.asset(
              "assets/images/school.png",
              width: widthScreen / 2,
            ),
          ),
        ),
      ),
    );
  }
}
