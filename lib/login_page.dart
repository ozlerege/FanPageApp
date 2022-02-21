import 'package:flutter/material.dart';
import 'package:mobile_app_1/welcome_page.dart';
import 'mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'main.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                width: 200,
                color:Colors.white,
                alignment: Alignment.center,
                child:SizedBox(
                  height: 50,
                  width: 200,
                  child:TextButton(
                      child:Text("Back to Main Page"),
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => WelcomeScreen()),
                        );
                      }
                  ) ,
                ),
              ),
              SizedBox(
                height: 200,
              ),
              Padding(
                  padding:EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                  onChanged: (value){
                  email = value;

        },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter e-mail",


            ),
        ),
              ),
              Padding(
                  padding:EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: TextField(
                    obscureText: true,
                      textAlign: TextAlign.center,
                      onChanged: (value){
                            password = value;
                        },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter Password",
                      ),
                  ),
              ),
              Container(
                height: 50,
                width: 200,
                color:Colors.white,
                alignment: Alignment.center,
                child:SizedBox(
                  height: 50,
                  width: 200,
                  child:TextButton(
                      child:Text("Login"),
                      onPressed: () async {
                        try {
                          final oldUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                          if(oldUser != null){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => MainScreen()));
                          }
                        }
                        catch(e){
                          print(e);
                        }

                      }




                  ),
                ),
              ),


            ],
          ),
        )
    );
  }
}