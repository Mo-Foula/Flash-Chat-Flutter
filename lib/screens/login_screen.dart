import 'package:flash_chat/components/RoundedButton.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {

  AnimationController AnimeController;
  final _auth = FirebaseAuth.instance;
  static final _auth2 = FirebaseAuth.instance;
  static bool _isButtonDisabled = true;
  String email, password, ToBeShowedText = " ";
  Widget Verif = Text('');
  int MyTimer = 0;
  bool ShowSpinner = false;

  void CheckAndVerify() {
    if (!_isButtonDisabled) {
      SendVerification();
      //TODO add check
      Verif = MakeDisabled();
    } else {
      //TODO add here when the button is disabled

    }
  }

  static void SendVerification() async {
    FirebaseUser user = await _auth2.currentUser();
    if (user != null && !user.isEmailVerified) {
      user.sendEmailVerification();
    }
  }

  Widget MakeDisabled(){
    AnimeController.reverse(from: 0.59);
    _isButtonDisabled = true;
    return RoundedButton(
      text: 'Email verification sent! Please verify your email.',
      Fun: () {
        CheckAndVerify();
      },
      color: Colors.grey,
    );
  }

  Widget MakeAvailable(){
    _isButtonDisabled = false;
    ToBeShowedText = 'Please verify your email address.';
    return RoundedButton(
      text: 'Verify email address',
      Fun: () {
        CheckAndVerify();
      },
      color: Colors.redAccent,
    );
  }

  @override
  void initState() {
    super.initState();

    AnimeController = AnimationController(
      duration: Duration(minutes: 1),
      vsync: this,
        upperBound: 0.59,
        lowerBound: 0.0,
    );

    AnimeController.addListener(() {
      setState(() {

        MyTimer=(AnimeController.value*100).toInt();
        ToBeShowedText = 'Next email verification request will be available in $MyTimer';
        if(AnimeController.value==0){
          Verif = MakeAvailable();
        }
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: ShowSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kInputTextFieldDecoration.copyWith(
                    hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kInputTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              //Colors.lightBlueAccent 'Log In'
              Hero(
                tag: 'LOGIN',
                child: RoundedButton(
                  text: 'Log In',
                  color: Colors.lightBlueAccent,
                  Fun: () async {
                    try {
                      setState(() {
                        ShowSpinner = true;
                      });
                      final newuser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);

                      if (newuser !=  null) {
                        setState(() {
                          ShowSpinner = false;
                        });
                        FirebaseUser user = await _auth.currentUser();
                        if (user.isEmailVerified) {
                          Navigator.pushNamed(context, ChatScreen.id);
                          Verif = Text('');
                          ToBeShowedText = '';
                        } else {
                          setState(() {
                            Verif = MakeAvailable();
                          });
                        }
                      }
                    } catch (e) {
                      print(e);
                      setState(() {
                        ShowSpinner = false;
                        ToBeShowedText = 'Wrong email or password.';
                      });
                      print(e);
                    }
                  },
                ),
              ),
              Center(
                child: Text(
                  ToBeShowedText,
                  style: TextStyle(color: Colors.lightBlue[900]),
                    textAlign: TextAlign.center,),
              ),
              Verif,
            ],
          ),
        ),
      ),
    );
  }
}
