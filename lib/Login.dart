import 'package:flutter/material.dart';
import 'package:flutter_application_1/ResetPass.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';

//import './main.dart';
import './Register.dart';
import './HomePage.dart';
import './ResetPass.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static bool _passwordVisible = false;
  static bool visible = false;
  static bool gvisible = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _emailidController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void initState() {
    super.initState();
    visible = false;
    gvisible = false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      home: Container(
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage("assets/images/6.jpg"), fit: BoxFit.cover)),     //Background Image
        child: Scaffold(
          key: _scaffoldKey,
          // backgroundColor:  Colors.transparent,
          backgroundColor: Colors.lightBlue[900],
          // appBar: AppBar(
          //   title: Text("Login Page", ),
          // ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 120.0, bottom: 0.0),
                    child: Text(
                      'Authentication',
                      style: GoogleFonts.workSans(
                        fontSize: 40,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 50.0),
                    child: Center(
                      child: Container(
                          //padding:
                            //  const EdgeInsets.only(top: 30.0, bottom: 30.0),
                          width: 200,
                          height: 150,
                          decoration: BoxDecoration(
                              //color: Colors.white10,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Image.asset('assets/images/auth.png')),
                    ),
                  ),
                  Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: _emailidController,
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
                          hintStyle: GoogleFonts.workSans(
                            color: Colors.white54,
                          ),
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
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0, bottom: 30.0),
                    //padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline_rounded,
                            color: Colors.white70,
                          ),
                          suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              }),
                          filled: true,
                          fillColor: Colors.black12,
                          labelStyle: GoogleFonts.workSans(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          hintStyle: GoogleFonts.workSans(
                            color: Colors.white54,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          labelText: 'Password',
                          hintText: ''),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 350,
                    // decoration: BoxDecoration(
                    //     color: Colors.deepPurple[900],
                    //     borderRadius: BorderRadius.circular(30)),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_emailidController.text.contains('@')) {
                          displayToastMessage('Invalid Email-ID', context);
                        } else if (_passwordController.text.length < 8) {
                          displayToastMessage(
                              'Password should be a minimum of 8 characters',
                              context);
                        } else {
                          setState(() {
                            visible = load(visible);
                          });
                          login();
                        }
                      },
                      child: Text(
                        'Login',
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
                  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: visible,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Container(
                              width: 320,
                              margin: EdgeInsets.only(),
                              child: LinearProgressIndicator(
                                minHeight: 2,
                                backgroundColor: Colors.blueGrey[800],
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )))),
                  Container(
                    height: 30,
                    width: 300,
                    child: TextButton(
                      onPressed: () {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ResetPass()));
                        });
                      },
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.workSans(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 350,
                    padding: EdgeInsets.only(top: 10),
                    // decoration: BoxDecoration(
                    //     color: Colors.deepPurple[900],
                    //     borderRadius: BorderRadius.circular(30)),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          gvisible = load(gvisible);
                        });
                        googleSignIn(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/google_logo.png"),
                              height: 30.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 55),
                              child: Text(
                                'Sign in with Google',
                                style: GoogleFonts.workSans(
                                  fontSize: 19,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  backgroundColor: Colors.transparent,
                                  letterSpacing: 0.0,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        // primary: Colors.black45,
                        primary: Colors.transparent,
                        onPrimary: Colors.white,
                        shadowColor: Colors.black45,
                        elevation: 8,
                        //side: BorderSide(color: Colors.white70,
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
                  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: gvisible,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Container(
                              width: 320,
                              margin: EdgeInsets.only(bottom: 20),
                              child: LinearProgressIndicator(
                                minHeight: 2,
                                backgroundColor: Colors.blueGrey[800],
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )))),
                  Container(
                    height: 30,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Register()));
                      },
                      child: Text(
                        'New User? Create Account',
                        style: GoogleFonts.workSans(
                          fontSize: 15,
                          color: Colors.white,
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

  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("users");

  Future<void> login() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        await auth.signInWithEmailAndPassword(
            email: _emailidController.text.trim(), password: _passwordController.text.trim());

        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()));
          //visible=!visible;
        });

        //displayToastMessage('',context);
      } catch (e) {
        //visible=!visible;
        setState(() {
          visible = load(visible);
        });
        displayToastMessage(e.message, context);
      }
    }
  }

  Future<void> googleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final User currentuser =
          (await auth.signInWithCredential(credential)).user;
      if (currentuser != null) {
        dbRef.child(currentuser.uid);
        Map userDataMap = {
          'name': currentuser.displayName,
          'email': currentuser.email,
        };
        dbRef.child(currentuser.uid).set(userDataMap);

        _formKey.currentState.save();

        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        });
        displayToastMessage('Account Created', context);
      } else {
        setState(() {
          gvisible = load(gvisible);
        });
        displayToastMessage('Account has not been created', context);
      }
    } catch (e) {
      setState(() {
        gvisible = load(gvisible);
      });
      displayToastMessage(e.message, context);
    }
  }

  bool load(visible) {
    return visible = !visible;
  }

  @override
  void dispose() {
    _emailidController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
