import 'package:aturuang_project/pages/login.dart';
import 'package:aturuang_project/configuration/roundedbutton.dart';
import 'package:aturuang_project/configuration/theme_config.dart';
import 'package:aturuang_project/utils/validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aturuang_project/utils/fire_auth.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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

  final _registerFormKey = GlobalKey<FormState>();
  final _usernameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _focusUsername = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  bool _isProcessing = false;

  bool _isObsecured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 50, right: 50, top: 15, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SvgPicture.asset(
              'assets/undraw_my_password_re_ydq7.svg',
              height: 250,
              width: 250,
            ),
            const SizedBox(height: 5.0),
            Form(
                key: _registerFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Username',
                      style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontSize: 15.0,
                          color: primaryColor),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      controller: _usernameTextController,
                      focusNode: _focusUsername,
                      validator: (value) => Validator.validateUsername(
                        username: value,
                      ),
                      keyboardType: TextInputType.text,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter username'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const SizedBox(height: 10.0),
                    Text('Email',
                        style: TextStyle(
                            fontFamily: 'Poppins-Regular',
                            fontSize: 15.0,
                            color: primaryColor)),
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
                    ),
                    const SizedBox(height: 20.0),
                    Text('Password',
                        style: TextStyle(
                            fontFamily: 'Poppins-Regular',
                            fontSize: 15.0,
                            color: primaryColor)),
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
                      validator: (value) => Validator.validatePassword(
                        password: value,
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
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _isProcessing
                          ? [const CircularProgressIndicator()]
                          : [
                              RoundedButton(
                                colour: primaryColor,
                                title: 'Sign Up',
                                width: 200.0,
                                height: 50.0,
                                onPressed: () async {
                                  _focusUsername.unfocus();
                                  _focusEmail.unfocus();
                                  _focusPassword.unfocus();
                                  if (_registerFormKey.currentState!
                                      .validate()) {
                                    setState(() {
                                      _isProcessing = true;
                                    });

                                    User? user = await FireAuth
                                        .registerUsingEmailPassword(
                                      name: _usernameTextController.text,
                                      email: _emailTextController.text,
                                      password: _passwordTextController.text,
                                    );
                                    setState(() {
                                      _isProcessing = false;
                                    });

                                    if (user != null) {
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) => LoginScreen(),
                                        ),
                                        ModalRoute.withName('/'),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already have an account ?',
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
                                  Navigator.pushReplacementNamed(
                                      context, 'login');
                                });
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 12.0,
                                    color: primaryColor),
                              ),
                            )),
                      ],
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
