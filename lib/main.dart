import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


import 'Login.dart';
import './HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainPage());
}

String initialroute;

class MainPage extends StatefulWidget {
  @override
  _Splashscreen createState() => _Splashscreen();
}

class _Splashscreen extends State<MainPage> {
  void initState() {
    super.initState();
    this.isUserLoggedIn(context);
  }

  void isUserLoggedIn(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
        initialroute = 'login';
      } else {
        print('User is signed in!');
        initialroute = 'homepage';
      }
    });
  }

   @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Login(), initialRoute: initialroute, routes: {
      'homepage': (context) => HomePage(),
      'login': (context) => Login(),
    });
    
  }
}

// class _Splash extends StatelessWidget {
 
//   }
// }
