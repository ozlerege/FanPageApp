import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';




class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {


  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  String userID = '';
  String firstName = '';
  String lastName = '';
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
                      child:Text("Back to Main Page",
                      style: TextStyle(
                        color: Colors.red,
                      ),),
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      }
                  ) ,
                ),
              ),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value){
                        userID = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter user id",
                      labelStyle: TextStyle(color: Colors.white,),
                  ),
                ),
              ),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value){
                    firstName = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter First Name",
                    labelStyle: TextStyle(color: Colors.white,),
                  ),
                ),
              ),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value){
                      lastName = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter Last Name",
                    labelStyle: TextStyle(color: Colors.white,),

                  ),
                ),
              ),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value){
                        email = value;

                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter E-mail Address",
                    labelStyle: TextStyle(color: Colors.white,),

                  ),
                ),
              ),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: TextField(
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value){
                    password = value;
                    },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter Password",
                    labelStyle: TextStyle(color: Colors.white,),

                  ),
                ),
              ),
                  Center(
                  child : Container(
                    padding: const EdgeInsets.all(0.0),
                    color: Colors.white,
                    width: 200.0,
                    height: 100.0,
                    child:Center(
                      child:TextButton(
                          child:Text("Register",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                          ),
                          onPressed: () async {
                            var firebaseUser =  FirebaseAuth.instance.currentUser;
                            var time  = DateFormat('yyyy-MM-dd KK:mm').format(DateTime.now());
                            firestore.collection("Users").doc(email).set({
                              'first_name' : firstName,
                              'last_name' : lastName,
                              'role' : 'default',
                              'userID' : userID,
                              'registration_time': time,
                              'email':email


                            });

                            try
                             {
                         final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                         if(newUser != null){
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
                  ),SizedBox(height: 15,),

                ],

              )

          )

        );

  }
}