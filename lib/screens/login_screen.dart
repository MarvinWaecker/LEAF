import 'package:flutter/material.dart';
import 'package:leaf/screens/signup_screen.dart';
import 'package:leaf/services/auth_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // Logging in the user with Firebase
      AuthService.login(_email.trim(), _password);
      //Navigator.push(context, ScaleRoute(page: MainBarScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    /// StatusBar Text weiß machen
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: Color(0xff111e2e),
      body: Center(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 48, left: 90, right: 90),
                    child: Container(
                      alignment: Alignment.center,
                      child: Hero(
                        tag: 'startLogo',
                        child: Image.asset(
                          'assets/images/LEAF_Logo_mehr_Abstand.png',
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
                          child: TextFormField(
                            style: TextStyle(
                              color: Color(0xffE6EFE9),
                              fontFamily: 'UbuntuRegular',
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Color(0xffe8b641),
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                              labelText: 'E-Mail',
                              labelStyle: TextStyle(
                                fontFamily: 'UbuntuRegular',
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff4171AB)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff0cce6b)),
                              ),
                            ),
                            validator: (input) => !input.contains('@')
                                ? 'Please enter a valid email'
                                : null,
                            onSaved: (input) => _email = input,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 10.0),
                          child: TextFormField(
                            style: TextStyle(
                              color: Color(0xffE6EFE9),
                              fontFamily: 'UbuntuRegular',
                              fontSize: 16,
                            ),
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color(0xffe8b641),
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                              labelText: 'Passwort',
                              labelStyle: TextStyle(
                                fontFamily: 'UbuntuRegular',
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff4171AB)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff0cce6b)),
                              ),
                            ),
                            validator: (input) => input.length < 6
                                ? 'Password needs to be at least 6 characters long'
                                : null,
                            onSaved: (input) => _password = input,
                          ),
                        ),
                        SizedBox(height: 64.0),
                        Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: RaisedButton(
                              onPressed: _submit,
                              color: Color(0xff0cce6b),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                'EINLOGGEN',
                                style: TextStyle(
                                  color: Color(0xff111e2e),
                                  fontSize: 14,
                                  fontFamily: 'UbuntuMedium',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: SizedBox(
                            child: FlatButton(
                              onPressed: () {
                                {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                }
                                ;
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => SignupScreen()));
                              },
                              child: Text(
                                "ANMELDEN",
                                style: TextStyle(
                                  color: Color(0xffe8b641),
                                  fontFamily: 'UbuntuMedium',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
}
