import 'package:flutter/material.dart';
import 'package:mobile_app_1/create_account.dart';
import 'main.dart';
import 'login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'mainscreen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';


  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email'
      ]);
  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? _currentuser = _googleSignIn.currentUser;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 400,
              ),
              Center(
                child:Container(
                  height: 50,
                  width: 200,
                  color:Colors.white,
                  alignment: Alignment.center,
                  child:SizedBox(
                    height: 50,
                    width: 200,
                    child:TextButton(
                        child:Text("Create An Account",
                          style: TextStyle(
                              color: Colors.black
                          ),),
                        onPressed: (){
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => CreateAccount()),
                          );
                        }
                    ) ,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child:Container(
                  height: 50,
                  width: 200,
                  color:Colors.white,
                  alignment: Alignment.center,
                  child: TextButton(

                      child:Text("Login",
                        style: TextStyle(
                          color: Colors.black,
                        ),),
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      }
                  ) ,
                ) ,
              ),
              SizedBox(height: 30,),
              Container(
                padding: const EdgeInsets.all(0.0),
                color: Colors.white,
                width: 200.0,
                height: 100.0,
                child:Center(
                  child:TextButton(
                      child:Text("Login with Google",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () async {
                        _currentuser = await _googleSignIn.signIn();
                        if(_currentuser != null) {
                          Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen()),


                          );
                        }
                        }




                  ),
                ),
              ),],
          )
      ),

    );
  }
}
