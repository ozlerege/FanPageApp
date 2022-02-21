
import 'package:async/async.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_1/welcome_page.dart';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_auth/firebase_auth.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  String message = '';
  GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email'
      ]);
  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? _currentuser = _googleSignIn.currentUser;
      return Scaffold(
        backgroundColor: Colors.purple,
        body: FutureBuilder<bool>(
          future : checkAdmin(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
            if (snapshot.data == true) {
              return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  title: Text("Admin View"),
                  backgroundColor: Colors.red,
                ),
                body:Column(
                  children: [SizedBox(
                      height: 300,
                  ),
                    Center(
                child: FloatingActionButton.extended(
                      backgroundColor: Colors.red,
                  label: const Text('Add Message'),
                  icon: const Icon(Icons.check),

                      onPressed: (){
                      showDialog(context: context, builder:(context)
                      {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          content: Text("Send Message"),
                          actions: [Padding(
                            padding:EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                            child: TextField(
                              textAlign: TextAlign.center,
                              onChanged: (text){
                                message = text;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Enter Your Message",
                                labelStyle: TextStyle(color: Colors.red,),

                              ),
                            ),
                          ),
                            Container(
                              padding: const EdgeInsets.all(0.0),
                              color: Colors.white,
                              width: 200.0,
                              height: 100.0,
                              child:Center(
                                child:TextButton(
                                    child:Text("Add Message",
                                    ),
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Colors.red, // Background Color
                                    ),
                                    onPressed: () async {
                                      var firebaseUser =  FirebaseAuth.instance.currentUser;
                                      var time  = DateFormat('yyyy-MM-dd KK:mm').format(DateTime.now());
                                      firestore.collection("Messages").add({
                                        'message' : message,
                                        'time' : time,
                                      });


                                    }

                                ),
                              ),
                            ),


                          ],
                        );

                      });
                      },

                    ),

                    ),
                    SizedBox(height: 20),
                    FloatingActionButton.extended(
                      onPressed: () {
                        showDialog(context: context, builder:(context){
                          return AlertDialog(
                              backgroundColor: Colors.white,
                              content: Text("Are You Sure?"),
                              actions: [Padding(
                                padding:EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                child: TextButton(
                                    child:Text("Log Out"
                                      ,style: TextStyle(
                                        color: Colors.red,
                                      ),),
                                    onPressed: () async {
                                      try {
                                        _googleSignIn.signOut();
                                        final oldUser = await _auth.signOut();
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => HomeScreen()));

                                      }
                                      catch(e){
                                        print(e);
                                      }

                                    }




                                ),
                              ),
                                Padding(
                                  padding:EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                                  child: TextButton(
                                      child:Text("Back"
                                        ,style: TextStyle(
                                          color: Colors.red,
                                        ),),
                                      onPressed: () async {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => MainScreen()));
                                      }




                                  ),
                                ),]);
                        });
                      },
                      label: const Text('Log Out'),
                      icon: const Icon(Icons.check),
                      backgroundColor: Colors.red,
                    ),


                  ],

                )
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Text("User View"),
                  backgroundColor: Colors.green,
                ),
                  body:SafeArea(
                    child: Center(child: Column(children: [SizedBox(height: 300,),TextButton(
                        child:Text("See Messages",
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red, // Background Color
                        ),
                        onPressed: () async {
                          Future<List> _futureOfList = getMessages();
                          List list =   await _futureOfList ;
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MessageList()),
                          );}),
                      FloatingActionButton.extended(
                        onPressed: () {
                          showDialog(context: context, builder:(context){
                            return AlertDialog(
                                backgroundColor: Colors.white,
                                content: Text("Are You Sure?"),
                                actions: [Padding(
                            padding:EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          child: TextButton(
                              child:Text("Log Out"
                              ,style: TextStyle(
                                  color: Colors.red,
                                ),),
                              onPressed: () async {
                                try {

                                  final oldUser = await _auth.signOut();
                                  Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => HomeScreen()));

                                }
                                catch(e){
                                  print(e);
                                }

                              }




                          ),
                          ),
                                  Padding(
                                    padding:EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                                    child: TextButton(
                                        child:Text("Back"
                                          ,style: TextStyle(
                                            color: Colors.red,
                                          ),),
                                        onPressed: () async {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => MainScreen()));
                                        }




                                    ),
                                  ),]);
                          });
                        },
                        label: const Text('Log Out'),
                        icon: const Icon(Icons.check),
                        backgroundColor: Colors.red,
                      ),








                    ],),))


              );
            }
          }
      )
      );
    }
    }


class MessageList extends StatefulWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  _MessageListState createState() => _MessageListState();
}
final firestore = FirebaseFirestore.instance;
class _MessageListState extends State<MessageList> {
  @override
  Future <List> mylist = getMessages();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("User Messages"),
      backgroundColor: Colors.green,),
      body: FutureBuilder<List> (
        future: getMessages(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if(!snapshot.hasData){
            return Center (
              child: CircularProgressIndicator(),
            );
          }
          var counter = 1;
          List <Text> widgets = [];
          for(var message in snapshot.data!){
          final txt_widget = Text('$counter' ')''$message',style: TextStyle(fontWeight: FontWeight.bold, fontSize:30));
          widgets.add(txt_widget);
          counter = counter + 1;

          }
          return Center(child:
          Column (
            children: widgets,
          ),);

        }
      )
    );
  }
}



Future<List> getMessages() async{
  List message_list = [];
  final _auth = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

  final messages = await firestore.collection("Messages").get();
  for(var x in messages.docs){
    message_list.add(x.data()["message"]);
  }

  return message_list;


}








 Future<bool> checkAdmin() async{
  final _auth = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

 final DocumentSnapshot response = await firestore.collection("Users").doc(_auth?.email).get();
 var map = response.get("role");
if (map == "ADMIN"){
  //print('burda1');
   return Future<bool>.value(true);

  }
  //print('burda2');
 return Future<bool>.value(false);
 }

