import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/scheduler.dart';

// import 'main.dart';
import './Login.dart';
import './HomePage.dart';

FirebaseAuth auth = FirebaseAuth.instance;
DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("users");

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _RegisterPage(), routes: {
      'homepage': (context) => HomePage(),
      'login': (context) => Login(),
    });
  }
}

class _RegisterPage extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<_RegisterPage> {
  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;
  static bool visible = false;

  void initState() {
    super.initState();
    visible = false;
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _userPasswordController1 = TextEditingController();
  TextEditingController _userPasswordController2 = TextEditingController();

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
                    padding: const EdgeInsets.only(top: 150.0, bottom: 50),
                    child: (Text(
                      'Create Account',
                      style: GoogleFonts.workSans(
                        fontSize: 30,
                        color: Colors.white,
                        //fontWeight: FontWeight.bold
                      ),
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
                            // Based on passwordVisible state choose the icon
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
                            //gapPadding: 4.0,
                            //borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            //gapPadding: .0,
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
                        left: 15.0, right: 15.0, top: 10, bottom: 0),
                    //  padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: _usernameController,
                      keyboardType: TextInputType.name,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            // Based on passwordVisible state choose the icon
                            Icons.account_circle_outlined,
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
                            //gapPadding: 4.0,
                            //borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            //gapPadding: .0,
                            //borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.5),
                          ),
                          labelText: 'Full Name',
                          hintText: ''),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0, bottom: 0.0),
                    //padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _userPasswordController1,
                      obscureText: !_passwordVisible1,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            // Based on passwordVisible state choose the icon
                            Icons.lock_outline_rounded,
                            color: Colors.white70,
                          ),
                          suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible1
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible1 = !_passwordVisible1;
                                });
                              }),
                          filled: true,
                          fillColor: Colors.black12,
                          labelStyle: GoogleFonts.workSans(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          hintStyle: TextStyle(color: Colors.white54),
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
                                BorderSide(color: Colors.white, width: 1.5),
                          ),
                          //width: 16.0, color: Colors.lightBlue.shade50),
                          //bottom: BorderSide(width: 16.0, color: Colors.lightBlue.shade900),

                          labelText: 'New Password',
                          hintText: ''),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0, bottom: 40.0),
                    //padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: TextFormField(
                      controller: _userPasswordController2,
                      obscureText: !_passwordVisible2,
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            // Based on passwordVisible state choose the icon
                            Icons.lock_outline_rounded,
                            color: Colors.white70,
                          ),
                          suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible2
                                    ? Icons.visibility
                                    : Icons
                                        .visibility_off, // Based on passwordVisible state choose the icon
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible2 =
                                      !_passwordVisible2; // Update the state i.e. toogle the state of passwordVisible variable
                                });
                              }),
                          filled: true,
                          fillColor: Colors.black12,
                          labelStyle: GoogleFonts.workSans(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          hintStyle: TextStyle(color: Colors.white54),
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
                                BorderSide(color: Colors.white, width: 1.5),
                          ),
                          labelText: 'Confirm New Password',
                          hintText: ''),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 350,
                    //padding: const EdgeInsets.only(bottom: 50.0),
                    // decoration: BoxDecoration(
                    //     color: Colors.deepPurple[900],
                    //     borderRadius: BorderRadius.circular(30)),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_emailController.text.contains('@')) {
                          displayToastMessage('Enter a valid Email', context);
                        } else if (_usernameController.text.isEmpty) {
                          displayToastMessage('Enter your name', context);
                        } else if (_userPasswordController1.text.length < 8) {
                          displayToastMessage(
                              'Password should be a minimum of 8 characters',
                              context);
                        } else if (_userPasswordController1.text !=
                            _userPasswordController2.text) {
                          displayToastMessage(
                              'Passwords don\'t match', context);
                        } else {
                          setState(() {
                            load();
                            //   showInSnackBar('Processing...',context);
                          });
                          registerNewUser(context);
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
                  Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: visible,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Container(
                            width: 290,
                            margin: EdgeInsets.only(),
                            child: LinearProgressIndicator(
                              minHeight: 2,
                              backgroundColor: Colors.blueGrey[800],
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _userPasswordController1.dispose();
    _userPasswordController2.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  //final FirebaseAuth auth = FirebaseAuth.instance ;
  Future<void> registerNewUser(BuildContext context) async {
    User currentuser;
    try {
      currentuser = (await auth.createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _userPasswordController1.text.trim()))
          .user;
      if (currentuser != null) {
        dbRef.child(currentuser.uid);
        Map userDataMap = {
          'name': _usernameController.text.trim(),
          'email': _emailController.text.trim(),
        };
        dbRef.child(currentuser.uid).set(userDataMap);
        _formKey.currentState.save();
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        });
        showInSnackBar('Account Created', context);
      } else {
        setState(() {
          load();
          //   showInSnackBar('Processing...',context);
        });
        displayToastMessage('Account has not been created', context);
      }
    } catch (e) {
      setState(() {
        load();
        //   showInSnackBar('Processing...',context);
      });
      displayToastMessage(e.message, context);
    }
  }

  void load() {
    visible = !visible;
  }
}

displayToastMessage(String msg, BuildContext context) {
  Fluttertoast.showToast(msg: msg);
}

void showInSnackBar(String value, BuildContext context) {
  ScaffoldMessenger.of(context)
      .showSnackBar(new SnackBar(content: new Text(value)));
}
