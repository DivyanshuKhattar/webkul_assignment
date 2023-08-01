import 'package:dummy_assignment/Resources/color_picker.dart';
import 'package:dummy_assignment/Resources/shared_pref_data.dart';
import 'package:dummy_assignment/Screens/Dashboard/dashboard_screen.dart';
import 'package:dummy_assignment/Screens/UserDetails/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  double deviceHeight = 0.0;
  double deviceWidth = 0.0;

  @override
  void initState() {
    navigateUser();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// show splash screen for 2 secs and then move to login page
  Future navigateUser() async{
    bool isLoggedIn = await SharedPrefData().getIsLoggedIn();
    Future.delayed(const Duration(milliseconds: 2000), (){
      if(isLoggedIn == true){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(builder: (BuildContext context) => const DashboardScreen()),
          ModalRoute.withName('/dashboard'),
        );
      }
      else{
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(builder: (BuildContext context) => const LoginScreen()),
          ModalRoute.withName('/loginPage'),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Image.asset(
          'assets/webkul_logo.png',
          fit: BoxFit.fill,
        ),
      )
    );
  }
}
