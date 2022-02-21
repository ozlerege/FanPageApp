import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'create_account.dart';
import 'welcome_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home:
      HomeScreen(),
      ),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: WelcomeScreen.id,
        routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        'login_screen':(context) => LoginPage(),
        'create_an_account_screen':(context) => CreateAccount(),
      },
    );
  }
}



