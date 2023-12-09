import 'package:aturuang_project/roundedbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Color.fromARGB(242, 242, 242, 242),
  hintText: 'Enter a Value',
  hintStyle: TextStyle(
      color: Colors.grey, fontFamily: 'Poppins-Reguler', fontSize: 12),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
        BorderSide(color: Color.fromARGB(255, 20, 165, 182), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
);

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObsecured = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
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
              Text('Email',
                  style: TextStyle(
                      fontFamily: 'Poppins-Reguler',
                      fontSize: 15.0,
                      color: const Color.fromARGB(255, 20, 165, 162))),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text('Password',
                  style: TextStyle(
                      fontFamily: 'Poppins-Reguler',
                      fontSize: 15.0,
                      color: const Color.fromARGB(255, 20, 165, 162))),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                obscureText: _isObsecured,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObsecured ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObsecured = !_isObsecured;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              RoundedButton(
                colour: const Color.fromARGB(255, 20, 165, 182),
                title: 'Sign In',
                onPressed: () async {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an account ?",
                    style: TextStyle(
                        fontFamily: 'Poppins-Reguler',
                        fontSize: 12.0,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.pushNamed(context, 'register_screen');
                      });
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Color.fromARGB(255, 20, 165, 182)),
                    ),
                  )
                ],
              )
            ]),
      ),
    );
  }
}
