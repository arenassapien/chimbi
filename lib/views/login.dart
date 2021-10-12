import 'dart:convert';
import 'dart:io';

import 'package:chimbi/reusable/Constants.dart';
import 'package:chimbi/reusable/configs.dart';
import 'package:chimbi/views/alumnos/perfilAlumno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/classroom.courses',
      'https://www.googleapis.com/auth/classroom.coursework.me',
      'https://www.googleapis.com/auth/classroom.coursework.students',
      'https://www.googleapis.com/auth/classroom.profile.emails',
      'https://www.googleapis.com/auth/classroom.student-submissions.me.readonly',
      'https://www.googleapis.com/auth/classroom.rosters',
      'https://www.googleapis.com/auth/classroom.rosters.readonly',
      'https://www.googleapis.com/auth/classroom.profile.emails',
      'https://www.googleapis.com/auth/classroom.profile.photos'
    ],
  );
  GoogleSignInAccount? _currentUser;
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _contactText = '';

  checkIsiPad() async {
    bool checkSize = await Config().isIpad();
    setState(() {
      isiPad = checkSize;
    });
  }

  Future<void> _handleSignIn() async {
    try {
      print("hello");
      await _googleSignIn.signIn();

      if (_currentUser != null) {
        _contactText = _currentUser!.displayName!;
        email = _currentUser!.email;
        displayName = _currentUser!.displayName!;
        photoUrl = _currentUser!.photoUrl!;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PerfilAlumno(),
            ));
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsiPad();
    _googleSignIn.signInSilently();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _contactText = _currentUser!.displayName!;
        email = _currentUser!.email;
        displayName = _currentUser!.displayName!;
        photoUrl = _currentUser!.photoUrl!;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PerfilAlumno(),
            ));
      }
    });

  }

  Widget mobileLogin() {
    return ListView(
      children: [
        Image.asset(
          "images/appLogos/chimbi_logo.png",
          height: 200,
        ),
        Card(
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: userController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                  fontFamily: 'Caredrock',
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0),
              decoration: InputDecoration(
                disabledBorder: InputBorder.none,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Ingresa tu usuario / correo institucional',
                hintStyle: TextStyle(inherit: true, color: Colors.grey[400]),
              ),
            ),
          ),
        ),
        Card(
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              autofocus: false,
              autocorrect: false,
              style: TextStyle(
                  fontFamily: 'Caredrock',
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0),
              decoration: InputDecoration(
                disabledBorder: InputBorder.none,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Ingresa tu contraseña',
                hintStyle: TextStyle(inherit: true, color: Colors.grey[400]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget ipadLogin() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 4,
              child: Image.asset(
                "images/appLogos/chimbi_logo.png",
                height: 300,
              )),
          Expanded(
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: userController,
                      autofocus: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          fontFamily: 'Caredrock',
                          color: Colors.black87,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.0),
                      decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Ingresa tu usuario / correo institucional',
                        hintStyle:
                            TextStyle(inherit: true, color: Colors.grey[400]),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      autofocus: false,
                      autocorrect: false,
                      style: TextStyle(
                          fontFamily: 'Caredrock',
                          color: Colors.black87,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.0),
                      decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Ingresa tu contraseña',
                        hintStyle:
                            TextStyle(inherit: true, color: Colors.grey[400]),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "INICIAR SESIÓN",
                    style: TextStyle(
                        fontFamily: 'Caredrock',
                        color: blueChimbi,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100.0, vertical: 5),
                  child: OutlinedButton(
                      onPressed: _handleSignIn,
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/icons/google-logo.png",
                            height: 40,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Iniciar con Google",
                            style: TextStyle(
                                fontFamily: 'Dense',
                                color: Colors.grey[700],
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.0),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                ),
                Text(
                  _contactText,
                  style: TextStyle(
                      fontFamily: 'Dense',
                      color: Colors.grey[900],
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: CupertinoPageScaffold(
            child: GestureDetector(
              child: isiPad ? ipadLogin() : mobileLogin(),
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
            ),
            backgroundColor: Colors.grey[100]),
      ),
    );
  }
}
