import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/RoundedButton.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController LogoController;
//  AnimationController TweenController;
//  Animation LogoAnimation;
  Animation TweenAnimation;

  @override
  void initState() {
    super.initState();



    LogoController = AnimationController(
        duration: Duration(seconds: 1),
        vsync: this,
//        upperBound: 0.35,
//        lowerBound: 0.2
    );
    LogoController.forward();
    LogoController.addListener(() {
      setState(() {});
    });
    TweenAnimation = ColorTween(begin: Colors.blueGrey, end: Colors.white).animate(LogoController);

//
//    LogoAnimation = CurvedAnimation(parent:  LogoController , curve: Curves.decelerate);
//    LogoAnimation.addStatusListener((status){
////      print(status);
//        if(status == AnimationStatus.completed){
//          LogoController.reverse(from: 1.0);
//        }else if(status==AnimationStatus.dismissed){
//          LogoController.forward();
//        }
//    });

//    TweenController = AnimationController(
//      vsync: this,
//      duration: Duration(
//        seconds: 2
//      )
//    );

//    TweenController.forward();
//    TweenController.addListener((){
//      setState(() {
//
//      });
//    });

  }

  @override
  void dispose() {
    super.dispose();
//    LogoController.dispose();
//    TweenController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TweenAnimation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 100,
                    ),
                  ),
                ),
                /*
                ColorizeAnimatedTextKit(
                  colors: [
                    Colors.purple,
                    Colors.blue,
                    Colors.yellow,
                    Colors.red,
                  ],
                  text:['Flash Chat','Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                )
                 */
                TypewriterAnimatedTextKit(

                  speed: Duration(
                    milliseconds: 750
                  ),
                  totalRepeatCount: 0,

                  text:['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            // Colors.lightBlueAccent  Navigator.pushNamed(context, LoginScreen.id);   'Log In'
            Hero(
              tag: 'LOGIN',
              child: RoundedButton(
                color: Colors.lightBlueAccent,
                text: 'Log In',
                Fun: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
            ),
            //  Colors.blueAccent   () {Navigator.pushNamed(context, RegistrationScreen.id);}   'Register'
            Hero(
              tag: 'REGISTER',
              child: RoundedButton(
                color: Colors.blueAccent,
                text: 'Register',
                Fun: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

