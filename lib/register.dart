import 'package:aturuang_project/roundedbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';
//test
const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Color.fromARGB(242, 242, 242, 242),
  hintText: 'Fill A value',
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

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String email;
  late String password = '';
  late String Username;
  String passworderror = '';
  String usernameerror = '';
  bool _isObsecured = true;

  final RegExp emailRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{4,}$',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // const SizedBox(height: 5.0),
            SvgPicture.asset(
              'assets/undraw_my_password_re_ydq7.svg',
              height: 250,
              width: 250,
            ),
            const SizedBox(height: 5.0),
            Text('Username',
                style: TextStyle(
                    fontFamily: 'Poppins-Reguler',
                    fontSize: 15.0,
                    color: const Color.fromARGB(255, 20, 165, 162))),
            SizedBox(
              height: 5.0,
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter Username'),
              onChanged: (value) {
                Username = value;
                setState(() {
                  usernameerror = (Username.length >= 6)
                      ? ''
                      : 'Username at least 6 character';
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            if (usernameerror.isNotEmpty)
              Text(
                usernameerror,
                style: TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 10.0),
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
            const SizedBox(height: 20.0),
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
                setState(() {
                  password = value;
                  passworderror = (password.length >= 8)
                      ? ''
                      : 'Password at least 8 character';
                });
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
            SizedBox(height: 10.0),
            if (passworderror.isNotEmpty)
              Text(
                passworderror,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(
              height: 15.0,
            ),
            RoundedButton(
              colour: const Color.fromARGB(255, 20, 165, 182),
              title: 'Sign Up',
              onPressed: () async {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Already have an account ?',
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
                      Navigator.pushNamed(context, 'login_screen');
                    });
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromARGB(255, 20, 165, 182)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
