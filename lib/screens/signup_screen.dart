import 'package:flutter/material.dart';
import 'package:leaf/screens/mainBar_screen.dart';
import 'package:leaf/services/auth_service.dart';
import 'package:flutter/services.dart';

class SignupScreen extends StatefulWidget {
  static final String id = 'signup_screen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {


  final _formKey = GlobalKey<FormState>();
  String _name, _email, _password;

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      AuthService.signUpUser(context, _name, _email, _password);
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MainBarScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    /// StatusBar Text weiß machen
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    /// Keyboard bleibt unten sonst flipp ich aus
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    // Funktioniert nicht


    return Scaffold(
        backgroundColor: Color(0xff111e2e),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Account erstellen',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'UbuntuLight',
              fontSize: 24.0,
              color: Color(0xffE6EFE9),
            ),
          ),
          backgroundColor: Color(0xff111e2e),
          leading: IconButton(
            onPressed: () {FocusScope.of(context).unfocus(); Navigator.pop(context);},
            icon:Icon(
              Icons.arrow_back_ios,
              color: Color(0xffe8b641),
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
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
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                            child: TextFormField(
                              style: TextStyle(
                                color: Color(0xffE6EFE9),
                                fontFamily: 'UbuntuRegular',
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Color(0xffe8b641),
                                ),
                                contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                                labelText: 'Name',
                                labelStyle: TextStyle(
                                  color: Color(0xff4171AB),
                                  fontFamily: 'UbuntuRegular',
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff4171AB)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff0cce6b)),
                                ),
                              ),
                              validator: (input) => input.trim().isEmpty
                                  ? 'Please enter a valid name'
                                  : null,
                              onSaved: (input) => _name = input,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                            child: TextFormField(
                              style: TextStyle(
                                color: Color(0xffE6EFE9),
                                fontFamily: 'UbuntuRegular',
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: Color(0xffe8b641),
                                ),
                                contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                                labelText: 'E-Mail',
                                labelStyle: TextStyle(
                                  color: Color(0xff4171AB),
                                  fontFamily: 'UbuntuRegular',
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff4171AB)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff0cce6b)),
                                ),
                              ),
                              validator: (input) => !input.contains('@')
                                  ? 'Please enter a valid email'
                                  : null,
                              onSaved: (input) => _email = input,
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            child: TextFormField(
                              style: TextStyle(
                                color: Color(0xffE6EFE9),
                                fontFamily: 'UbuntuRegular',
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Color(0xffe8b641),
                                ),
                                contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                                labelText: 'Passwort',
                                labelStyle: TextStyle(
                                  color: Color(0xff4171AB),
                                  fontFamily: 'UbuntuRegular',
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff4171AB)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff0cce6b)),
                                ),
                              ),
                              validator: (input) => input.length < 6
                                  ? 'Password needs to be at least 6 characters long'
                                  : null,
                              onSaved: (input) => _password = input,
                              obscureText: true,
                            ),
                          ),
                          SizedBox(height: 64.0),
                          Padding(
                            padding: EdgeInsets.only(left: 16, right: 16, bottom: 32),
                            child: SizedBox(
                              width: double.maxFinite,
                              child: RaisedButton(
                                onPressed:  () {FocusScope.of(context).unfocus(); _submit();},
                                color: Color(0xff0cce6b),
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                ),
                                child: Text(
                                  'ANMELDEN',
                                  style: TextStyle(
                                    color: Color(0xff111e2e),
                                    fontSize: 14,
                                    fontFamily: 'UbuntuMedium',
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
              )
          ),
        ),
    );
  }
}
