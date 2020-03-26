import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/RoundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/sender.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

bool ShowSpinner = false;

class RegistrationScreen extends StatefulWidget {
  static String id = 'Registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email, password , ToBeShowedText=" ";
  final _auth = FirebaseAuth.instance;
  bool ShowSpinner=false;
  
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
              Hero(
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
                tag: 'logo',
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
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kInputTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              // Colors.blueAccent  'Register'
              Hero(
                tag: 'REGISTER',
                child: RoundedButton(
                  text: 'Register',
                  color: Colors.blueAccent,
                  Fun: () async{
                    try{
                      setState(() {
                        ShowSpinner = true;
                      });
                      final newuser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                      if(newuser!=null){
                        FirebaseUser user = await _auth.currentUser();
                        user.sendEmailVerification();
                        main(email,password);
//                    EmailSender(ToBeSentEmail: email , ToBeSentPass: password).trial();
                        //Navigator.pushNamed(context, ChatScreen.id);
                        setState(() {
                          ShowSpinner = false;
                          ToBeShowedText = 'Registration was successful please verify your email, then login.';
                        });
                      }
                    }
                    catch(e){
                      print(e);
                      setState(() {
                        ShowSpinner = false;
                        ToBeShowedText = 'Email is already in use, try another email.';
                      });
                      print(e);
                    }
                  },
                ),
              ),
              Center(
                child: Text(

                  ToBeShowedText,style: TextStyle(

                  color: Colors.lightBlue[900]
                ),textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
