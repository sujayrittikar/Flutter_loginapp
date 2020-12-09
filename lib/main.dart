import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginapp/chat.dart';
import 'signup.dart';
import 'auth.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage()
      },
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.auth});
  final BaseAuth auth;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _MyHomePageState extends State<MyHomePage> {
  final formkey = new GlobalKey<FormState>();

  AuthStatus _authStatus = AuthStatus.notSignedIn;
  String _email;
  String _password;

  bool validateAndSave() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: _email, password: _password))
            .user;
        _authStatus = AuthStatus.signedIn;
        print('Signed in: ${user.uid}');
      } catch (e) {
        print('Error: $e');
      }
    }
    formkey.currentState.reset();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new Container(
            child: new Form(
                key: formkey,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                            child: Text('Meet',
                                style: TextStyle(
                                    fontSize: 80.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(16.0, 190.0, 0.0, 0.0),
                            child: Text('CHIKITSAK',
                                style: TextStyle(
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(260.0, 175.0, 0.0, 0.0),
                            child: Text('.',
                                style: TextStyle(
                                    fontSize: 80.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green)),
                          )
                        ],
                      ),
                    ),
                    Container(
                        padding:
                            EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'EMAIL',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                              validator: (value) => value.isEmpty
                                  ? 'Email can\'t be empty'
                                  : null,
                              onSaved: (value) => _email = value,
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'PASSWORD',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                              validator: (value) => value.isEmpty
                                  ? 'Password can\'t be empty'
                                  : null,
                              onSaved: (value) => _password = value,
                              obscureText: true,
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              alignment: Alignment(1.0, 0.0),
                              padding: EdgeInsets.only(top: 15.0, left: 20.0),
                              child: InkWell(
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            new RaisedButton(
                              child: Container(
                                height: 40.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: Colors.greenAccent,
                                  color: Colors.green,
                                  elevation: 7.0,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Center(
                                      child: Text(
                                        'LOGIN',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                if (validateAndSave()) {
                                  try {
                                    FirebaseUser user = (await FirebaseAuth
                                            .instance
                                            .signInWithEmailAndPassword(
                                                email: _email,
                                                password: _password))
                                        .user;
                                    _authStatus = AuthStatus.signedIn;
                                    print('Signed in: ${user.uid}');
                                  } catch (e) {
                                    print('Error: $e');
                                  }
                                }
                                formkey.currentState.reset();
                                switch (_authStatus) {
                                  case AuthStatus.notSignedIn:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignupPage()));
                                    break;
                                  case AuthStatus.signedIn:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatPage()));
                                    _authStatus = AuthStatus.notSignedIn;
                                }
                              },
                            ),
                            SizedBox(height: 20.0),
                          ],
                        )),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'New to CHIKITSAK ?',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                        SizedBox(width: 5.0),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/signup');
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.green,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    )
                  ],
                ))));
  }
}
