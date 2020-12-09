import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formkey = new GlobalKey<FormState>();
  String _email;
  String _password;

  bool validate() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void registerUser() async {
    if (validate()) {
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _email, password: _password))
            .user;
        print('Signed up as: ${user.uid}');
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
                              padding:
                                  EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                              child: Text(
                                'Signup',
                                style: TextStyle(
                                    fontSize: 80.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(
                              top: 35.0, left: 20.0, right: 20.0),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'EMAIL',
                                      labelStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                      // hintText: 'EMAIL',
                                      // hintStyle: ,
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green))),
                                  validator: (value) => value.isEmpty
                                      ? 'Email can\'t be empty'
                                      : null,
                                  onSaved: (value) => _email = value),
                              SizedBox(height: 10.0),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'PASSWORD ',
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
                              SizedBox(height: 10.0),
                              /*TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'PHONE NUMBER ',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green))),
                              ),*/
                              SizedBox(height: 50.0),
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
                                            'SIGNUP',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Montserrat'),
                                          ),
                                        ),
                                      ),
                                    )),
                                onPressed: registerUser,
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                height: 40.0,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black,
                                          style: BorderStyle.solid,
                                          width: 1.0),
                                      color: Colors.transparent,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Center(
                                      child: Text('Go Back',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat')),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      // SizedBox(height: 15.0),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //     Text(
                      //       'New to Spotify?',
                      //       style: TextStyle(
                      //         fontFamily: 'Montserrat',
                      //       ),
                      //     ),
                      //     SizedBox(width: 5.0),
                      //     InkWell(
                      //       child: Text('Register',
                      //           style: TextStyle(
                      //               color: Colors.green,
                      //               fontFamily: 'Montserrat',
                      //               fontWeight: FontWeight.bold,
                      //               decoration: TextDecoration.underline)),
                      //     )
                      //   ],
                      // )
                    ]))));
  }
}
