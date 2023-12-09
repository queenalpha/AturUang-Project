import 'package:aturuang_project/configuration/theme_config.dart';
import 'package:aturuang_project/configuration/roundedbutton.dart';
import 'package:aturuang_project/utils/fire_auth.dart';
import 'package:aturuang_project/utils/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.pushReplacementNamed(context, 'home');
    }
    return firebaseApp;
  }

  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  bool _isObsecured = true;
  String _errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 50, right: 50, top: 100, bottom: 15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SvgPicture.asset(
                'assets/undraw_load_more_re_482p.svg',
                height: 250,
                width: 250,
              ),
              const SizedBox(
                height: 5.0,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Email',
                            style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontSize: 15.0,
                                color: primaryTextColor)),
                        SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          controller: _emailTextController,
                          focusNode: _focusEmail,
                          validator: (value) => Validator.validateEmail(
                            email: value,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Enter your email'),
                          onTap: () {
                            setState(() {
                              _errorText = '';
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text('Password',
                            style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontSize: 15.0,
                                color: primaryTextColor)),
                        SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          controller: _passwordTextController,
                          focusNode: _focusPassword,
                          obscureText: _isObsecured,
                          onChanged: (value) {
                            setState(() {});
                          },
                          validator: (value) => Validator.isNotEmptyValidate(
                            value: value,
                          ),
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObsecured
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObsecured = !_isObsecured;
                                });
                              },
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _errorText = '';
                            });
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        if (_errorText.isNotEmpty)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _errorText,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12.0),
                            ),
                          ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _isProcessing
                                ? [const CircularProgressIndicator()]
                                : [
                                    RoundedButton(
                                      colour: primaryColor,
                                      title: 'Sign In',
                                      width: 200.0,
                                      height: 50.0,
                                      onPressed: () async {
                                        _focusEmail.unfocus();
                                        _focusPassword.unfocus();
                                        _errorText = '';

                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            _isProcessing = true;
                                          });

                                          User? user = await FireAuth
                                              .signInUsingEmailPassword(
                                            email: _emailTextController.text,
                                            password:
                                                _passwordTextController.text,
                                          );

                                          setState(() {
                                            _isProcessing = false;
                                          });

                                          if (user != null) {
                                            Navigator.pushReplacementNamed(
                                                context, 'home');
                                          } else {
                                            _errorText =
                                                'Your email or password is incorrect!';
                                          }
                                        }
                                      },
                                    )
                                  ]),
                      ])),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an account ?",
                    style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 12.0,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.pushReplacementNamed(context, 'register');
                        });
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: primaryTextColor,
                          fontFamily: 'Poppins-Regular',
                        ),
                      ),
                    ),
                  )
                ],
              )
            ]),
      ),
    );
  }
}
