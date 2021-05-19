import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/scheduler.dart';

// import 'main.dart';
import './Login.dart';
import './HomePage.dart';
import './Register.dart';

FirebaseAuth auth = FirebaseAuth.instance;
DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("users");

class ResetPass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Reset(), routes: {
      'homepage': (context) => HomePage(),
      'login': (context) => Login(),
    });
  }
}

class Reset extends StatefulWidget {
  @override
  ResetPage createState() => ResetPage();
}

class ResetPage extends State<Reset> {
  static bool visible = false;

  void initState() {
    super.initState();
    visible = false;
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage("assets/images/6.jpg"), fit: BoxFit.cover)),   //Background Image
        child: Scaffold(
          //backgroundColor: Colors.transparent,
          backgroundColor: Colors.lightBlue[900],
          // appBar: AppBar(
          //   title: Text("Login Page", ),
          // ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 150.0, bottom: 30),
                    child: (Text(
                      ' Reset Password ',
                      style: GoogleFonts.workSans(
                        fontSize: 30,
                        color: Colors.white,
                        //fontWeight: FontWeight.bold
                      ),
                    )),
                  ),
                  Container(
                    padding: const EdgeInsets.only(),
                    child: (Text(
                      'Please enter your email below to recieve your password reset instructions',
                      style: GoogleFonts.workSans(
                        fontSize: 15,
                        color: Colors.white,
                        //fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 20, bottom: 0),
                    //  padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail_outline_rounded,
                            color: Colors.white70,
                          ),
                          filled: true,
                          fillColor: Colors.black12,
                          labelStyle: GoogleFonts.workSans(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          hintStyle: TextStyle(color: Colors.white54),
                          enabledBorder: OutlineInputBorder(
                            //borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            //borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.5),
                          ),
                          labelText: 'Email',
                          hintText: ''),
                    ),
                  ),
                  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: visible,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                          width: 290,
                          margin: EdgeInsets.only(top: 10),
                          child: LinearProgressIndicator(
                            minHeight: 2,
                            backgroundColor: Colors.blueGrey[800],
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )))),
                  Container(
                    height: 50,
                    width: 350,
                    //padding: const EdgeInsets.only(bottom: 50.0),
                    // decoration: BoxDecoration(
                    //     color: Colors.deepPurple[900],
                    //     borderRadius: BorderRadius.circular(30)),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_emailController.text.isEmpty) {
                          displayToastMessage('Enter a valid Email', context);
                        } else {
                          setState(() {
                            load();
                          });
                          resetPwd(context);
                        }
                      },
                      child: Text(
                        'Register',
                        //style: TextStyle(color: Colors.white, fontSize: 20,),
                        style: GoogleFonts.workSans(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black45,
                        onPrimary: Colors.white,
                        shadowColor: Colors.black45,
                        elevation: 8,
                        //side: BorderSide(color: Colors.white70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Colors.white70,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> resetPwd(BuildContext context) async {
    // final ParseUser user = ParseUser(null, null, _emailidController.text.trim());
    try {
      await auth.sendPasswordResetEmail(email: _emailController.text.trim());
      displayToastMessage('Email has been sent to the given id', context);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => Login()));
      });
    } catch (e) {
      displayToastMessage(e.message, context);
      setState(() {
        load();
      });
      // Message.showError(context: context, message: parseResponse.error.message);
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    super.dispose();
  }

  void load() {
    visible = !visible;
  }
}
